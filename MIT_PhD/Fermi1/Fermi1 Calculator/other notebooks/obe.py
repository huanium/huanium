from scipy.integrate import solve_ivp
import numpy as np
import matplotlib.pyplot as plt
from tqdm import tqdm


def construct_fun(pulse, rabi_freq_max, delta, t1, t2, bloch_vec0, **kwargs):
    """
    Return function for solving OBE with scipy.integrate.solve_ivp based on pulse, detuning, t1 (population decay), t2 (dephasing), and initial Bloch vector.
    """
    if pulse == 'square':
        def rabi_freq(t): return rabi_freq_max
    elif pulse == 'blackman':
        t_blackman = kwargs['t_blackman']

        def rabi_freq(t): return rabi_freq_max * (
            0.42
            - 0.5 * np.cos(2 * np.pi * t / t_blackman)
            + 0.08 * np.cos(4 * np.pi * t / t_blackman)
        )
    else:
        raise ValueError('pulse type unsupported.')

    def fun(t, y):
        """
        Returns 3x1 array dy/dt, where y = [u,v,w] from the OBE.
        """
        matrix = np.array([
            [-1/t2, delta, 0],
            [-delta, -1/t2, rabi_freq(t)],
            [0, -rabi_freq(t), -1/t1]
        ])
        return (matrix.dot(y.T)).T + np.array([0, 0, bloch_vec0[-1]/t1])

    return fun


def convert_to_pop(w):
    """
    Returns population in excited state, a float between 0 and 1, assuming no population loss.
    """
    return (1-w)/2


def get_rabi_oscillations(
    pulse,
    delta,
    rabi_freq_max,
    t_max,
    n_points=1000,
    t1=np.infty,
    t2=np.infty,
    bloch_vec0=np.array([0, 0, 1])
):
    """
    Return 2 ndarrays of times and ground-state populations based on varying pulse lengths.

    NOTE: The non-square pulse is NOT truncated at each sample time, but instead dilated to fill up to each sample time.

    Args:
    - pulse: 'square' or 'blackman'
    - delta: detuning (float)
    - rabi_freq_max: (float)
    - t_max: maximum time of evolution (float)
    - n_points: number of sampled time points. NOT the same as the time steps used in the RK45 solver!
    - <others>: see docstring of construct_fun.
    """
    if pulse == 'square':
        fun = construct_fun('square', rabi_freq_max, delta, t1,
                            t2, bloch_vec0)
        sol = solve_ivp(fun, t_span=[0, t_max], y0=bloch_vec0,
                        t_eval=np.linspace(0, t_max, n_points))
        times, populations = sol['t'], convert_to_pop(sol['y'][-1])
    elif pulse == 'blackman':
        w = np.zeros(n_points)  # w as in conventional notation for OBE
        for idx, my_time in tqdm(enumerate(np.linspace(0, t_max, n_points))):
            if my_time == 0:
                w[idx] = bloch_vec0[-1]
            else:
                fun = construct_fun('blackman', rabi_freq_max, delta, t1,
                                    t2, bloch_vec0, t_blackman=my_time)
                sol = solve_ivp(fun, t_span=[0, my_time], y0=bloch_vec0,
                                t_eval=np.array([0, my_time]))
                w[idx] = sol['y'][-1][-1]
        times, populations = np.linspace(
            0, t_max, n_points), convert_to_pop(w)
    return times, populations


def get_spectrum(
    pulse,
    delta,
    rabi_freq_max,
    t_max,
    t1=np.infty,
    t2=np.infty,
    bloch_vec0=np.array([0, 0, 1])
):
    """
    Return 2 ndarrays of times and ground-state populations based on varying pulse lengths.

    NOTE: The non-square pulse is NOT truncated at each sample time, but instead dilated to fill up to each sample time.

    Args:
    - pulse: 'square' or 'blackman'
    - delta: detuning (float)
    - rabi_freq_max: (float)
    - t_max: maximum time of evolution (float)
    - n_points: number of sampled time points. NOT the same as the time steps used in the RK45 solver!
    - <others>: see docstring of construct_fun.
    """
    populations = np.zeros_like(delta)
    for idx, my_detuning in tqdm(enumerate(delta)):
        fun = construct_fun(pulse, rabi_freq_max, my_detuning, t1,
                            t2, bloch_vec0, t_blackman=t_max)
        sol = solve_ivp(fun, t_span=[0, t_max], y0=bloch_vec0,
                        t_eval=[0, t_max])
        populations[idx] = convert_to_pop(sol['y'][-1][-1])
    return populations