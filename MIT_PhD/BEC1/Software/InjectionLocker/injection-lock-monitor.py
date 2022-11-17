from email import message
import serial
import time
import winsound # Windows only
import requests


# SOUND
slower_frequency = 256*2  # C in Hz
repump_frequency = 330*2  # E in Hz (311 for Eb)
MOT_frequency = 392*2  # G in Hz
beep_frequency = 440*2  # A in Hz
beep_duration = 500 # ms
# ARDUINO 
arduino = serial.Serial(port='COM6', baudrate=115200, timeout=.1)

def read_arduino():
    data = arduino.readline()
    data = data.decode('utf-8')
    data = data.strip()
    return data

def slack(message: str):
    payload = '{"text": "%s"}' % message
    response = requests.post(
    'hidden for now',
    data = payload
    )
    print(response.text)

def main():
    try:
        unlock_instances = 0
        previous_lock_state = True
        while True:
            lines = []
            lock_state = True
            arduino_printout = read_arduino()
            if "Trigger Level" in arduino_printout:
                lines.append(arduino_printout)
                arduino_printout = read_arduino()
                while not("==================" in arduino_printout): # signals end of output
                    lines.append(arduino_printout)
                    arduino_printout = read_arduino()
                        
                for s in lines:
                    if not(s==''):
                        print(s)
                        if "unlocked!" in s:
                            lock_state = False
                print("==================")

                if lock_state == False:
                    unlock_instances += 1
                    winsound.Beep(beep_frequency, beep_duration)
                    if  unlock_instances%10==1:
                        # slack if Li lasers are previously locked or every 50 shots if still unlocked
                        # slack("Something unlocked! Recovering...")
                        print(" ")
                        print("Recovering...")
                        print(" ")
                    previous_lock_state = False

                elif previous_lock_state == False:
                    unlock_instances = 0
                    print(" ")
                    print("Recovered!")
                    print(" ")
                    previous_lock_state = True
                    # slack("Recovered!")

    except KeyboardInterrupt:
        print(" ")
        print("Stopping monitor... Done")
        print(" ")

if __name__ == "__main__":
	main()
