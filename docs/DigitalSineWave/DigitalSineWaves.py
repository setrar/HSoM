# https://www.youtube.com/watch?v=ffSlRUmc7Ew


import numpy as np
import scipy.io.wavfile as wav

def makeWave(length, amp, freq, phase, rate=44100):
   input = np.arange(0.0, length, 1.0/rate)
   print("Sample Array Length and Values: "); print( len(input)) ; print(input)
   result = amp * np.sin(2*np.pi * freq * input + phase)
   return result

# In a second period what can we achieve

period = 1.0 # In seconds
pitchfrequency = 440.0 # Concert Pitch
amplitude = 1.0
phase = 0

# Case 1
# samplerate = 44100 # Sample per second
# wave = makeWave(period, amplitude, pitchfrequency, phase, samplerate)

# Case 2
# samplerate = 1000 # Sample per second
# period = 1.0 # In seconds
# phase = 0.5*np.pi # causing anti-aliasing
# wave = makeWave(period, amplitude, pitchfrequency, phase, samplerate)

# Case 3
# samplerate = 440 # Sample per second
# pitchfrequency = 294.0 # D3

# Case 4
samplerate = 440 # same sample rate as pitch frequency

# Case 5
# samplerate = 3 # Sample per second
# amplitude = 2.0

# Case 6
# samplerate = 10 # Sample per second

# Main Program
wave = makeWave(period, amplitude, pitchfrequency, phase, samplerate)
wav.write("test.wav", samplerate, wave)
