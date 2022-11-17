import pygame, pygame.sndarray
import numpy
import scipy.signal

sample_rate = 44100
pygame.mixer.init(frequency=sample_rate, size=-16, channels=1)

def play_for(sample_wave, ms):
    """Play the given NumPy array, as a sound, for ms milliseconds."""
    sample_wave = numpy.repeat(sample_wave.reshape(sample_rate, 1), 2, axis = 1)
    sound = pygame.sndarray.make_sound(sample_wave)
    sound.play(-1)
    pygame.time.delay(ms)
    sound.stop()


def sine_wave(hz, peak, n_samples=sample_rate):
    """Compute N samples of a sine wave with given frequency and peak amplitude.
       Defaults to one second.
    """
    length = sample_rate / float(hz)
    omega = numpy.pi * 2 / length
    xvalues = numpy.arange(int(length)) * omega
    onecycle = peak * numpy.sin(xvalues)
    return numpy.resize(onecycle, (n_samples,)).astype(numpy.int16)


# Play A (440Hz) for 1 second as a sine wave:
play_for(sum([sine_wave(293.66, 4096), sine_wave(349.23, 4096), sine_wave(440, 4096)]), 1000)