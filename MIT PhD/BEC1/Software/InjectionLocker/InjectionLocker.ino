/*
   Author: Huan Q. Bui
   MIT, April 2022

   This program is intended for stabilizing the Li injection lock setup.
   There are two modes: recovery and active stabilization.
   Inspiration: arXiv:1602.03504
*/


// for analogRead() speed up
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))

// Define global variables
int trigLevel = 246; // trigger level, corresponding to 1.2V
int threshold = 313; // lock threshold, 90% of abs max, corrs to 1.53V
int booster = 9;  // booster lock
int currentOffset = 0;
int currentDelta = 0; // used in ACTIVE STABILIZATION
int peakThreshold = 204; // corres to 1.0 V
int taskCounter = 340; // good time span


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);

  sbi(ADCSRA, ADPS2);
  cbi(ADCSRA, ADPS1);
  cbi(ADCSRA, ADPS0);
}


void loop() {

  // find trigger
  int oldVal = analogRead(A0);
  delay(2); //wait 2 ms before finding next val
  int val = analogRead(A0);
  
  if (val >= trigLevel and oldVal <= trigLevel) // rising edge
  {
    // if triggered
    
    // store FParray and its max
    int maxVoltage = 0;
    int FParray[taskCounter];
    for (int i = 0; i <= taskCounter; i++)
    {
      int FPsignal = analogRead(A1);
      if (FPsignal > maxVoltage)
      {
        maxVoltage = FPsignal;
      }
      FParray[i] = FPsignal;
    }

    //    // for reading only
    //    for (int i = 0; i <= taskCounter - 1; i++)
    //    {
    //      Serial.println(FParray[i]);
    //    }
    //
    //    startTime = millis();
    //    while (millis() - startTime <= 50)
    //    {
    //      Serial.println(2.0);
    //    }

    // collect all meaningful peaks in FParray[]
    Serial.println(" ");
    int peaks[20]; // accomodates 20 peaks... or more IDK!
    int freePosition = 0;

    for (int j = 0; j <= taskCounter - 3; j++)
    {
      if ((FParray[j] < FParray[j+1] and FParray[j+2] < FParray[j+1]) and (FParray[j+1] >= peakThreshold)) // a peak at j+1!
      {
        //Serial.println(FParray[j+1]);
        peaks[freePosition] = FParray[j+1];
        freePosition++;
      }
    }

    // now put the peaks into correct categories (indices are found manually)
    int boosterPeaks[6];
    int slowerPeaks[6];
    int boosterFreePosition = 0;
    int slowerFreePosition = 0;

    // print out peaks!
    for (int i = 0; i <= freePosition - 1; i++)
    {
      if (i == 0 or i == 2 or i == 5 or i == 7 or i == 9)
      {
        slowerPeaks[slowerFreePosition] = peaks[i];
        slowerFreePosition++;
      }
      if (i == 1 or i == 3 or i == 4 or i == 6 or i == 8)
      {
        boosterPeaks[boosterFreePosition] = peaks[i];
        boosterFreePosition++;
      }
    }

    // print out slower peaks!
    Serial.println("Slower peaks:");
    for (int i = 0; i <= slowerFreePosition - 1; i++)
    {
      Serial.println(slowerPeaks[i]);
    }

    // print out booster peaks!
    Serial.println("Booster peaks:");
    for (int i = 0; i <= boosterFreePosition - 1; i++)
    {
      Serial.println(boosterPeaks[i]);
    }


    ///////////////////////////////////////////////////////////////////////////


    //    // implement lock logic here
    //    if (maxVoltage < threshold)  // if lock is lost
    //    {
    //      // RECOVERY MODE
    //
    //      // first jump current to something high for 100 ms
    //      // voltage to current control: 0.1 mA = 5 mV
    //      // voltage resolution of Uno: 5/255 = 0.02 V = 20 mW --> 0.4 mA per stop
    //      // then slowly ramp down in steps of 0.4 mA (smallest possible)
    //      // ramping down is important due to hysteresis
    //
    //
    //      //analogWrite(booster, currentOffset + 10); // adding about 4 mA, keep on for 100 ms
    //      delay(200); // wait to thermalize
    //
    //      maxVoltage = 0;
    //
    //      for (int i = 0; i <= taskCounter; i++)
    //      {
    //        int FPsignal = analogRead(A1);
    //        if (FPsignal > maxVoltage)
    //        {
    //          maxVoltage = FPsignal;
    //        }
    //      }
    //
    //      if (maxVoltage >= threshold) // if lock is regained
    //      {
    //        digitalWrite(LED_BUILTIN, HIGH);
    //        Serial.println(currentOffset);
    //      }
    //      else // if lock not regained, try again
    //      {
    //        digitalWrite(LED_BUILTIN, LOW);
    //        currentOffset--;
    //        Serial.println(currentOffset);
    //      }
    //    }
    //    else // if still locked
    //    {
    //      //Serial.println(maxVoltage);
    //      currentOffset = 0;
    //      Serial.println(currentOffset);
    //    }

    ///////////////////////////////////////////////////////////////////////////

    // wait 1000 ms before continuing
    delay(1000);
  }
}
