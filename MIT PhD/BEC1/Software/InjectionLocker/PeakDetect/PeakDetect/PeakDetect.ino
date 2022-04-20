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
int trigLevel = 200; // trigger level

int currentOffsetBooster = 0;
int currentOffsetSlower = 0;
int currentOffsetRepump = 0;
int currentOffsetMOT = 0;
int currentDelta = 0; // used in ACTIVE STABILIZATION

int peakThresholdBooster = 600; //
int peakThresholdSlower = 1300; //
int peakThresholdRepump = 1900; //
int peakThresholdMOT = 1300; //
int peakThreshold = 300; // has to be this big to be considered a peak!
int boosterPeakMax = 1000; // if booster exceeds this, then trigger is wrong!

// use these to compare results between loops
float boosterMAX = 700;
float slowerMAX = 1700;
float repumpMAX = 2400;
float MOTMAX = 1800;

// how many samples per scan
int taskCounter = 350; // good time span

// offset from Booster time stamp
int slowerOffset = 53;
int repumpOffset = 53 + 62;
int MOTOffset = 53 + 62 + 53;

// 0 for true, 1 for false... but only call adjust() when reaches 2 (3 strikes and you're out!)
int boosterLocked = 0;
int slowerLocked = 0;
int repumpLocked = 0;
int MOTLocked = 0;

// initial current jumps:
int boosterCurrentJump = 4095;
int slowerCurrentJump = 4095;
int repumpCurrentJump = 4095;
int MOTCurrentJump = 4095;

int currentAdjustStepSize = 7; // range: 0-4095
int delta = 1;
int boosterOptimizeCounter = 0; // only optimize after 5 consective strikes
int repumpOptimizeCounter = 0; // only optimize after 5 consective strikes
int slowerOptimizeCounter = 0; // only optimize after 5 consecutive strikes
int MOTOptimizeCounter = 0; // only optimize after 5 consecutive strikes

// use these to compare between consecutive runs
int boosterPeakOld = 0;
int slowerPeakOld = 0;
int repumpPeakOld = 0;
int MOTPeakOld = 0;


// find peak between two indices in an array, returns 0 if none
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
    if (maxVal >= peakThreshold and maxVal <= 4095)
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
    if (maxVal >= peakThreshold and maxVal <= 4095)
    {
      return maxVal;
    }
  }
  return 0;
}


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
    Serial.println("====");
    delay(1);
  }

  Serial.println(" ");
  delay(1000);
}


void printStatus(int boosterPeak, int slowerPeak, int repumpPeak, int MOTPeak)
{
  Serial.print("Booster peak: ");
  Serial.println(boosterPeak);
  Serial.print("Slower peak: ");
  Serial.println(slowerPeak);
  Serial.print("Repump peak: ");
  Serial.println(repumpPeak);
  Serial.print("MOT peak: ");
  Serial.println(MOTPeak);
}


void printLockStatus(int boosterPeak, int slowerPeak, int repumpPeak, int MOTPeak)
{
  // print status
  // booster
  Serial.print("Booster peak: ");
  Serial.println(boosterPeak);
  // slower
  if (slowerLocked == 0 or slowerLocked == 1 or slowerLocked == 2)
  {
    Serial.print("Slower peak:");
    Serial.println(slowerPeak);
  }
  if (slowerLocked == 3)
  {
    Serial.println("Slower unlocked!");
  }
  // repump
  if (repumpLocked == 0 or repumpLocked == 1 or repumpLocked == 2)
  {
    Serial.print("Repump peak:");
    Serial.println(repumpPeak);
  }
  if (repumpLocked == 3)
  {
    Serial.println("Repump unlocked!");
  }
  // MOT
  if (MOTLocked == 0 or MOTLocked == 1 or MOTLocked == 2)
  {
    Serial.print("MOT peak:");
    Serial.println(MOTPeak);
  }
  if (MOTLocked == 3)
  {
    Serial.println("MOT unlocked!");
  }
  Serial.println("==================");
}


void locateBooster(int boosterI, int boosterF, int boosterPeak)
{
  Serial.println("Booster:");
  Serial.println(boosterI);
  Serial.println(boosterF);
  Serial.println(boosterPeak);
  Serial.println("============");
  delay(1000);
}

void adjustBooster()
{
  // do nothing for now
}


void adjustSlower()
{
  //Serial.println("Adjusting Slower...");
  //Serial.println("  ");
  analogWrite(DAC0, currentOffsetSlower + slowerCurrentJump); //DAC0 = DAC2 on board
}


void adjustRepump()
{
  //Serial.println("Adjusting Repump...");
  //Serial.println("  ");
  analogWrite(DAC1, currentOffsetRepump + repumpCurrentJump); // DAC1 = DAC1 on board
}

void adjustMOT()
{
  // do nothing for now
}


void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
  analogReadResolution(12);
  analogWriteResolution(12); // write values from 0-4095... 0.55 - 2.75 V

  // initialize current offset on all lasers to mid range of DAC:
  // analogWrite(DAC0, 2048);  // DAC2 on the board = slower
  // analogWrite(DAC1, 2048);  // DAC1 on the board = repump

}

void loop()
{
  /////////////////////////////////////////////////////////
  ///////// TRIGGER & PEAK DETECTION //////////////////////
  /////////////////////////////////////////////////////////

  int oldVal = analogRead(A0);
  delayMicroseconds(2000); //wait 2 ms before finding next val
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

    testScope(taskCounter, FParray);
    // peakDetect(taskCounter, FParray);



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
    // always assuming that the booster is locked for now
    // always assuming that the booster is the first peak

    // locate the booster, as reference for other peaks
    int boosterI = 0;
    int boosterF = 0;
    for (int i = 1; i <= taskCounter - 3; i++)
    {
      if (FParray[i - 1] < FParray[i] and FParray[i] > FParray[i + 1] and FParray[i] >= peakThreshold) // if peak @ [i]
      {
        if (i >= 10) // for safety purposes... don't want to trigger too early
        {
          boosterI = i - 10;
          boosterF = i + 10;
          boosterPeak = FParray[i];
          boosterLoc = i;
          break;
        }
      }
    }



    if (boosterPeak <= boosterPeakMax) // if booster exceeds this, then trigger is wrong --> do nothing
    {
      // print out booster info
      // locateBooster(boosterI, boosterF, boosterPeak);


      /////////////////////////////////////////////////////////////////
      ///////// LOCK LOGIC  ///////////////////////////////////////////
      /////////////////////////////////////////////////////////////////

   
      // BOOSTER
      if (boosterPeak < peakThresholdBooster)
      {
        Serial.println("Booster Unlocked...");
        if (boosterLocked < 3)
        {
          if (boosterPeakOld < peakThresholdBooster)
          {
            boosterLocked++; // only add if previous shot also bad
          }
          else
          {
            boosterLocked = 0; // if last shot was good then reset, probably noise
          }
        }

        if (boosterLocked == 3) // act after 3 CONSECUTIVE strikes
        {
          // if currentOffset can still be lowered
          if (currentOffsetBooster <= boosterCurrentJump)
          {
            adjustBooster();
            currentOffsetBooster -= currentAdjustStepSize;
          }
          // if not, then reset
          else
          {
            currentOffsetBooster = 0;
          }
        }
      }
      else // if Peak is good, then reset strikes and optimize
      {
        boosterLocked = 0;
        if (boosterPeak / boosterMAX <= 0.95)
        {
          if (boosterOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
          {
            // for now, optimize means lower the current just a bit to stay away from the edge
            currentOffsetBooster -= delta;
            adjustBooster();
            // reset strikes
            boosterOptimizeCounter = 0;
          }
          else // counter only reaches 3 only for 3 consecutive shots
          {
            if (boosterPeakOld / boosterMAX <= 0.95)
            {
              boosterOptimizeCounter++;
            }
            else
            {
              boosterOptimizeCounter = 0;
            }
          }
        }
      }

      // SLOWER
      slowerPeak = peakValBetween(FParray, boosterI + slowerOffset, boosterF + slowerOffset);

      if (slowerPeak < peakThresholdSlower)
      {
        Serial.println("Slower Unlocked...");
        if (slowerLocked < 3)
        {
          if (slowerPeakOld < peakThresholdSlower)
          {
            slowerLocked++; // only add if previous shot also bad
          }
          else
          {
            slowerLocked = 0; // if last shot was good then reset, probably noise
          }
        }

        if (slowerLocked == 3) // act after 3 CONSECUTIVE strikes
        {
          // if currentOffset can still be lowered
          if (currentOffsetSlower <= slowerCurrentJump)
          {
            adjustSlower();
            currentOffsetSlower -= currentAdjustStepSize;
          }
          // if not, then reset
          else
          {
            currentOffsetSlower = 0;
          }
        }
      }
      else // if Peak is good, then reset strikes and optimize
      {
        slowerLocked = 0;
        if (slowerPeak / slowerMAX <= 0.95)
        {
          if (slowerOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
          {
            // for now, optimize means lower the current just a bit to stay away from the edge
            currentOffsetSlower -= delta;
            adjustSlower();
            // reset strikes
            slowerOptimizeCounter = 0;
          }
          else // counter only reaches 3 only for 3 consecutive shots
          {
            if (slowerPeakOld / slowerMAX <= 0.95)
            {
              slowerOptimizeCounter++;
            }
            else
            {
              slowerOptimizeCounter = 0;
            }
          }
        }
      }

      // REPUMP
      repumpPeak = peakValBetween(FParray, boosterI + repumpOffset, boosterF + repumpOffset);

      if (repumpPeak < peakThresholdRepump)
      {
        Serial.println("Repump Unlocked...");
        if (repumpLocked < 3)
        {
          if (repumpPeakOld < peakThresholdRepump)
          {
            repumpLocked++; // only add if previous shot also bad
          }
          else
          {
            repumpLocked = 0; // if last shot was good then reset, probably noise
          }
        }

        if (repumpLocked == 3) // act after 3 CONSECUTIVE strikes
        {
          // if currentOffset can still be lowered
          if (currentOffsetRepump <= repumpCurrentJump)
          {
            adjustRepump();
            currentOffsetRepump -= currentAdjustStepSize;
          }
          // if not, then reset
          else
          {
            currentOffsetRepump = 0;
          }
        }
      }
      else // if Peak is good, then reset strikes and optimize to 0.95 of MAX
      {
        repumpLocked = 0;
        if (repumpPeak / repumpMAX <= 0.95)
        {
          if (repumpOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
          {
            // for now, optimize means lower the current just a bit to stay away from the edge
            currentOffsetRepump -= delta;
            adjustRepump();
            // reset strikes
            repumpOptimizeCounter = 0;
          }
          else // counter only reaches 3 only for 3 consecutive shots
          {
            if (repumpPeakOld / repumpMAX <= 0.95)
            {
              repumpOptimizeCounter++;
            }
            else
            {
              repumpOptimizeCounter = 0;
            }
          }
        }
      }

      // MOT
      MOTPeak = peakValBetween(FParray, boosterI + MOTOffset, boosterF + MOTOffset);

      if (MOTPeak < peakThresholdMOT)
      {
        Serial.println("MOT Unlocked...");
        if (MOTLocked < 3)
        {
          if (MOTPeakOld < peakThresholdMOT)
          {
            MOTLocked++; // only add if previous shot also bad
          }
          else
          {
            MOTLocked = 0; // if last shot was good then reset, probably noise
          }
        }
        if (MOTLocked == 3) // act after 3 strikes
        {
          // if currentOffset can still be lowered
          if (currentOffsetMOT <= MOTCurrentJump)
          {
            adjustMOT();
            currentOffsetMOT -= currentAdjustStepSize;
          }
          // if not, then reset
          else
          {
            currentOffsetMOT = 0;
          }
        }
      }
      else // if peak is good, then enters optimization
      {
        MOTLocked = 0;
        if (MOTPeak / MOTMAX <= 0.95)
        {
          if (MOTOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
          {
            // for now, optimize means lower the current just a bit to stay away from the edge
            currentOffsetMOT -= delta;
            adjustMOT();
            // reset strikes
            MOTOptimizeCounter = 0;
          }
          else // counter only reaches 3 only for 3 consecutive shots
          {
            if (MOTPeakOld / MOTMAX <= 0.95)
            {
              MOTOptimizeCounter++;
            }
            else
            {
              MOTOptimizeCounter = 0;
            }
          }
        }
      }


      // print status
      // printLockStatus(boosterPeak, slowerPeak, repumpPeak, MOTPeak);

      // the end
      boosterPeakOld = boosterPeak;
      slowerPeakOld = slowerPeak;
      repumpPeakOld = repumpPeak;
      MOTPeakOld = MOTPeak;
      delay(25);
    }
   


  }

}
