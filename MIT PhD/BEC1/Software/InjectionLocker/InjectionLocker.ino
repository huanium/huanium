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
int trigLevel = 200; // trigger level, corresponding to 1.2V
int threshold = 313; // lock threshold, 90% of abs max, corrs to 1.53V
int booster = 9;  // booster lock
int currentOffset = 0;
int currentDelta = 0; // used in ACTIVE STABILIZATION
int peakThresholdBooster = 340; //
int peakThresholdSlower = 600; //
int peakThresholdRepump = 250; //
int peakThresholdMOT = 780; // corres to 1.0 V
int SlowerLowerBound = 400; // prevents wrong slower analogReads()...
int MOTLowerBound = 400; // prevents wrong slower analogReads()...
int peakThreshold = 204; // corres to 1.0 V
int taskCounter = 350; // good time span = 340
int boosterI = 80;
int boosterF = 120;

// 0 for true, 1 for false
int boosterLocked = 0;
int slowerLocked = 0;
int repumpLocked = 0;
int MOTLocked = 0;


void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);

  sbi(ADCSRA, ADPS2);
  cbi(ADCSRA, ADPS1);
  cbi(ADCSRA, ADPS0);
}

int peakBetween(int FParray[], int I, int F)
{
  // find max
  // make sure it's a peak
  // compare it to peakThres

  int maxVal = 0;
  int maxIndex = 0;

  // loop through list, without the endpoints
  for (int j = I + 1; j <= F - 2; j++)
  {
    if (maxVal <= FParray[j])
    {
      maxVal = FParray[j];
      maxIndex = j;
    }
  }

  if (FParray[maxIndex - 1] <= FParray[maxIndex] and FParray[maxIndex] >= FParray[maxIndex + 1])
  {
    // if maxVal is a peak at maxIndex
    if (maxVal >= peakThreshold and maxVal <= 1024)
    {
      return 0;
    }
  }
  return 1;
}





int peakValBetween(int FParray[], int I, int F)
{
  // returns peak value in [I,F]
  // if no peak then return 0

  int maxVal = 0;
  int maxIndex = 0;

  // loop through list, without the endpoints
  for (int j = I + 1; j <= F - 2; j++)
  {
    if (maxVal <= FParray[j])
    {
      maxVal = FParray[j];
      maxIndex = j;
    }
  }

  if (FParray[maxIndex - 1] <= FParray[maxIndex] and FParray[maxIndex] >= FParray[maxIndex + 1])
  {
    // if maxVal is a peak at maxIndex
    if (maxVal >= peakThreshold and maxVal <= 1024)
    {
      return maxVal;
    }
  }
  return 0;
}



int peakIndBetween(int FParray[], int I, int F)
{
  // returns index of peak value in [I,F]
  // if no peak then return 0

  int maxVal = 0;
  int maxIndex = 0;

  // loop through list, without the endpoints
  for (int j = I + 1; j <= F - 2; j++)
  {
    if (maxVal <= FParray[j])
    {
      maxVal = FParray[j];
      maxIndex = j;
    }
  }

  if (FParray[maxIndex - 1] <= FParray[maxIndex] and FParray[maxIndex] >= FParray[maxIndex + 1])
  {
    // if maxVal is a peak at maxIndex
    if (maxVal >= peakThreshold and maxVal <= 1024)
    {
      return maxIndex;
    }
  }
  return 0;
}




void loop()
{
  // find trigger
  int oldVal = analogRead(A0);
  delay(1); //wait 1 ms before finding next val
  int val = analogRead(A0);

  delay(11);

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

    //        // for reading only
    //        for (int i = 0; i <= taskCounter - 1; i++)
    //        {
    //          Serial.println(FParray[i]);
    //        }
    //
    //        unsigned long startTime = millis();
    //        while (millis() - startTime <= 70)
    //        {
    //          Serial.println(409); //corresponds to 2.0 V;
    //        }

    int boosterPeak = 0;
    int slowerPeak = 0;
    int MOTPeak = 0;
    int repumpPeak = 0;

    int boosterLoc = 0;
    int slowerLoc = 0;
    int MOTLoc = 0;
    int repumpLoc = 0;


    // look for booster
    if (peakBetween(FParray, boosterI, boosterF) == 0)
    {
      // there is booster.
      boosterPeak = peakValBetween(FParray, boosterI, boosterF);
      boosterLoc = peakIndBetween(FParray, boosterI, boosterF);
      boosterLocked = 0;

      if (boosterPeak < peakThresholdBooster and boosterPeak > 0)
      {
        Serial.println("Booster Unlocked!");
        Serial.println(boosterPeak);
        boosterLocked = 1;
      }
    }

    // look for slower
    if (peakBetween(FParray, boosterI + 50, boosterF + 50) == 0)
    {
      // there is slower.
      slowerPeak = peakValBetween(FParray, boosterI + 50, boosterF + 50);
      slowerLoc = peakIndBetween(FParray, boosterI + 50, boosterF + 50);
      slowerLocked = 0;

      if (slowerPeak < peakThresholdSlower and slowerPeak > 0 and slowerPeak >= SlowerLowerBound)
      {
        Serial.println("Slower Unlocked!");
        Serial.println(slowerPeak);
        slowerLocked = 1;
      }
    }

    // look for repump
    if (peakBetween(FParray, boosterI + 105, boosterF + 105) == 0)
    {
      // there is repump.
      repumpPeak = peakValBetween(FParray, boosterI + 105, boosterF + 105);
      repumpLoc = peakIndBetween(FParray, boosterI + 105, boosterF + 105);
      repumpLocked = 0;

      if (repumpPeak < peakThresholdRepump and repumpPeak > 0)
      {
        Serial.println("Repump Unlocked!");
        Serial.println(repumpPeak);
        repumpLocked = 1;
      }
    }

    // look for MOT
    if (peakBetween(FParray, boosterI + 156, boosterF + 156) == 0)
    {
      // there is MOT.
      MOTPeak = peakValBetween(FParray, boosterI + 156, boosterF + 156);
      MOTLoc = peakIndBetween(FParray, boosterI + 156, boosterF + 156);
      MOTLocked = 0;

      if (MOTPeak < peakThresholdMOT and MOTPeak > 0 and MOTPeak >= MOTLowerBound)
      {
        Serial.println("MOT Unlocked!");
        Serial.println(MOTPeak);
        MOTLocked = 1;
      }
    }

    if (boosterPeak*slowerPeak*repumpPeak*MOTPeak > 0)
    {
      Serial.println(boosterPeak);
      Serial.println(slowerPeak);
      Serial.println(repumpPeak);
      Serial.println(MOTPeak);
    }


    //    if (peakLocs[0] >= boosterI and peakLocs[0] < boosterF) // if booster exists and at correct place...
    //    {
    //
    //      if (peaks[0] >= peakThresholdBooster)
    //      {
    //        boosterPeak = peaks[0];
    //        boosterLoc = peakLocs[0];
    //      }
    //
    //      for (int i = 1; i <= 3; i++)
    //      {
    //        // scan peak list for a peak at the slower location
    //        if (peakLocs[i] >= boosterI + 50 and peakLocs[i] <= boosterF + 50)
    //        {
    //          if (peaks[i] != 0)
    //          {
    //            if (peaks[i] >= peakThresholdSlower)
    //            {
    //              slowerPeak = peaks[i];
    //              slowerLoc = peakLocs[i];
    //              slowerLocked = 0; // locked
    //            }
    //            else
    //            {
    //              slowerLocked = 1; // change status to unlocked;
    //            }
    //          }
    //
    //        }
    //        // scan peak list for a peak at the repump location
    //        else if (peakLocs[i] >= boosterI + 105 and peakLocs[i] <= boosterF + 105)
    //        {
    //          if (peaks[i] != 0)
    //          {
    //            if (peaks[i] >= peakThresholdRepump)
    //            {
    //              repumpPeak = peaks[i];
    //              repumpLoc = peakLocs[i];
    //              repumpLocked = 0; // locked
    //            }
    //            else
    //            {
    //              repumpLocked = 1; // change status to unlocked
    //            }
    //          }
    //
    //        }
    //        // scan peak list for a peak at the MOT location
    //        else if (peakLocs[i] >= boosterI + 165 and peakLocs[i] <= boosterF + 165)
    //        {
    //          if (peaks[i] != 0)
    //          {
    //            if (peaks[i] >= peakThresholdMOT)
    //            {
    //              MOTPeak = peaks[i];
    //              MOTLoc = peakLocs[i];
    //              MOTLocked = 0; // locked
    //            }
    //            else
    //            {
    //              MOTLocked=1; // change status to unlocked
    //            }
    //          }
    //        }
    //      }
    //
    //      if (boosterPeak * slowerPeak * repumpPeak * MOTPeak != 0)
    //      {
    //        Serial.println(boosterPeak);
    //        Serial.println(slowerPeak);
    //        Serial.println(repumpPeak);
    //        Serial.println(MOTPeak);
    //        Serial.println(" ");
    //      }
    //
    //      if (slowerLocked == 1)
    //      {
    //        Serial.println("Slower Unlocked!");
    //      }
    //
    //      if (repumpLocked == 1)
    //      {
    //        Serial.println("Repump Unlocked!");
    //      }
    //
    //      if (MOTLocked == 1)
    //      {
    //        Serial.println("MOT Unlocked!");
    //      }
    //
    //    }





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
    delay(20);
    Serial.println("====");
  }
}
