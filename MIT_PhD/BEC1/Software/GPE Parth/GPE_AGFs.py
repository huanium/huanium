import h5py
import numpy as np
import matplotlib.pyplot as plt
import scipy.optimize
from tqdm.notebook import tqdm
from IPython.display import display
import scipy.integrate
import scipy.special
import scipy.ndimage
import os
import time

# Constants
pi = np.pi
twopi = 2 * pi
h = 6.62607004 * 1e-34
hbar = h / twopi
mass_amu = 1.66053906660e-27
mass_87Rb = 86.9092 * mass_amu
a0 = 5.29 * 1e-11 # Bohr Radius

class Environment():
    """
    The Environment class contains everything that is not directly related to the wavefunction.
    This includes potentials, numbers of atoms, and more
    Many of the parameters do not change over an experiment. Others are settings for various experiments.
    Grid Related:
        - grid_points: number of points for the position grid. Use powers of 2
        - grid_range: in um
    Interactions and atoms related
        - N_atoms: number of atoms
        - omega_z:
        - scattering_length: (default 100 a0)
        - mass: (default 87RB)
    Variable parameters:
        - V: external potential
    Saving Related:
        - save_sim: True / False
        - save_folder: string
        - save_level: 0, 1, or 2
    """


    def __init__(self, grid_points=128, grid_range=15, N_atoms=10e3,
                 wz=twopi*1e3, scattering_length=100*a0, mass=mass_87Rb,
                 save_sim=True, save_folder='default_name', save_level=0):
        ### Grid
        self.grid_points = grid_points
        self.grid_range = grid_range
        # setting up real space grid
        self.x = np.linspace(-grid_range*1e-6, grid_range*1e-6, grid_points)
        self.dx = self.x[1] - self.x[0]
        self.Lx = self.x.max() - self.x.min()
        self.y = np.linspace(-grid_range*1e-6, grid_range*1e-6, grid_points)
        self.dy = self.y[1] - self.y[0]
        self.Ly = self.y.max() - self.y.min()
        self.dV = self.dx * self.dy
        self.X, self.Y = np.meshgrid(self.x, self.y)
        self.Rsq = self.X**2 + self.Y**2
        self.R = np.sqrt(self.Rsq)
        self.phi = np.arctan2(self.Y, self.X)
        # setting up momentum space grid
        self.kx = twopi * np.fft.fftfreq(len(self.x), self.dx)
        self.dkx = self.kx[1] - self.kx[0]
        self.Lkx = self.kx.max() - self.kx.min()
        self.ky = twopi * np.fft.fftfreq(len(self.y), self.dy)
        self.dky = self.ky[1] - self.ky[0]
        self.Lky = self.ky.max() - self.ky.min()
        self.dK = self.dkx * self.dky
        self.kX, self.kY = np.meshgrid(self.kx, self.ky)
        self.ksq = self.kX**2 + self.kY**2
        self.ksq_cutoff = self.ksq

        ### Interaction and atoms
        self.N_atoms = N_atoms
        self.wz = wz
        self.scattering_length = scattering_length
        self.mass = mass
        self.a_z = np.sqrt(hbar / (self.mass * self.wz)) # h.o. length
        self.g_2d = np.sqrt(8*np.pi) * (hbar**2/self.mass) * self.scattering_length / self.a_z

        ### External Potential
        self.V = np.zeros((self.grid_points, self.grid_points))

        ### Vector potential -- Landau Ax gauge
        self.gauge = 'Landau' # default gauge
        self.Bz = np.zeros((self.grid_points, self.grid_points))
        self.Ax = np.zeros((self.grid_points, self.grid_points))
        self.dxAx = np.zeros((self.grid_points, self.grid_points))

        ### Vector potential -- Coulomb Ax(y), Ay(x) gauge
        self.Bz = np.zeros((self.grid_points, self.grid_points))
        self.Ax = np.zeros((self.grid_points, self.grid_points))
        self.Ay = np.zeros((self.grid_points, self.grid_points))

        ### Save information
        self.save_sim = save_sim
        self.save_folder = save_folder
        self.save_level = save_level
        # Create folder for storage
        if not os.path.exists(self.save_folder):
            os.makedirs(self.save_folder)
        # Start text file
        file_loc = os.path.join(self.save_folder, 'Sim Info.txt')
        with open(file_loc, 'a') as text_file:
            text_file.write("\nEnvironment (re)initialized\n")
            text_file.write("===========================\n")

    def add_k_cutoff(self, k_cutoff=np.pi/1e-6, sigma_px=4, amp_frac=1e-3, plot=False):
        self.k_cutoff = k_cutoff
        self.sigma_px = sigma_px
        self.amp_frac = amp_frac
        self.sigma = self.dkx * self.sigma_px
        self.ksq_cutoff = self.ksq - 1j * erf_shifted(
            self.ksq**0.5, self.k_cutoff,
            sigma = self.sigma,
            amp = self.amp_frac*(self.k_cutoff**2)
        )
        print("")
        if plot:
            fig, axs = plt.subplots(ncols=2, figsize=[8, 3.5])
            plt.sca(axs[1])
            plt.pcolor(np.fft.fftshift(self.kx), np.fft.fftshift(self.ky), np.imag(np.fft.fftshift(self.ksq_cutoff)))
            theta = np.linspace(0, 2*np.pi, 100)
            x = k_cutoff * np.cos(theta)
            y = k_cutoff * np.sin(theta)
            plt.plot(x, y, 'w-')
            plt.colorbar()
            plt.title('Im[$k^2$]')

            plt.sca(axs[0])
            plt.pcolor(np.fft.fftshift(self.kx), np.fft.fftshift(self.ky), np.real(np.fft.fftshift(self.ksq_cutoff)))
            theta = np.linspace(0, 2*np.pi, 100)
            x = k_cutoff * np.cos(theta)
            y = k_cutoff * np.sin(theta)
            plt.plot(x, y, 'w-')
            plt.colorbar()
            plt.title('Re[$k^2$]')
            plt.tight_layout()
            file_loc = os.path.join(self.save_folder, 'env_k_cutoff.pdf')
            plt.savefig(file_loc)

    def TF_apprx(self,):
        def find_mu0(mu0):
            density = (mu0 - np.real(self.V)) / self.g_2d
            density[density<0] = 0
            return np.sum(density)*self.dV - self.N_atoms
        self.mu0 = scipy.optimize.root(find_mu0, np.max(np.real(self.V))).x[0]
        self.healing_length = np.sqrt(hbar**2 / (2*self.mass*self.mu0))
        density = (self.mu0 - self.V) / self.g_2d
        density[density<0] = 0
        self.Psi_TF = (1 + 0j) * np.sqrt(density)
        self.energy_TF = energy_noAG(self.Psi_TF, np.real(self.V), self.g_2d, self.ksq, self.dV, self.N_atoms, self.dK, self.mass)[0]
        # TF_radius is calculated in the funcion that sets up the potential

    def harmonic_potential(self, wx, wy):
        self.wx = wx
        self.wy = wy
        self.omega = (self.wx * self.wy)**(1/2) # geometric mean
        self.V = ((1/2 * self.mass * self.wx**2 * self.X**2) +
                  (1/2 * self.mass * self.wy**2 * self.Y**2))
        self.TF_apprx() # calculate quantities in the TF approximation
        self.TF_radius = np.sqrt((4*self.mu0)/(self.mass*(wx**2 + wy**2)))
        self.B0_crit = (5*hbar/self.TF_radius**2) * np.log(0.67*self.TF_radius/self.healing_length) #eqn 14.39 BEC
        self.system_scales()

    def harmonic_potential_abs(self, wx, wy, abs_amp=0, abs_sigma=1e-6):
        self.wx = wx
        self.wy = wy
        self.omega = (self.wx * self.wy)**(1/2) # geometric mean
        self.V = ((1/2 * self.mass * self.wx**2 * self.X**2) +
                  (1/2 * self.mass * self.wy**2 * self.Y**2))
        self.TF_apprx() # calculate quantities in the TF approximation
        self.abs_amp = abs_amp
        self.abs_sigma = abs_sigma
        if self.abs_amp != 0:
            self.V = self.V - 1j*erf_shifted(self.R, self.Lx/2, sigma=self.abs_sigma, amp=self.abs_amp*self.mu0)
        self.TF_radius = np.sqrt((4*self.mu0)/(self.mass*(wx**2 + wy**2)))
        self.B0_crit = (5*hbar/self.TF_radius**2) * np.log(0.67*self.TF_radius/self.healing_length) #eqn 14.39 BEC
        self.system_scales()

    def add_gradient_potential(self, mx=0, my=0):
        mx = - mx * self.mu0 / (10*self.length_scale)
        my = - my * self.mu0 / (10*self.length_scale)
        self.V = self.V + self.X*mx + self.Y*my

    def lattice_potential(self, wl, s):
        self.wl = wl
        self.k_L = twopi /self.wl
        self.recoil_energy = hbar**2 * (twopi /wl)**2 / (2 * mass_87Rb)
        self.recoil_energy_label = r"$E_L$"
        self.V0 = s * self.recoil_energy
        self.V_L = self.V0 * np.sin(self.k_L * self.X)**2
        self.V = self.V + self.V_L
        self.k_scale = self.k_L   # override default k-scale to lattice k
        self.k_scale_label = r"k_L"

    def magnetic_field_uniform(self, B0, use_gauge='Landau', epsilon=0):
        if use_gauge == 'Landau':
            self.gauge = 'Landau'
            self.B0 = B0
            self.Bz = B0 * np.ones((self.grid_points, self.grid_points))
            self.Ax = - B0 * self.Y
            self.dxAx = np.zeros((self.grid_points, self.grid_points))
            self.num_vortices_expected = self.B0*self.TF_radius**2/(2*hbar)
            file_loc = os.path.join(self.save_folder, 'Sim Info.txt')
            with open(file_loc, 'a') as text_file:
                text_file.write("Uniform magnetic field: Landau\n")
        else:
            self.gauge = 'Coulomb'
            self.epsilon = epsilon
            self.B0 = B0
            self.Bz = B0 * np.ones((self.grid_points, self.grid_points))
            self.Ax = - B0 * (1-epsilon) * self.Y
            self.Ay = B0 * epsilon * self.X
            self.num_vortices_expected = self.B0*self.TF_radius**2/(2*hbar)
            file_loc = os.path.join(self.save_folder, 'Sim Info.txt')
            with open(file_loc, 'a') as text_file:
                text_file.write(f"Uniform magnetic field: Coulomb with epsilon = {epsilon}\n")

    def magnetic_field_rand_gaussian(self, B0_avg, B0_std, seed=None, res=1e-6):
        np.random.seed(seed)
        B0_std_gen = B0_std*(res/self.dx)**2/2
        Bz_random = np.random.normal(loc=B0_avg, scale=B0_std_gen, size=self.X.shape)
        Bz = scipy.ndimage.gaussian_filter(Bz_random, sigma = res/self.dx)
        # Bz = Bz_random
        self.Ax, self.dxAx, self.Bz = VectorPotentialFromBz(Bz, self.dx, self.dy)
        # self.B0 = np.mean(self.Bz)
        self.B0 = np.std(self.Bz)
        self.num_vortices_expected = -1
        ### NOTE: Need to add coulomb gauge stuff

    def magnetic_field_rand_fourier_series(self, B0_avg, B0_std, k_cutoff, seed=None):
        a_nm = np.random.normal(loc=0, scale=1, size=self.kX.shape)
        b_nm = np.random.normal(loc=0, scale=1, size=self.kX.shape)
        a_nm[np.sqrt(self.ksq) > k_cutoff] = 0
        b_nm[np.sqrt(self.ksq) > k_cutoff] = 0
        a_nm[np.sqrt(self.ksq) == 0] = 0
        Bz = np.zeros_like(self.X)
        for n in range(self.kX.shape[1]):
            for m in range(self.kX.shape[0]):
                Bz += (
                    a_nm[n,m] * np.cos(self.kx[n]*self.X + self.ky[m]*self.Y) +
                    b_nm[n,m] * np.sin(self.kx[n]*self.X + self.ky[m]*self.Y)
                )
        Bz = Bz * B0_std/np.std(Bz)
        Bz = Bz + B0_avg - np.mean(Bz)
        self.Ax, self.dxAx, self.Bz = VectorPotentialFromBz(Bz, self.dx, self.dy)
        # self.B0 = np.mean(self.Bz)
        self.B0 = np.std(self.Bz)
        self.num_vortices_expected = -1
        ### NOTE: Need to add coulomb gauge stuff

    def system_scales(self,):
        # length, time, energy, B, :: w.f., prob.
        self.length_scale = 1e-6
        self.length_scale_label = r'um'
        self.k_scale = 1 / self.length_scale
        self.k_scale_label = f"1/{self.length_scale_label}"
        self.wf_scale = 1 / self.length_scale
        self.wf_scale_label = r"$1 / \mu$m"
        self.prob_scale = 1 / self.length_scale**2
        self.prob_scale_label = r"$1 / \mu$m$^2$"
        self.time_scale = 1 / (self.omega / twopi)
        self.time_scale_label = 'trap period T'
        self.energy_scale = self.energy_TF
        self.energy_scale_label = 'TF gs'
        self.B_scale = self.mass * self.omega
        self.B_scale_label = r'$m \omega$'
        self.E_cyclotron = 0.2985**2 * np.pi * (self.TF_radius/self.length_scale)**2 * (self.omega/(twopi))

    def plot_potential(self, ax=None):
        if ax is None:
            fig, ax = plt.subplots()
        plt.sca(ax)
        plt.pcolor(self.X*1e6, self.Y*1e6, np.real(self.V/self.mu0))
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel='x (um)', ylabel='y (um)', title=r'V / $\mu_0$')

    def plot_lattice_potential(self, ax=None):
        if ax is None:
            fig, ax = plt.subplots()
        plt.sca(ax)
        plt.pcolor(self.X*1e6, self.Y*1e6, np.real(self.V_L/self.mu0))
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel='x (um)', ylabel='y (um)', title=r'V_L / $\mu_0$')

    def plot_magnetic_field(self, ax=None):
        if ax is None:
            fig, ax = plt.subplots()
        plt.sca(ax)
        plt.pcolor(self.X*1e6, self.Y*1e6, self.Bz/self.B_scale, cmap='bwr')
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel='x (um)', ylabel='y (um)', title=r'$B_z(x, y)~/~(m \omega)$')

    def plot_env(self, axs=None, save_name='default'):
        if axs is None:
            fig, axs = plt.subplots(ncols=2, figsize=[8, 3.5])
        self.plot_potential(axs[0])
        self.plot_magnetic_field(axs[1])
        plt.tight_layout()
        file_loc = os.path.join(self.save_folder, f'env_{save_name}.pdf')
        plt.savefig(file_loc)

    def __str__(self,):
        str =  f'''
Environment information:
Grid spec: dx = {self.dx/1e-9:.0f} nm, L = {self.Lx/1e-6:.1f} um, points {self.grid_points}x{self.grid_points} = {self.grid_points**2}.
           dkx = {self.dkx / (1/1e-6):.3f} 1/um = {self.dkx/self.k_scale:.3f} {self.k_scale_label}
           L_k ~ {self.Lkx / (1/1e-6):.0f} 1/um = {self.Lkx/self.k_scale:.2f} {self.k_scale_label}
Atom number = {self.N_atoms/1e3:.1f} x 10^3, mass = {self.mass/mass_amu:.3f} amu.
Trap frequencies: wx = {self.wx/(twopi):.2f}, wy = {self.wx/(twopi):.2f}, omega = {self.omega/(twopi):.2f} Hz

Interaction parameter g_2d = {self.g_2d/(hbar**2/self.mass):.2f} hbar^2/m,
using {self.wz/(1e3*twopi):.2f} kHz tight trap freq.
TF approximation for chosen potential:
mu0 = h x {self.mu0/h:.1f} Hz, radius = {self.TF_radius/1e-6:.1f} um, healing length = {self.healing_length/1e-9:.0f} nm.
energy per atom = h x {self.energy_TF/(h * self.N_atoms):.1f} Hz.

E_cyclotron = {self.E_cyclotron:.1f} Hz
        '''
        try: str += f'''
K_cutoff inputs: k_cutoff = {self.k_cutoff:.0f} (pi/um), sigma_px = {self.sigma_px}, amp_frac = {self.amp_frac},
                 sigma = {self.sigma:.0f} [dx * (pi/um)]'''
        except: pass
        try: str += f'''
Lattice potential: lambda = {self.wl/1e-6:.0f} um, depth = {self.V0/self.recoil_energy:.2f} E_L'''
        except: pass
        try: str += f'''
Magnetic field:
Using {self.gauge} gauge with epsilon = {self.epsilon}.
B0_crit = {self.B0_crit / (self.mass * self.omega):.4f} m omega.
B0 = {self.B0 / (self.mass * self.omega):.4f} m omega = {self.B0/self.B0_crit:.4f} B0_crit, {self.num_vortices_expected:.0f} vortices expected.\n'''
        except: pass

        # Save str to file
        file_loc = os.path.join(self.save_folder, 'Sim Info.txt')
        with open(file_loc, 'a') as text_file:
            text_file.write(str)

        return str
#Absorbing boundary: abs_amplitude = {self.abs_amp}, abs_sigma = {self.abs_sigma/1e-6} um
class Wavefunction():
    """
    The Wavefunction class contains everything directly related to the wavefunction. This includes the density,
    the phase, the full wavefunction, and evolution functions.
    Experimental parameters are set using the Environment class
    Evolution functions:
        - evolve: the main evolution function
        - find_gs: the same as evolve, but in imaginary time. This brings the condensate into the ground state.
    contains
        - Psi : wavefunction at current time
        - Psi_t : list of stored wavefunction for save_every step
        - time_saved : list of time for save_every step
        - time_all : list of time for all steps
        - energy_t : time evolution of the energy
        - stats_t : various stats for the wf
    """

    def __init__(self, env=None):
        if env is None: env = Environment()
        self.env = env
        # Create empty lists
        self.Psi_t = []
        self.time_saved = []
        self.time_all = []
        self.energy_t = []
        self.stats_t = []

    def Psi_TFgs(self, num_vortices=0):
        Psi = self.env.Psi_TF.copy()
        Psi[np.abs(Psi) == 0] = np.abs(Psi).max() * 1e-10
        Psi = Psi * np.exp(1j * self.env.phi * num_vortices)
        Psi = self.normalize(Psi, self.env.dV)
        self.Psi_initial = Psi
        self.Psi = self.Psi_initial.copy()
        self.t = 0
        self.time_all = [0,]
        self.energy_t = [self.energy_AG(self.Psi), ]
        self.stats_t = [self.calc_wf_stats(self.Psi), ]
        self.Psi_t.append(self.Psi_initial)
        self.time_saved.append(0)

    # changed X to Y for func below.
    def Psi_random(self,):
        Psi = np.random.normal(size=self.env.X.shape) + 1j * np.random.normal(size=self.env.Y.shape)
        self.Psi_initial = self.normalize(Psi, self.env.dV)
        self.Psi = self.Psi_initial.copy()
        self.t = 0
        self.time_all = [0,]
        self.energy_t = [self.energy_AG(self.Psi), ]
        self.stats_t = [self.calc_wf_stats(self.Psi), ]
        self.Psi_t.append(self.Psi_initial)
        self.time_saved.append(0)

    def Psi_evo2initial(self, Psi):
        self.Psi_initial = Psi.copy()
        self.Psi = Psi.copy() #self.Psi_initial.copy()
        self.t = 0
        self.time_all = [0,]
        self.energy_t = [self.energy_AG(self.Psi), ]
        self.stats_t = [self.calc_wf_stats(self.Psi), ]
        self.Psi_t.append(self.Psi_initial)
        self.time_saved.append(0)

    def normalize(self, Psi, dV):
        total_prob = np.sum(np.abs(Psi)**2) * dV
        return Psi * np.sqrt(self.env.N_atoms / total_prob)

    def density(self, Psi=None):
        if Psi is None: Psi = self.Psi
        return np.abs(Psi) ** 2

    def density_k(self, Psi=None):
        if Psi is None: Psi = self.Psi
        Psi_ft = self.normalize(np.fft.fftn(Psi), self.env.dK)
        return np.abs(Psi_ft)**2

    def phase(self, Psi=None, filter=True):
        if Psi is None: Psi = self.Psi
        if filter: phase = np.angle(Psi) * (self.density(Psi) > 1)
        else: phase = np.angle(Psi)
        return phase

    def phase_k(self, Psi=None, filter=True):
        if Psi is None: Psi = self.Psi
        Psi_ft = self.normalize(np.fft.fftn(Psi), self.env.dK)
        if filter: phase_k = np.angle(Psi_ft) * (self.density(Psi_ft) > 1)
        else: phase_k = np.angle(Psi_ft)
        return phase_k

    def integrated_phase(self, Psi=None, filter=True):
        if Psi is None: Psi = self.Psi
        integrated_phase = np.cumsum(self.phase(filter=filter), axis=0)
        return integrated_phase

    def plot_density(self, ax=None, Psi=None):
        if ax is None: fig, ax = plt.subplots()
        plt.sca(ax)
        plt.pcolor(self.env.X*1e6, self.env.Y*1e6, self.density(Psi))
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel='x (um)', ylabel='y (um)', title='density')

    def plot_density_k(self, ax=None, Psi=None):
        if ax is None: fig, ax = plt.subplots()
        plt.sca(ax)
        kX = np.fft.fftshift(self.env.kX)
        kY = np.fft.fftshift(self.env.kY)
        density_k = np.fft.fftshift(self.density_k(Psi))
        k_scale = self.env.k_scale
        k_scale_label = f'{self.env.k_scale_label}'
        plt.pcolor(kX/k_scale, kY/k_scale, density_k)
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel=f'kx ({k_scale_label})', ylabel=f'ky ({k_scale_label})', title='density (kx, ky)')
        return ax

    def plot_phase(self, ax=None, Psi=None, crop_phase=True, crop_limit=1e-9):
        if ax is None: fig, ax = plt.subplots(figsize=[8, 8])
        plt.sca(ax)
        if crop_phase is False:
            plt.pcolor(self.env.X*1e6, self.env.Y*1e6, self.phase(Psi), cmap='twilight', vmin=-np.pi, vmax=np.pi)
        else:
            min_density = self.density(Psi).max()*crop_limit
            plt.pcolor(self.env.X*1e6, self.env.Y*1e6, (self.density(Psi) > min_density) * self.phase(Psi), cmap='twilight', vmin=-np.pi, vmax=np.pi)
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel='x (um)', ylabel='y (um)', title='phase')

    def plot_phase_k(self, ax=None, Psi=None):
        if ax is None: fig, ax = plt.subplots(figsize=[8, 8])
        plt.sca(ax)
        kX = np.fft.fftshift(self.env.kX)
        kY = np.fft.fftshift(self.env.kY)
        k_scale = 1/self.env.k_scale
        k_scale_label = f'1/{self.env.k_scale_label}'
        plt.pcolor(kX/k_scale, kY/k_scale, np.fft.fftshift(self.phase_k(Psi)), cmap='twilight', vmin=-np.pi, vmax=np.pi)
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel=f'kx ({k_scale_label})', ylabel=f'ky ({k_scale_label})', title='k phase')

    def plot_integrated_phase(self, ax=None, Psi=None):
        if ax is None: fig, ax = plt.subplots()
        plt.sca(ax)
        plt.pcolor(self.env.X*1e6, self.env.Y*1e6, self.integrated_phase(Psi), cmap='twilight', vmin=-np.pi, vmax=np.pi) #
        plt.colorbar()
        ax.set_aspect('equal', 'box')
        ax.set(xlabel='x (um)', ylabel='y (um)', title='integrated phase')

    def plot_wf(self, axs=None, Psi=None, save_name='default', crop_phase=False, crop_limit=1e-9):
        if axs is None: fig, axs = plt.subplots(ncols=3, figsize=[12, 3.5])
        self.plot_density(ax=axs[0], Psi=Psi)
        self.plot_phase(ax=axs[1], Psi=Psi, crop_phase=crop_phase, crop_limit=crop_limit)
        self.plot_density_k(ax=axs[2], Psi=Psi)
        # self.plot_integrated_phase(ax=axs[2], Psi=Psi)
        plt.tight_layout()
        file_loc = os.path.join(self.env.save_folder, f'wf_{save_name}.pdf')
        plt.savefig(file_loc)
        return axs

    def plot_wf_k(self, axs=None, Psi=None):
        if axs is None: fig, axs = plt.subplots(ncols=2, figsize=[8, 3.5])
        self.plot_density_k(ax=axs[0], Psi=Psi)
        self.plot_phase_k(ax=axs[1], Psi=Psi)
        #self.plot_integrated_phase_k(ax=axs[2], Psi=Psi)
        plt.tight_layout()
        # file_loc = os.path.join(self.env.save_folder, f'wf_k_{save_name}.pdf')
        # plt.savefig(file_loc)
        return axs

    def plot_stats(self, axs=None, ):
        if axs is None:
            fig, axs = plt.subplots(ncols=2, figsize=[8, 3.5])
        plt.sca(axs[0])
        plt.plot(self.time_all/self.env.time_scale, self.stats_t[:, 0]*1e6, label='com_x')
        plt.plot(self.time_all/self.env.time_scale, self.stats_t[:, 1]*1e6, label='com_y')
        plt.legend()
        plt.ylabel(r"Center of Mass ($\mu$m)")
        plt.xlabel(f"time ({self.env.time_scale_label})")
        plt.sca(axs[1])
        plt.plot(self.time_all/self.env.time_scale, self.stats_t[:, 2]*1e6, label='std_x')
        plt.plot(self.time_all/self.env.time_scale, self.stats_t[:, 3]*1e6, label='std_y')
        plt.legend()
        plt.ylabel(r"sqrt of Second Moment ($\mu$m)")
        plt.xlabel(f"time ({self.env.time_scale_label})")
        plt.tight_layout()
        file_loc = os.path.join(self.env.save_folder, f'stats.pdf')
        plt.savefig(file_loc)
        return axs


    def find_gs(self, **kwargs):
        kwargs['imaginary_time'] = True
        self.evolve(**kwargs)

    def evolve(self, Dt=1e-4, steps=1000, imaginary_time=False, save_every=0, relax_every=0):
        # Print
        if imaginary_time is True:
            str = "\nImaginary Time Evolution:\n"
            str = str + "========================="
        else:
            str = "\nReal Time Evolution:\n"
            str = str + "========================="
        str = str + f'''
time step Dt = {Dt:.3e} s = {Dt/self.env.time_scale:.3e} {self.env.time_scale_label}
evolving for {steps} steps = {steps*Dt:.3e} s = {steps*Dt/self.env.time_scale:.3e} {self.env.time_scale_label}
starting time {self.t:.3e} s = {self.t/self.env.time_scale:.3e} {self.env.time_scale_label}
        \n'''

        # Timer
        start_time = time.time()

        # Prepare storage
        time_all = np.zeros(steps)
        energy_t = np.zeros([steps, len(self.energy_AG(self.Psi))], dtype=np.complex64)
        stats_t = np.zeros([steps, len(self.calc_wf_stats(self.Psi))])
        # Loop
        relax_counter = 0
        for i in tqdm(range(steps)):
            self.t += Dt
            self.Psi = self.GPE_smalltimestep_Dt2(self.Psi, Dt, imaginary_time)
            if (relax_every != 0) and (relax_every != 1):
                if i%relax_every == (relax_every-1):
                    relax_counter += 1
                    self.Psi = self.GPE_smalltimestep_Dt2(self.Psi, Dt, imaginary_time=True)
            if (save_every != 0) and (i%save_every == 0):
                self.Psi_t.append(self.Psi)
                self.time_saved.append(self.t)
            time_all[i] = self.t
            energy_t[i] = self.energy_AG(self.Psi)
            stats_t[i] = self.calc_wf_stats(self.Psi)

        str = str + f"Running imaginary time step every {relax_every} step. Total of {relax_counter}\n"

        # Timer
        total_time = time.time() - start_time
        str = str + f"Execution time: {total_time:.1f} seconds.\n"

        # Save str to file
        file_loc = os.path.join(self.env.save_folder, 'Sim Info.txt')
        with open(file_loc, 'a') as text_file:
            text_file.write(str)
        print(str)

        # Store results
        self.time_all = np.concatenate([self.time_all, time_all], axis=0)
        self.energy_t = np.concatenate([self.energy_t, energy_t], axis=0)
        self.stats_t = np.concatenate([self.stats_t, stats_t], axis=0)


    def GPE_smalltimestep_Dt2(self, *args, **kwargs):
        if self.env.gauge == 'Landau':
            return self.GPE_smalltimestep_Dt2_Landau(*args, **kwargs)
        else:
            return self.GPE_smalltimestep_Dt2_Coulomb(*args, **kwargs)


    ### GP timestep functions -- for Landau gauge:
    def GPE_smalltimestep_Dt2_Landau(self, psi_i, Dt, imaginary_time=False, k_cutoff=True):
        # If finding the ground state then make Dt imaginary
        if imaginary_time == True: Dt = -1j * Dt
        if k_cutoff == True: ksq = self.env.ksq_cutoff
        else: ksq = self.env.ksq
        # Step1 : Evolve in x,y space for Dt/2 time
        psi_1 = (
            np.exp(-(1j/hbar)*(Dt/2)*(
                (self.env.Ax**2/(2*self.env.mass))
                + (1j*hbar/(2*self.env.mass)*self.env.dxAx)
                + self.env.V
                + (self.env.g_2d*np.abs(psi_i)**2)
            )) * psi_i
        )
        psi_1 = self.normalize(psi_1, self.env.dV)
        # Step2 : Evolve in px,py space for Dt/2 time
        psi_2 = np.fft.ifftn(
            np.exp(-(1j/hbar)*(Dt/2)*(hbar**2*ksq)/(2*self.env.mass))
            * np.fft.fftn(psi_1)
        )
        psi_2 = self.normalize(psi_2, self.env.dV)
        # Step3 : Evolve this cumbersome Taylor expanded term for Dt time
        psi_3 = (
            psi_2
            + (1j/hbar)*(Dt)*(self.env.Ax/self.env.mass)*
                np.fft.ifft(hbar*self.env.kX*np.fft.fft(psi_2, axis=1), axis=1)
            - 1/2*(Dt/(hbar*self.env.mass))**2*self.env.Ax**2*
                np.fft.ifft((hbar*self.env.kX)**2*np.fft.fft(psi_2, axis=1), axis=1)
            + 1/2*(1j*hbar )*(Dt/(hbar*self.env.mass))**2*self.env.Ax*self.env.dxAx*
                np.fft.ifft(hbar*self.env.kX*np.fft.fft(psi_2, axis=1), axis=1)
        )
        psi_3 = self.normalize(psi_3, self.env.dV)
        # Step4 : Evolve in px,py space for Dt/2 time
        psi_4 = np.fft.ifftn(
            np.exp(-(1j/hbar)*(Dt/2)*(hbar**2*ksq)/(2*self.env.mass)) *
            np.fft.fftn(psi_3)
        )
        psi_4 = self.normalize(psi_4, self.env.dV)
        # Step5 : Evolve in x,y space for Dt/2 time
        psi_5 = (
            np.exp(-(1j/hbar)*(Dt/2)*(
                (self.env.Ax**2/(2*self.env.mass))
                + (1j*hbar/(2*self.env.mass)*self.env.dxAx)
                + self.env.V
                + (self.env.g_2d*np.abs(psi_4)**2)
            )) * psi_4
        )
        psi_f = self.normalize(psi_5, self.env.dV)
        return psi_f

    def GPE_smalltimestep_Dt2_Coulomb(self, psi_i, Dt, imaginary_time=False, k_cutoff=True):
        # If finding the ground state then make Dt imaginary
        if imaginary_time == True: Dt = -1j * Dt
        if k_cutoff == True: ksq = self.env.ksq_cutoff
        else: ksq = self.env.ksq
        # Step 1: H_x,y
        psi_1 = (
            np.exp(-(1j/hbar)*(Dt/2)*(
                (self.env.Ax**2/(2*self.env.mass))
                + (self.env.Ay**2/(2*self.env.mass))
                + self.env.V
                + (self.env.g_2d*np.abs(psi_i)**2)
            )) * psi_i
        )
        psi_1 = self.normalize(psi_1, self.env.dV)

        # Step 2: H_x,py
        Ham_x_py = (hbar**2*self.env.kY**2)/(2*self.env.mass) - (self.env.Ay * (hbar*self.env.kY) / self.env.mass)
        psi_2 = np.fft.ifft(np.exp(-(1j/hbar)*(Dt/2)*Ham_x_py) * np.fft.fft(psi_1, axis=0), axis=0)
        psi_2 = self.normalize(psi_2, self.env.dV)

        # Step 3: H_px,y
        Ham_px_y = (hbar**2*self.env.kX**2)/(2*self.env.mass) - (self.env.Ax * (hbar*self.env.kX) / self.env.mass)
        psi_3 = np.fft.ifft(np.exp(-(1j/hbar)*(Dt)*Ham_px_y) * np.fft.fft(psi_2, axis=1), axis=1)
        psi_3 = self.normalize(psi_3, self.env.dV)

        # Step 4: H_x,py
        Ham_x_py = (hbar**2*self.env.kY**2)/(2*self.env.mass) - (self.env.Ay * (hbar*self.env.kY) / self.env.mass)
        psi_4 = np.fft.ifft(np.exp(-(1j/hbar)*(Dt/2)*Ham_x_py) * np.fft.fft(psi_3, axis=0), axis=0)
        psi_4 = self.normalize(psi_4, self.env.dV)

        # Step 5: H_x,y
        psi_5 = (
            np.exp(-(1j/hbar)*(Dt/2)*(
                (self.env.Ax**2/(2*self.env.mass))
                + (self.env.Ay**2/(2*self.env.mass))
                + self.env.V
                + (self.env.g_2d*np.abs(psi_4)**2)
            )) * psi_4
        )
        psi_f = self.normalize(psi_5, self.env.dV)

        return psi_f

    def energy_AG(self, psi):
        if self.env.gauge == 'Landau':
            return self.energy_AG_Landau(psi)
        else:
            return self.energy_AG_Coulomb(psi)

    # Calculate total energy from the wavefunction for Landau
    def energy_AG_Landau(self, psi):
        # Calculate its FT
        psi_ft_px_py = np.fft.fftn(psi)
        psi_ft_px_py = self.normalize(psi_ft_px_py, self.env.dK)

        # KE_can = <hbar^2 k^2 / (2m)> = Int{d^2k (hbar^2 k^2/2m) * |psi(k)|^2}
        KE_can = (self.env.dK) * np.sum(
            hbar**2*self.env.ksq/(2*self.env.mass) * np.abs(psi_ft_px_py)**2
        )

        # PE
        PE = (self.env.dV) * np.sum(np.real(self.env.V) * np.abs(psi)**2)

        # IE # (g_2d/2*np.abs(psi)**2) * np.abs(psi)**2
        IE = (self.env.dV) * np.sum(self.env.g_2d/2 * np.abs(psi)**4)

        # KE_mechanical = KE_canonical + <A^2> + <cross terms>
        KE_A_sq = (self.env.dV) * np.sum(self.env.Ax**2/(2*self.env.mass) * np.abs(psi)**2)
        KE_Axpx = -(self.env.dV) * np.sum(
            np.conjugate(psi) *
            self.env.Ax/self.env.mass *
            np.fft.ifft(hbar*self.env.kX * np.fft.fft(psi, axis=1), axis=1)
        )
        KE_dxAx = (self.env.dV) * np.sum((1j*hbar*self.env.dxAx)/(2*self.env.mass) * np.abs(psi)**2)
        KE_mec = KE_A_sq + KE_Axpx + KE_dxAx + KE_can

        # Total energy
        E_tot = KE_mec + PE + IE
        # return the results
        return np.array([E_tot, KE_mec, PE, IE,
            KE_can, KE_A_sq, KE_Axpx, KE_dxAx]) # When adding more, add labels to self.store()

    # Calculate total energy for Coulomb
    def energy_AG_Coulomb(self, psi):
        # Calculate iFTs
        psi_ft_px_py = np.fft.fftn(psi)
        psi_ft_px_py = self.normalize(psi_ft_px_py, self.env.dK)
        psi_ft_px_y = np.fft.fft(psi, axis=1)
        psi_ft_px_y = self.normalize(psi_ft_px_y, self.env.dkx * self.env.dy) # where dkx * dy = dV (vol)
        psi_ft_x_py = np.fft.fft(psi, axis=0)
        psi_ft_x_py = self.normalize(psi_ft_x_py, self.env.dx * self.env.dky)

        # KE
        KE_can = (self.env.dK) * np.sum(
            hbar**2*self.env.ksq/(2*self.env.mass) * np.abs(psi_ft_px_py)**2
        )
        KE_A_sq = (self.env.dV) * np.sum(
            (self.env.Ax**2+self.env.Ay**2)/(2*self.env.mass) * np.abs(psi)**2
        )
        KE_Axpx = -1 * (self.env.dkx * self.env.dy) * np.sum(
            (self.env.Ax * hbar * self.env.kX / self.env.mass) * np.abs(psi_ft_px_y)**2
        )
        KE_Aypy = -1 * (self.env.dx * self.env.dky) * np.sum(
            (self.env.Ay * hbar * self.env.kY / self.env.mass) * np.abs(psi_ft_x_py)**2
        )
        KE_mec = KE_can + KE_A_sq + KE_Axpx + KE_Aypy

        # PE
        PE = (self.env.dV) * np.sum(np.real(self.env.V) * np.abs(psi)**2)

        # IE # (g_2d/2*np.abs(psi)**2) * np.abs(psi)**2
        IE = (self.env.dV) * np.sum(self.env.g_2d/2 * np.abs(psi)**4)

        # Total energy
        E_tot = KE_mec + PE + IE
        # return the results
        return np.array([E_tot, KE_mec, PE, IE,
            KE_can, KE_A_sq, KE_Axpx, KE_Aypy]) # When adding more, add labels to self.store()

    def plot_energy(self, ax=None, show_comps=False, ylim=[0,None], title=''):
        if ax is None: fig, ax = plt.subplots(figsize=[7,4])
        ax.plot(
            self.time_all/self.env.time_scale,
            np.real(self.energy_t[:,0])/self.env.energy_scale,
            'k-', label='E_tot'
        )
        if show_comps: # [E_tot, KE, PE, IE]
            ax.fill_between(
                self.time_all/self.env.time_scale,
                0,
                np.real(self.energy_t[:,1])/self.env.energy_scale,
                color='r', label='KE', alpha=0.5
            )
            ax.fill_between(
                self.time_all/self.env.time_scale,
                np.real(self.energy_t[:,1])/self.env.energy_scale,
                np.real(self.energy_t[:,1] + self.energy_t[:,2])/self.env.energy_scale,
                color='b', label='PE', alpha=0.5
            )
            ax.fill_between(
                self.time_all/self.env.time_scale,
                np.real(self.energy_t[:,1] + self.energy_t[:,2])/self.env.energy_scale,
                np.real(self.energy_t[:,0])/self.env.energy_scale,
                color='g', label='IE', alpha=0.5
            )
            ax.legend()
        ax.set(
            xlabel=f"time ({self.env.time_scale_label})",
            ylabel=f"energy ({self.env.energy_scale_label})",
            ylim=ylim, title=title,
            xlim=[0, self.t/self.env.time_scale]
        )
        fig.tight_layout()

        str = f'''
Energy Results:
=========================
Final total Energy per atom: {np.real(self.energy_t[-1,0]/(h * self.env.N_atoms)):.3f} Hz x h = {np.real(self.energy_t[-1,0]/(self.env.energy_scale)):.6f} {self.env.energy_scale_label}
        \n'''
        # Save str to file
        file_loc = os.path.join(self.env.save_folder, 'Sim Info.txt')
        with open(file_loc, 'a') as text_file:
            text_file.write(str)
        print(str)

        return ax


    def calc_wf_stats(self, Psi):
        # R_vec = 1/N  Int[dx Int[dy n(x,y) r_vec ] ] over all space
        n = self.density(Psi)
        com_x = 1/self.env.N_atoms * np.sum(self.env.dV * n * self.env.X)
        com_y = 1/self.env.N_atoms * np.sum(self.env.dV * n * self.env.Y)
        # Second central moment - variance
        vari_x = 1/self.env.N_atoms * np.sum(self.env.dV * n * (self.env.X - com_x)**2)
        vari_y = 1/self.env.N_atoms * np.sum(self.env.dV * n * (self.env.Y - com_y)**2)
        std_x = np.sqrt(vari_x)
        std_y = np.sqrt(vari_y)
        return (com_x, com_y, std_x, std_y) # When adding more, add labels to Wavefunction.store()

    def store(self, ):
        file_loc = os.path.join(self.env.save_folder, f'{self.env.save_folder}_sim.h5')
        with h5py.File(file_loc, 'a') as f:
            # Store wavefunctions
            wfs_grp = f.require_group('wfs')
            try: del wfs_grp['wfs']
            except: pass
            try: del wfs_grp['times']
            except: pass
            wfs_grp['wfs'] = self.Psi_t
            wfs_grp['times'] = self.time_saved
            print(f"Done storing wfs at {file_loc}\wfs.")

            # Store final wavefunction
            final_wf_grp = f.require_group('final_wf')
            try: del final_wf_grp['wf']
            except: pass
            final_wf_grp['wf'] = self.Psi
            final_wf_grp.attrs['time'] = self.t
            print(f"Done storing final wf at {file_loc}\final_wf.")

            # Store energies
            energies_grp = f.require_group('energies')
            try: del energies_grp['energies']
            except: pass
            try: del energies_grp['times']
            except: pass
            try: del energies_grp['labels']
            except: pass
            energies_grp['energies'] = self.energy_t
            energies_grp['times'] = self.time_all
            energies_grp.attrs['labels'] = [
                'E_tot', 'KE', 'PE', 'IE',
                'KE_can', 'KE_A_sq', 'KE_Axpx',
                'KE_dxAx_KE_Aypy'
            ]
            print(f"Done storing energies at {file_loc}\energies.")

            # Store stats
            stats_grp = f.require_group('stats')
            try: del stats_grp['stats']
            except: pass
            try: del stats_grp['times']
            except: pass
            try: del stats_grp['labels']
            except: pass
            stats_grp['stats'] = self.stats_t
            stats_grp['times'] = self.time_all
            stats_grp.attrs['labels'] = ['com_x', 'com_y', 'std_x', 'std_y']
            print(f"Done storing stats at {file_loc}\stats.")


# Other fuctions
def probability(wavefunction):
    return np.abs(wavefunction)**2
def normalize(wavefunction, dV, N_atoms): # Note dV is d^2r in 2D, and N_atoms is the total number of atoms
    total_prob = np.sum(probability(wavefunction)) * dV
    # nb: use trapz for integration instead of sum. This will give more precise integration.
    return wavefunction * np.sqrt( N_atoms / total_prob )
def energy_noAG(psi, V_ext, g_2d, ksquared, dV, N_atoms, dK, mass):
    # Calculate its FT
    psi_ft = np.fft.fftn(psi)
    psi_ft = normalize(psi_ft, dK, N_atoms)
    # Kinetic energy
    KE = np.sum( (hbar**2*ksquared)/(2*mass) * probability(psi_ft) ) * dK
    # Potential energy
    PE = np.sum( V_ext * probability(psi) ) * dV
    # Interaction energy
    IE = np.sum( (g_2d/2) * probability(psi)**2 ) * dV
    # Total energy
    E_tot = KE + PE + IE
    # return the results
    return (E_tot, KE, PE, IE)


def VectorPotentialFromBz(Bz, dx, dy):
    Ax = -scipy.integrate.cumtrapz(Bz, dx=dy, axis=0, initial=0)
    Bz_fromA = -np.gradient(Ax, axis=0) / dy
    dxAx = -np.gradient(Ax, axis=1) / dx
    return Ax, dxAx, Bz_fromA


def erf(x, x0=0., sigma=1., amp=1., offset=0., gradient=0.):
    '''
    Standard error function :
        sigma defined from gaussian sigma as one standard deviation
        goes from -amp to amp
    To mirror error function, x, x0 => -x, -x0
    '''
    return amp * scipy.special.erf( (x-x0) / (2**0.5 * sigma)) + offset + gradient * x

def erf_shifted(x, x0=0., sigma=1., amp=1., offset=0., gradient=0.):
    '''
    Shifted Error function, such that it starts from 0 and reaches maximum of amp.
    Sigma defined from gaussian sigma as one standard deviation
    To mirror error function, x, x0 => -x, -x0
    '''
    return amp * (erf(x=x, x0=x0, sigma=sigma, amp=0.5, offset=0, gradient=0) + 0.5) + offset + gradient * x
