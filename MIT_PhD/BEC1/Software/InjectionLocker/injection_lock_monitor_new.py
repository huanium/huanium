#########################################################################
############## INJECTION LOCK MONITPOR ##################################
#########################################################################
########### Author: Huan Q. Bui #########################################
########### MIT, Nov 17, 2022, BEC1 experiment ##########################
#########################################################################

from email import message
import serial
import time
import requests
import pygame, pygame.sndarray
import numpy
import scipy.signal

arduino = serial.Serial(port='COM6', baudrate=115200, timeout=.1)
beep_frequency = 440*2  # A in Hz
slower_freq = 440*2
repump_freq =  523.25*2
MOT_freq = 659.25*2
beep_duration = 500 # ms
sample_rate = 44100
pygame.mixer.init(frequency=sample_rate, size=-16, channels=1)

# parameters
peakThreshold = 250
trigCounter = 0
prepCounter = 0
printLockStatus_COUNTER = 0
printLockStatus_after = 2
updateMAX_after = 10
updateMAXCounter = 0

boosterLocAvg = 0
# trigLevel = 1100 # don't know if this is necessary anymore... but ok
# trigPointOne = 70
# trigPointTwo = 140

slowerOffset = 53
repumpOffset = slowerOffset + 62
MOTOffset = repumpOffset + 53

boosterLocked = 0
slowerLocked = 0
repumpLocked = 0
MOTLocked = 0

boosterMAX = 2100
slowerMAX = 800
repumpMAX = 1800
MOTMAX = 2100

boosterPeakMax = 4000

quality = 0.90
qualityRAW = quality + 0.015
peakToThres = 0.85

# use these to compare between consecutive runs
boosterPeakOld = 0
slowerPeakOld = 0
repumpPeakOld = 0
MOTPeakOld = 0

def read_arduino():
    data = arduino.readline()
    data = data.decode('utf-8')
    data = data.strip()
    if data != '':
        data = int(data)
    return data

def peakValBetween(FParray, I, F):
    # returns peak value in [I,F]
    # if no peak then return 0
    maxVal = 0
    maxIndex = 0
    # loop through list, without the endpoints
    if F <= len(FParray)-5:
        for j in range(I+1, F-2):
            if (maxVal <= FParray[j]):
                maxVal = FParray[j]
                maxIndex = j
        if (FParray[maxIndex - 1] <= FParray[maxIndex] and FParray[maxIndex] >= FParray[maxIndex + 1]):
            # if maxVal is a peak at maxIndex
            if (maxVal >= peakThreshold and maxVal <= 4095):
                return maxVal
    return 0

def updateMAXRAW(boosterPeak, slowerPeak, repumpPeak, MOTPeak):
    global boosterMAX
    global slowerMAX
    global repumpMAX
    global MOTMAX

    boosterMAX = round(qualityRAW * boosterPeak)
    peakThresholdBooster = round(peakToThres * boosterPeak)
    slowerMAX = round(qualityRAW * slowerPeak)
    repumpMAX = round(qualityRAW * repumpPeak)
    MOTMAX = round(qualityRAW * MOTPeak)

def updateMAX(boosterPeak, slowerPeak, repumpPeak, MOTPeak):
    global boosterMAX
    global slowerMAX
    global repumpMAX
    global MOTMAX

    if (boosterPeak >= boosterMAX and boosterPeak <= 1.005 * boosterMAX): # safety mechanism
        boosterMAX = boosterPeak
    if (slowerPeak >= slowerMAX and slowerPeak <= 1.005 * slowerMAX): # safety mechanism
        slowerMAX = slowerPeak
    if (repumpPeak >= repumpMAX and repumpPeak <= 1.005 * repumpMAX): # safety mechanism
        repumpMAX = repumpPeak
    if (MOTPeak >= MOTMAX and MOTPeak <= 1.005 * MOTMAX): # safety mechanism
        MOTMAX = MOTPeak

def printLockStatus(boosterPeak, slowerPeak, repumpPeak, MOTPeak, boosterLoc, FParray_length):
    # print status
    # print("Trigger Level: " + str(trigLevel))
    # booster
    print("Booster location: " + str(boosterLoc) + "/" + str(FParray_length))
    print(" - - - - - - - - - - - -")
    print("Booster peak: " + str(boosterPeak))

    # slower
    print("Slower peak: " + str(slowerPeak))
    # repump
    print("Repump peak: " + str(repumpPeak))
    # MOT
    print("MOT peak: " + str(MOTPeak))

    if (slowerLocked == 5):
        print("Slower unlocked!")
    if (repumpLocked == 5):
        print("Repump unlocked!")
    if (MOTLocked == 5):
        print("MOT unlocked!")
    
    print("-------------------------")
    print("boosterMAX: " + str(boosterMAX))
    print("slowerMAX: " + str(slowerMAX))
    print("repumpMAX: " + str(repumpMAX))
    print("MOTMAX: " + str(MOTMAX))
    print("=========================")

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

def main():
    try:
        lines = []
        while True:
            ############################################
            ########## DATA READING FROM SERIAL ########
            ############################################
            FParray = []
            arduino_printout = read_arduino()       
            while arduino_printout != 4000 and arduino_printout != '': 
                FParray.append(arduino_printout)
                arduino_printout = read_arduino()

            ############################################
            ########## DATA READING FROM SERIAL ########
            ############################################
            
            # peak detect
            boosterPeak = 0
            slowerPeak = 0
            MOTPeak = 0
            repumpPeak = 0
            boosterLoc = 0
            slowerLoc = 0
            MOTLoc = 0
            repumpLoc = 0

            # locate the booster, as reference for other peaks
            boosterI = 0
            boosterF = 0
            for i in range(1,len(FParray)-3+1):            
                if (FParray[i - 1] < FParray[i] and FParray[i] > FParray[i + 1] and FParray[i] >= peakThreshold): # if peak @ [i]
                    if (i >= 10): # for safety purposes... don't want to trigger too early
                        boosterI = i - 10
                        boosterF = i + 10
                        boosterPeak = FParray[i]
                        boosterLoc = i
                        break

            # adjust the trigger to respond to correct for change in boosterLoc
            # average over 250 shots, then proceed with adjusting the trigLevel
            global trigCounter
            global boosterLocAvg
            # global trigLevel 

            if (trigCounter < 250):
                boosterLocAvg += boosterLoc/250.0 # cast into float type...
                trigCounter += 1
            else:
                trigCounter = 0 # reset
                # if (boosterLocAvg <= trigPointOne): # trigger is too late
                #    trigLevel -= 3 # make trigger earlier
                
                # if (boosterLocAvg >= trigPointTwo): # trigger is too soon
                #     trigLevel += 3 ; # make trigger later
                boosterLocAvg = 0; # reset
            
            ##### MONITORING ####
            if (boosterPeak <= boosterPeakMax and boosterPeak >= 100 and len(FParray) >= 330): # if booster exceeds boosterPeakMax --> do nothing
                # get peak values
                slowerPeak = peakValBetween(FParray, boosterI + slowerOffset, boosterF + slowerOffset)
                repumpPeak = peakValBetween(FParray, boosterI + repumpOffset, boosterF + repumpOffset)
                MOTPeak = peakValBetween(FParray, boosterI + MOTOffset, boosterF + MOTOffset)

                global prepCounter
                global slowerLocked
                global repumpLocked
                global MOTLocked
                global slowerPeakOld
                global repumpPeakOld
                global MOTPeakOld
                # in the first 20 triggers, update MAX values
                if (prepCounter < 20):
                    prepCounter+=1
                    updateMAXRAW(boosterPeak, slowerPeak, repumpPeak, MOTPeak)
                    print("Initializing: " + str(prepCounter)+ "/20")
                
                else: # once done, go to Lock Mode
                    ####################################
                    #### LOCK LOGIC USED TO GO HERE ####
                    #### now only lock status ##########
                    ####################################

                    # SLOWER
                    if (slowerPeak < quality*slowerMAX):
                        if (slowerLocked < 5):
                            if (slowerPeakOld < quality*slowerMAX):
                                slowerLocked+=1 # only add if previous shot also bad
                            else:
                                slowerLocked = 0 # if last shot was good then reset, probably noise                 
                    else: # if Peak is good, then reset strikes and optimize to quality of MAX
                        slowerLocked = 0
                        
                    # repump
                    if (repumpPeak < quality*repumpMAX):
                        if (repumpLocked < 5):
                            if (repumpPeakOld < quality*repumpMAX):
                                repumpLocked+=1 # only add if previous shot also bad
                            else:
                                repumpLocked = 0 # if last shot was good then reset, probably noise                 
                    else: # if Peak is good, then reset strikes and optimize to quality of MAX
                        repumpLocked = 0

                    # MOT
                    if (MOTPeak < quality*MOTMAX):
                        if (MOTLocked < 5):
                            if (MOTPeakOld < quality*MOTMAX):
                                MOTLocked+=1 # only add if previous shot also bad
                            else:
                                MOTLocked = 0 # if last shot was good then reset, probably noise                 
                    else: # if Peak is good, then reset strikes and optimize to quality of MAX
                        MOTLocked = 0
                    
                    ####################################
                    #### MONITOR LOGIC #################
                    ####################################
                    # print status
                    global printLockStatus_COUNTER
                    global printLockStatus_after

                    if (printLockStatus_COUNTER > printLockStatus_after):
                        printLockStatus(boosterPeak, slowerPeak, repumpPeak, MOTPeak, boosterLoc, len(FParray))
                        printLockStatus_COUNTER = 0; # reset

                        if slowerLocked == 5:
                            if repumpLocked == 5: 
                                if MOTLocked == 5:
                                    play_for(sum([sine_wave(slower_freq, 8192), sine_wave(repump_freq, 8192), sine_wave(MOT_freq, 8192)]), beep_duration)
                                else:
                                    play_for(sum([sine_wave(slower_freq, 8192), sine_wave(repump_freq, 8192)]), beep_duration)
                            else:
                                if MOTLocked == 5:
                                    play_for(sum([sine_wave(slower_freq, 8192), sine_wave(MOT_freq, 8192)]), beep_duration)
                                else:
                                    play_for(sum([sine_wave(slower_freq, 8192)]), beep_duration)
                        else:
                            if repumpLocked == 5: 
                                if MOTLocked == 5:
                                    play_for(sum([sine_wave(repump_freq, 8192), sine_wave(MOT_freq, 8192)]), beep_duration)
                                else:
                                    play_for(sum([sine_wave(repump_freq, 8192)]), beep_duration)
                            else:
                                if MOTLocked == 5:
                                    play_for(sum([sine_wave(MOT_freq, 8192)]), beep_duration)
                                # else everything's still ok
                    else:
                        printLockStatus_COUNTER += 1
                    
                    # the end
                    boosterPeakOld = boosterPeak
                    slowerPeakOld = slowerPeak
                    repumpPeakOld = repumpPeak
                    MOTPeakOld = MOTPeak

                    # auto update MAX values, only if everything is locked
                    # act only for every "updateMAX_after" iterations, to stay conservative
                    global updateMAXCounter
                    global updateMAX_after

                    if (boosterLocked * repumpLocked * MOTLocked * slowerLocked == 0):
                        if (updateMAXCounter > updateMAX_after):
                            updateMAX(boosterPeak, slowerPeak, repumpPeak, MOTPeak)
                            updateMAXCounter = 0 # reset
                        else:
                            updateMAXCounter += 1

    except KeyboardInterrupt:
        print(" ")
        print("Stopping monitor... Done")
        print(" ")

if __name__ == "__main__":
	main()

