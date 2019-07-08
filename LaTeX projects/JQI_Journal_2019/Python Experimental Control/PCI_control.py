import nidaqmx
import math
import numpy as np
from nidaqmx import *
import matplotlib.pyplot as plt
import settings



# this script defines various waveforms and controls for PCI-6733
# by default, each cycle is 1 ms = 1000 mus
# 01 sample per channel
# the number of points dictate cycle length
# 200 pts/cycle gives 2ms/cycle
# this means 10 microsecs/pt
# rate is 1000*100 = 100000 Hz equivalent to 10 microsecs/tick
# at rate = 1*10^5 Hz, 100 pts/cycle, each point is 10 microsecs
# at rate = 2*10^5 Hz, 100 pts/cycle, each point is 5  microsecs
# ==> pts/cycle don't matter. Rate determines time_resolution


def gaussian(amp, tail, duration, rate):
    # starting out 3 stdevs away from mean
    # tail: how many stdevs away
    # duration: how long one cycle is

    mu = 0
    var = 1
    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    steps = int(duration/time_step)
    x = mu - tail*math.sqrt(var)
    gauss = np.array([])

    for i in range(-int(steps/2),int(steps/2)):
        x = x + 2*tail*math.sqrt(var)/steps
        # g = (1/math.sqrt(2*math.pi*var)) * np.exp(-( (x-mu)**2 / ( 2.0 * var ) ) )
        g = amp * np.exp(- (x - mu)**2/(2.0*var))
        gauss = np.append(gauss, np.float16(g))
    return gauss


def sin(amp, freq_scale, duration, rate):
    # amp: amplitude
    # freq_scale: relative frequency compared to 1.
    # duration: period

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    steps = int(duration/time_step)
    sx = np.array([])
    for i in range(-int(steps/2),int(steps/2)):
        # from -Pi to Pi
        val = amp*math.sin(2*math.pi*i*freq_scale/steps)
        sx = np.append(sx, np.float16(val))

    return sx



def sinc(amp, duration, rate):
    # amp: amplitude of max

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    critical_x = 30
    steps = int(duration/time_step)
    s = np.array([])
    for i in range(-int(steps/2),int(steps/2)):
        if i == 0:
            val = 1.0*amp
        else:
            val = amp*math.sin(critical_x*i/steps)/(critical_x*i/steps)
        s = np.append(s, np.float16(val))
    return s


def sawtooth(amp, duration, rate):
    # amp: amplitude of max

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    steps = int(duration/time_step)
    t = np.array([])
    for i in range(-int(steps/2),int(steps/2)):
        val = amp*i/steps
        t = np.append(t, np.float16(val))
    return t



def set_voltage(volt, duration_on, duration, rate):
    # set a voltage for a number of points
    # makes a square pulse for some num_points
    # then turns to zero for num_points zero

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    voltage = np.array([])
    for i in range(int(duration_on/time_step)):
        voltage = np.append(voltage, np.float16(volt))
    for i in range(int((duration - duration_on)/time_step)):
        voltage = np.append(voltage, np.float16(0.0))
    return voltage


def set_to_zero(duration, rate):
    # creates an array of zeros to 0 volts

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    voltage = np.array([])
    for i in range(int(duration/time_step)):
        voltage = np.append(voltage, np.float16(0.0))
    return voltage


def set_delay(duration, wave, rate):
    # create a delay between signal beginnings
    # by replacing the first `steps' values by zeros

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate
    zeros = np.array([])
    # new_wave = np.copy(wave)

    if int(duration/time_step) > len(wave):
        return set_to_zero(len(wave))

    for i in range(int(duration/time_step)):
        zeros = np.append(zeros, np.float16(0.0))

    delay = np.concatenate((zeros, wave))
    delay = delay[0:len(wave)]
    return delay



def to_wave(instruction, rate):
    # this function takes in instructions
    # and returns a waveform
    events = len(instruction)
    wave = np.array([])
    for e in range(events):
        mode = instruction[e][0]
        duration = instruction[e][1]
        step = instruction[e][2]
        volts = instruction[e][3]
        wave = np.concatenate((wave, set_voltage(volts, duration, duration, rate)))
    return wave


def simulate(cycles, rate, wave1=np.array([np.float16(0.0)]*100),
                               wave2=np.array([np.float16(0.0)]*100),
                               wave3=np.array([np.float16(0.0)]*100),
                               wave4=np.array([np.float16(0.0)]*100)):
    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    time1 = []
    time2 = []
    time3 = []
    time4 = []
    time1_step = time_step
    time2_step = time_step
    time3_step = time_step
    time4_step = time_step
    t1 = 0
    t2 = 0
    t3 = 0
    t4 = 0
    for cycle in range(cycles):
        for w in range(len(wave1)):
            time1.append(t1)
            t1 = t1 + time1_step

        for w in range(len(wave2)):
            time2.append(t2)
            t2 = t2 + time2_step

        for w in range(len(wave3)):
            time3.append(t3)
            t3 = t3 + time3_step

        for w in range(len(wave4)):
            time4.append(t4)
            t4 = t4 + time4_step

    wave1 = np.tile(wave1, cycles)
    wave2 = np.tile(wave2, cycles)
    wave3 = np.tile(wave3, cycles)
    wave4 = np.tile(wave4, cycles)

    print('Data dimension: ', len(time1))

    plt.plot(time1, wave1, time2, wave2, time3, wave3, time4, wave4)
    plt.xlabel('Time')
    plt.ylabel('Volts (V)')
    plt.show(block=False)
    print('--- Plot graph finish ---')
    # plt.show()
    return



def run(rate, wave1, wave2, wave3, wave4):

    global Sample_Per_Chan
    Sample_Per_Chan = 1

    global time_step
    global default_rate
    default_rate = rate
    time_step = 1/rate

    task = nidaqmx.Task()
    task.ao_channels.add_ao_voltage_chan('Dev1/ao0')
    task.ao_channels.add_ao_voltage_chan('Dev1/ao1')
    task.ao_channels.add_ao_voltage_chan('Dev1/ao2')
    task.ao_channels.add_ao_voltage_chan('Dev1/ao3')
    task.timing.cfg_samp_clk_timing(rate= default_rate,
                                    sample_mode= nidaqmx.constants.AcquisitionType.CONTINUOUS,
                                    samps_per_chan=Sample_Per_Chan)

    test_Writer = nidaqmx.stream_writers.AnalogMultiChannelWriter(task.out_stream, auto_start=True)
    #test_Writer = nidaqmx.stream_writers.AnalogSingleChannelWriter(task.out_stream, auto_start=True)
    input_wave = np.array([wave1, wave2, wave3, wave4])
    test_Writer.write_many_sample(input_wave)
    print('Running...')

    while True:
        settings.event, settings.values = settings.window.Read()
        if settings.event is None:
            break
        if settings.event == 'STOP':
            # task.stop()
            # stop, then re-set everything to zero
            # test_Writer.write_many_sample([wave1*0, wave2*0, wave3*0, wave4*0])
            print(settings.event)
            task.stop()
            task.close()
            return






if __name__ == "__main__":
    #num_pts = int(input('Number of nonzero points: '))
    #num_pts_0 = int(input('Number of zero points: '))
    #voltage = float(input('Enter voltage: '))
    #delay_steps = int(input('Enter delay points: '))
    #run(set_voltage(voltage, num_pts, num_pts_0), delay_steps)

    # declare global variables, which are the settingss
    global default_steps
    global default_rate
    global time_resolution
    global time_step
    default_rate = 1e6 # set default sampling rate to 1 MHz

    time_step = float(1/default_rate)


    rate = 1e4
    duration = 1e-1
    time_res = 1/rate
    time_step = time_res
    unit_width = 10*time_res
    print('Time resolution:', time_step)

    global square_pulse
    square_pulse = set_voltage(0.10, unit_width, duration, rate)

    # simulate(1, rate, gaussian(0.2, 5, 0.001, rate), gaussian(0.2, 5, 0.001, rate), gaussian(0.2, 5, 0.001, rate), gaussian(0.2, 5, 0.001, rate))

    # simulate here
    # simulate(1, rate, set_delay(0*unit_width, set_voltage(0.10, unit_width, duration, rate), rate),
    #                   set_delay(1*unit_width, set_voltage(0.10, unit_width, duration, rate), rate),
    #                   set_delay(2*unit_width, set_voltage(0.10, unit_width, duration, rate), rate),
    #                   set_delay(3*unit_width, set_voltage(0.10, unit_width, duration, rate), rate))

    # square pulses
    # run(rate, set_delay(0*unit_width, set_voltage(0.10, unit_width, duration, rate), rate),
    #           set_delay(1*unit_width, set_voltage(0.10, unit_width, duration, rate), rate),
    #           set_delay(2*unit_width, set_voltage(0.10, unit_width, duration, rate), rate),
    #           set_delay(3*unit_width, set_voltage(0.10, unit_width, duration, rate), rate))

    # run(rate, set_delay(0*unit_width, square_pulse, rate),
    #           set_delay(1*unit_width, square_pulse, rate),
    #           set_delay(2*unit_width, square_pulse, rate),
    #           set_delay(3*unit_width, square_pulse, rate))

    # gaussian pulses
    # simulate(1, rate, gaussian(0.10, 10, duration, rate),
    #           gaussian(0.10, 10, duration, rate),
    #           gaussian(0.10, 10, duration, rate),
    #           gaussian(0.10, 10, duration, rate))

    print('Test')
