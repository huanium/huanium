/*
   Author: Huan Q. Bui
   MIT, April 2022
   This program is intended for stabilizing the Li injection lock setup.
   There are two modes: recovery and active stabilization.
   Inspiration: arXiv:1602.03504
   Current modulation specs:
   Thorlabs 205C: 50 mA/V
   Thorlabs 210C: 100 mA/V
   want current mod range of 6 mA --> want Voltage range (205C) of 0.12 V
   arduino due has range of (2.75-0.55) = 2.2V
   ==> need attenuation factor of 18.3
   ==> in dB: ~25 dB
   want current mod range of 6 mA --> want Voltage range (210C) of 0.06 V
   arduino due has range of (2.75-0.55) = 2.2V
   ==> need attenuation factor of 36.7
   ==> in dB: ~30 dB
*/


// Define global variables

// to do: make trig level tunable
int trigLevel = 100; // trigger level

// how many samples per scan
int taskCounter = 350; // good time span

void testScope(int taskCounter, int FParray[])
{
  for (int i = 0; i <= taskCounter - 1; i++)
  {
    Serial.println(FParray[i]);
    //delay(2);
  }

  unsigned long start = micros();
  while (micros() - start <= 5 * 1000)
  {
    Serial.println(2400);
  }
  delay(1000);
}


void peakDetect(int taskCounter, int FParray[])
{
  int peaks[4];
  int peakLocs[4];
  int peaksFreePos = 0;

  for (int i = 0; i < taskCounter - 2; i++)
  {
    if (FParray[i] < FParray[i + 1] and FParray[i + 1] > FParray[i + 2] and FParray[i] >= 300)
    {
      peaks[peaksFreePos] = FParray[i];
      peakLocs[peaksFreePos] = i;
      peaksFreePos++;
    }
  }

  for (int i = 0; i < peaksFreePos; i++)
  {
    Serial.println(peaks[i]);
    Serial.println(peakLocs[i]);
    Serial.println("=======");
    delay(1);
  }

  Serial.println(" ");
  delay(1000);
}



void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
  analogReadResolution(12);
  analogWriteResolution(12); // write values from 0-4095... 0.55 - 2.75 V
}

void loop()
{
  /////////////////////////////////////////////////////////
  ///////// TRIGGER & PEAK DETECTION //////////////////////
  /////////////////////////////////////////////////////////

  int oldVal = analogRead(A0);
  delayMicroseconds(10000); //wait 10 ms before finding next val
  int val = analogRead(A0);

  delayMicroseconds(1500);

  if (val >= trigLevel and oldVal <= trigLevel) // rising edge
  {
    // if triggereg
    // store FParray and its max
    int FParray[taskCounter];
    for (int i = 0; i < taskCounter; i++)
    {
      int FPsignal = analogRead(A1);
      FParray[i] = FPsignal;
      delayMicroseconds(20);
    }

    // testScope(taskCounter, FParray);
    peakDetect(taskCounter, FParray);
  }

}
