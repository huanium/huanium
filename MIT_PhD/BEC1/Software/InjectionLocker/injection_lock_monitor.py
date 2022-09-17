from email import message
import serial
import time
import winsound # Windows only
import requests

# ARDUINO 
arduino = serial.Serial(port='COM3', baudrate=115200, timeout=.1)
slower_frequency = 256*4  # C in Hz
repump_frequency = 330*4  # E in Hz (311 for Eb)
MOT_frequency = 392*4  # G in Hz
beep_duration = 200 # ms

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
        while True:
            lines = []
            arduino_printout = read_arduino()
            if "Trigger Level" in arduino_printout:
                lines.append(arduino_printout)
                # collect printouts until the next trigger level line comes in
                arduino_printout = read_arduino()
                while not("Trigger Level" in arduino_printout):
                    lines.append(arduino_printout)
                    arduino_printout = read_arduino()
                        
                for s in lines:
                    if not(s==''):
                        print(s)
                        time.sleep(0.1)
                        if "Slower unlocked!" in s:
                            winsound.Beep(slower_frequency, beep_duration)
                        elif "Repump unlocked!" in s:
                            winsound.Beep(repump_frequency, beep_duration)
                        elif "MOT unlocked!" in s:
                            winsound.Beep(MOT_frequency, beep_duration)
                            # slack(message = "MOT unlocked!")	
    except KeyboardInterrupt:
        print("Stopping monitor... Done")

if __name__ == "__main__":
	main()




