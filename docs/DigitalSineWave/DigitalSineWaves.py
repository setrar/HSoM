# https://www.youtube.com/watch?v=ffSlRUmc7Ew


import numpy as np
import scipy.io.wavfile as wav

def makeWave(length, amp, freq, phase, rate=44100):
   input = np.arange(0.0, length, 1.0/rate)
   result = amp * np.sin(2*np.pi * freq * input + phase)
   return result

# wave = makeWave(2.0, 1.0, 440.0, 0, 44100)
# wav.write("test.wav", 44100, wave)

# wave = makeWave(1.0, 1.0, 440.0, 0, 4410)
# wav.write("test.wav", 4410, wave)


# wave = makeWave(1.0, 1.0, 440.0, 0, 3)
# wav.write("test.wav", 3, wave)

wave = makeWave(1.0, 1.0, 440.0, 0, 10)
wav.write("test.wav", 10, wave)
