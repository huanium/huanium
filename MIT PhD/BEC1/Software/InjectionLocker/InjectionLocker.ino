/*
   Author: Huan Q. Bui
   MIT, April 2022

   This program is intended for stabilizing the Li injection lock setup.
   There are two modes: recovery and active stabilization.
   Inspiration: arXiv:1602.03504
*/



// Define global variables
int trigLevel = 600; // trigger level, corresponding to 1.2V
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
int taskCounter = 530; // good time span = 340

// 0 for true, 1 for false
int boosterLocked = 0;
int slowerLocked = 0;
int repumpLocked = 0;
int MOTLocked = 0;



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




void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
  analogReadResolution(12);
}


void loop()
{
   //Serial.println(analogRead(A0));
  
  // find trigger analog
  int oldVal = analogRead(A0);
  delay(2); //wait 1 ms before finding next val
  int val = analogRead(A0);

  //Serial.println(oldVal);
  //Serial.println(val);

  delayMicroseconds(10800);

  if (val >= trigLevel and oldVal <= trigLevel) // rising edge
  {
    // if triggered
    

    // store FParray and its max
    int FParray[taskCounter];
    for (int i = 0; i <= taskCounter; i++)
    {
      int FPsignal = analogRead(A1);
      FParray[i] = FPsignal;
      delayMicroseconds(20);
    }

    for (int i =0; i <= taskCounter; i++)
    {
      Serial.println(FParray[i]);
      delay(2);
    }

    unsigned long start = micros();
    while (micros() - start <= 5*1000)
    {
      Serial.println(2400);
    }

    delay(1000);

    // peak detect
    int boosterPeak = 0;
    int slowerPeak = 0;
    int MOTPeak = 0;
    int repumpPeak = 0;

    int boosterLoc = 0;
    int slowerLoc = 0;
    int MOTLoc = 0;
    int repumpLoc = 0;


    // find window containing the booster
    // always assuming that the booster is locked
    // always assuming that the booster is the first peak

    int boosterI = 0;
    int boosterF = 0;
    for (int i = 0; i <= taskCounter - 2; i++)
    {
      if (FParray[i - 1] < FParray[i] and FParray[i] > FParray[i + 1]) // if peak @ [i]
      {
        if (i >= 30) // for safety purposes... don't want to trigger too early
        {
          boosterI = i - 20;
          boosterF = i + 20;
          boosterPeak = FParray[i];
          boosterLoc = i;
        }
        else
        {
          boosterI = 0;
          boosterF = i + 20;
        }
        // only interested in first peak, so once occurred, we stop looking
        continue;
      }
    }

//    Serial.println(boosterI);
//    Serial.println(boosterF);
//    Serial.println("====");

  }
}

//    // look for slower
//    if (peakBetween(FParray, boosterI + 50, boosterF + 50) == 0)
//    {
//      // if there is slower
//      slowerPeak = peakValBetween(FParray, boosterI + 50, boosterF + 50);
//      slowerLoc = peakIndBetween(FParray, boosterI + 50, boosterF + 50);
//      slowerLocked = 0;
//
//      if (slowerPeak < peakThresholdSlower and slowerPeak > 0)
//      {
//        Serial.println("Slower Unlocked!");
//        Serial.println(slowerPeak);
//        slowerLocked = 1;
//      }
//    }
//
//    // look for repump
//    if (peakBetween(FParray, boosterI + 105, boosterF + 105) == 0)
//    {
//      // there is repump.
//      repumpPeak = peakValBetween(FParray, boosterI + 105, boosterF + 105);
//      repumpLoc = peakIndBetween(FParray, boosterI + 105, boosterF + 105);
//      repumpLocked = 0;
//
//      if (repumpPeak < peakThresholdRepump and repumpPeak > 0)
//      {
//        Serial.println("Repump Unlocked!");
//        Serial.println(repumpPeak);
//        repumpLocked = 1;
//      }
//    }
//
//    // look for MOT
//    if (peakBetween(FParray, boosterI + 156, boosterF + 156) == 0)
//    {
//      // there is MOT.
//      MOTPeak = peakValBetween(FParray, boosterI + 156, boosterF + 156);
//      MOTLoc = peakIndBetween(FParray, boosterI + 156, boosterF + 156);
//      MOTLocked = 0;
//
//      if (MOTPeak < peakThresholdMOT and MOTPeak > 0)
//      {
//        Serial.println("MOT Unlocked!");
//        Serial.println(MOTPeak);
//        MOTLocked = 1;
//      }
//    }
//
//    // print everything only if all is good
//    if (boosterPeak * slowerPeak * repumpPeak * MOTPeak > 0)
//    {
//      Serial.println(boosterPeak);
//      Serial.println(slowerPeak);
//      Serial.println(repumpPeak);
//      Serial.println(MOTPeak);
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
