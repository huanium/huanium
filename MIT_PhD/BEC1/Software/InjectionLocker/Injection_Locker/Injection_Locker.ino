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
  or make voltage divider
  R1 = 12.7 kOhms
  R2 = 220 kOhms
   want current mod range of 6 mA --> want Voltage range (210C) of 0.06 V
   arduino due has range of (2.75-0.55) = 2.2V
   ==> need attenuation factor of 36.7
   ==> in dB: ~30 dB
   Next update (incoming). Update as of April 25, 2022.
   implement physical switch to toggle between peak detect mode and lock mode
   Peak detect mode allows one to set the parameters to properly initialize the lock servo
*/

// manually dialed-in parameters:
int trigLevel = 1100; // trigger level
int trig_delay = 2000;
int peakThreshold = 250; // has to be this big to be considered a peak!
int boosterPeakMax = 2000; // if booster exceeds this, then trigger is wrong!
// some absolute MAX values for now
float boosterMAX = 1100;
float slowerMAX = 1100;
float repumpMAX = 1100;
float MOTMAX = 1700;

// trigPoints
int trigPointOne = 70;
int trigPointTwo = 140;
int prepCounter = 0;
float quality = 0.97;
float qualityRAW = quality + 0.015;
float peakToThres = 0.85;

int peakThresholdBooster = round(boosterMAX * peakToThres);
int peakThresholdSlower = round(slowerMAX * peakToThres);
int peakThresholdRepump = round(repumpMAX * peakToThres);
int peakThresholdMOT = round(MOTMAX * peakToThres);

int currentOffsetBooster = 0;
int currentOffsetSlower = 0;
int currentOffsetRepump = 0;
int currentOffsetMOT = 0;

// how many samples per scan
int taskCounter = 350; // good time span
int trigCounter = 0; // use this to adjust trigger level
float boosterLocAvg = 0;

// offset from Booster time stamp, valid for 30 Hz FP scan frequency
// to do: auto-adjust acquire ---Offset as well
int slowerOffset = 53;
int repumpOffset = slowerOffset + 62;
int MOTOffset = repumpOffset + 53;

// 0 for true, 1 for false... but only call adjust() when reaches 2 (3 strikes and you're out!)
int boosterLocked = 0;
int slowerLocked = 0;
int repumpLocked = 0;
int MOTLocked = 0;

// initial current jumps:
int repumpCurrentJump = 4070;
int MOTCurrentJump = 4070;
int SlowerCurrentJump = 4070;


int currentAdjustStepSize = 10; // range: 0-4095
int delta = 1;
int repumpOptimizeCounter = 0; // only optimize after n consective strikes
int repumpOptimizeCounterMinus = 0;
int MOTOptimizeCounter = 0; // only optimize after n consecutive strikes
int MOTOptimizeCounterMinus = 0;
int slowerOptimizeCounter = 0; // only optimize after n consecutive strikes
int slowerOptimizeCounterMinus = 0;

int MOT_mod_current = 2048; // 
int Repump_mod_current = 2048;

// use these to compare between consecutive runs
int boosterPeakOld = 0;
int slowerPeakOld = 0;
int repumpPeakOld = 0;
int MOTPeakOld = 0;

// updateMAX is run once every some iterations 
int updateMAX_after = 10;
// print lock status once every some iterations:
int printLockStatus_after = 5;

// counters:
int updateMAXCounter = 0;
int printLockStatus_COUNTER = 0;

// BUZZER:
const int buzzer = 9;


/////////////////////////////////////////////////////////////////////
//////////////////// UTILITIES //////////////////////////////////////
/////////////////////////////////////////////////////////////////////

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



void printLockStatus(int boosterPeak, int slowerPeak, int repumpPeak, int MOTPeak, int boosterLoc, int trigLevel)
{
  // print status
  Serial.print("Trigger Level: ");
  Serial.println(trigLevel);
  // booster
  Serial.print("Booster location: ");
  Serial.println(boosterLoc);
  Serial.print("Booster peak: ");
  Serial.println(boosterPeak);

  // slower
  Serial.print("Slower peak: ");
  Serial.println(slowerPeak);

  // repump
  Serial.print("Repump peak: ");
  Serial.println(repumpPeak);

  // MOT
  Serial.print("MOT peak: ");
  Serial.println(MOTPeak);

  if (slowerLocked == 3)
  {
    Serial.println("Slower unlocked!");
  }
  if (repumpLocked == 3)
  {
    Serial.println("Repump unlocked!");
  }
  if (MOTLocked == 3)
  {
    Serial.println("MOT unlocked!");
  }

  Serial.println("------------------");
  Serial.print("boosterMAX: ");
  Serial.println(boosterMAX);
  Serial.print("slowerMAX: ");
  Serial.println(slowerMAX);
  Serial.print("repumpMAX: ");
  Serial.println(repumpMAX);
  Serial.print("MOTMAX: ");
  Serial.println(MOTMAX);

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

//////////////////////////////////////////////////////////////////////////////////////////
////////  CURRENT ADJUST FUNCTIONS ///////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


void adjustRepump()
{
  //Serial.println("Adjusting Repump...");
  //Serial.println("  ");
  analogWrite(DAC0, Repump_mod_current); // DAC1 = DAC1 on board
}

void adjustMOT()
{
  // do nothing for now
  analogWrite(DAC1, MOT_mod_current); //DAC0 = DAC2 on board
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////// UPDATE MAX + UPDATE MAX RAW ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

void updateMAX(int boosterPeak, int slowerPeak, int repumpPeak, int MOTPeak)
{
  if (boosterPeak >= boosterMAX and boosterPeak <= 1.005 * boosterMAX) //safety mechanism
  {
    boosterMAX = boosterPeak;
    peakThresholdBooster = round(peakToThres * boosterPeak);
  }

  if (slowerPeak >= slowerMAX and slowerPeak <= 1.005 * slowerMAX) // safety mechanism
  {
    slowerMAX = slowerPeak;
    peakThresholdSlower = round(peakToThres * slowerPeak);
  }

  if (repumpPeak >= repumpMAX and repumpPeak <= 1.005 * repumpMAX) // safety mechanism
  {
    repumpMAX = repumpPeak;
    peakThresholdRepump = round(peakToThres * repumpPeak);
  }

  if (MOTPeak >= MOTMAX and MOTPeak <= 1.005 * MOTMAX) // safety mechanism
  {
    MOTMAX = MOTPeak;
    peakThresholdMOT = round(peakToThres * MOTPeak);
  }
}

void updateMAXRAW(int boosterPeak, int slowerPeak, int repumpPeak, int MOTPeak)
{
  if (boosterPeak >= boosterMAX)
  {
    boosterMAX = round(qualityRAW * boosterPeak);
    peakThresholdBooster = round(peakToThres * boosterPeak);
  }

  if (slowerPeak >= slowerMAX)
  {
    slowerMAX = round(qualityRAW * slowerPeak);
    peakThresholdSlower = round(peakToThres * slowerPeak);
  }

  if (repumpPeak >= repumpMAX)
  {
    repumpMAX = round(qualityRAW * repumpPeak);
    peakThresholdRepump = round(peakToThres * repumpPeak);
  }

  if (MOTPeak >= MOTMAX)
  {
    MOTMAX = round(qualityRAW * MOTPeak);
    peakThresholdMOT = round(peakToThres * MOTPeak);
  }
}

void testScope(int taskCounter, int FParray[])
{
  Serial.println("Check point 2");
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


//////////////////////////////////////////////////////////////////////////////////////////
/////////////////// SETUP ARDUINO ////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
  analogReadResolution(12);
  analogWriteResolution(12); // write values from 0-4095... 0.55 - 2.75 V

  // initialize current offset on all lasers to mid range of DAC:
  analogWrite(DAC0, 2048);  // DAC2 on the board = MOT
  analogWrite(DAC1, 2048);  // DAC1 on the board = repump

  // BUZZER
  pinMode(buzzer, OUTPUT);
}


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////// RUN /////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

void act()
{
  /////////////////////////////////////////////////////////
  ///////// TRIGGER & PEAK DETECTION //////////////////////
  /////////////////////////////////////////////////////////

  int oldVal = analogRead(A0);
  delayMicroseconds(trig_delay); //wait 2 ms before finding next val
  int val = analogRead(A0);

  delayMicroseconds(50);

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
    // assuming that the booster is locked
    // assuming that the booster is the first peak

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

    // adjust the trigger to respond to correct for change in boosterLoc
    // average over 250 shots, then proceed with adjusting the trigLevel
    if (trigCounter < 250)
    {
      boosterLocAvg += boosterLoc / 250.0; // cast into float type...
      trigCounter++;
    }
    else
    {
      trigCounter = 0; // reset
      if (boosterLocAvg <= trigPointOne) // trigger is too late
      {
        trigLevel -= 3; // make trigger earlier
      }
      if (boosterLocAvg >= trigPointTwo) // trigger is too soon
      {
        trigLevel += 3 ; // make trigger later
      }
      boosterLocAvg = 0; //reset
    }

    if (boosterPeak <= boosterPeakMax) // if booster exceeds boosterPeakMax --> do nothing
    {
      // get peak values
      slowerPeak = peakValBetween(FParray, boosterI + slowerOffset, boosterF + slowerOffset);
      repumpPeak = peakValBetween(FParray, boosterI + repumpOffset, boosterF + repumpOffset);
      MOTPeak = peakValBetween(FParray, boosterI + MOTOffset, boosterF + MOTOffset);

      // in the first 20 triggers, update MAX values
      if (prepCounter <= 20)
      {
        prepCounter++;
        updateMAXRAW(boosterPeak, slowerPeak, repumpPeak, MOTPeak);
      }
      else // once done, go to Lock Mode
      {
        /////////////////////////////////////////////////////////////////
        ///////// LOCK LOGIC ////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////


        // SLOWER
        if (slowerPeak < peakThresholdSlower)
        {
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
            if (currentOffsetSlower <= SlowerCurrentJump)
            {
              // Repump_mod_current = currentOffsetRepump + repumpCurrentJump;
              // adjustSlower();
              currentOffsetSlower -= currentAdjustStepSize;
            }
            // if not, then reset
            else
            {
              currentOffsetSlower = 0;
            }
          }
        }
        else // if Peak is good, then reset strikes and optimize to quality of MAX
        {
          slowerLocked = 0;
          if (slowerPeak / slowerMAX <= quality)
          {
            if (slowerOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
            {
              // for now, optimize means lower the current just a bit to stay away from the edge
              // Repump_mod_current -= delta;
              // adjustRepump();
              // reset strikes
              slowerOptimizeCounter = 0;
            }
            else // counter only reaches only for n consecutive shots
            {
              if (slowerPeakOld / slowerMAX <= quality)
              {
                slowerOptimizeCounter++;
              }
              else
              {
                slowerOptimizeCounter = 0;
              }
            }
          }
          else
          {
            if (slowerOptimizeCounterMinus == 20)
            {
              // Repump_mod_current += delta;
              // adjustSlower();
              slowerOptimizeCounterMinus = 0;
            }
            else
            {
              if (slowerPeakOld / slowerMAX > quality)
              {
                slowerOptimizeCounterMinus++;
              }
              else
              {
                slowerOptimizeCounterMinus = 0;
              }
            }
          }
        }

        // REPUMP
        if (repumpPeak < peakThresholdRepump)
        {
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
              Repump_mod_current = currentOffsetRepump + repumpCurrentJump;
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
        else // if Peak is good, then reset strikes and optimize to quality of MAX
        {
          repumpLocked = 0;
          if (repumpPeak / repumpMAX <= quality)
          {
            if (repumpOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
            {
              // for now, optimize means lower the current just a bit to stay away from the edge
              Repump_mod_current -= delta;
              adjustRepump();
              // reset strikes
              repumpOptimizeCounter = 0;
            }
            else // counter only reaches only for n consecutive shots
            {
              if (repumpPeakOld / repumpMAX <= quality)
              {
                repumpOptimizeCounter++;
              }
              else
              {
                repumpOptimizeCounter = 0;
              }
            }
          }
          else
          {
            if (repumpOptimizeCounterMinus == 20)
            {
              Repump_mod_current += delta;
              adjustRepump();
              repumpOptimizeCounterMinus = 0;
            }
            else
            {
              if (repumpPeakOld / repumpMAX > quality)
              {
                repumpOptimizeCounterMinus++;
              }
              else
              {
                repumpOptimizeCounterMinus = 0;
              }
            }
          }
        }

        // MOT
        if (MOTPeak < peakThresholdMOT)
        {
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
              MOT_mod_current = currentOffsetMOT + MOTCurrentJump;
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
          if (MOTPeak / MOTMAX <= quality)
          {
            if (MOTOptimizeCounter == 3) // act when 3 CONSECUTIVE strikes exceeded:
            {
              // for now, optimize means lower the current just a bit to stay away from the edge
              MOT_mod_current -= delta;
              adjustMOT();
              // reset strikes
              MOTOptimizeCounter = 0;
            }
            else // counter only reaches 3 only for 3 consecutive shots
            {
              if (MOTPeakOld / MOTMAX <= quality)
              {
                MOTOptimizeCounter++;
              }
              else
              {
                MOTOptimizeCounter = 0;
              }
            }
          }
          else // if peak is actually bigger than MAX
          {
            if (MOTOptimizeCounterMinus == 20)
            {
              MOT_mod_current += delta;
              adjustMOT();
              MOTOptimizeCounterMinus = 0;
            }
            else
            {
              if (MOTPeakOld / MOTMAX > quality)
              {
                MOTOptimizeCounterMinus++;
              }
              else
              {
                MOTOptimizeCounterMinus = 0;
              }
            }
          }
        }
        ///////////// END OF LOCK LOGIC /////////////////////////////////
                

        ///////////// UPDATE LOCK STATE & PREP FOR NEXT ITERATION ///////
        // print status
        if (printLockStatus_COUNTER > printLockStatus_after)
        {
          printLockStatus(boosterPeak, slowerPeak, repumpPeak, MOTPeak, boosterLoc, trigLevel);
          printLockStatus_COUNTER = 0; // reset
        }
        else
        {
          printLockStatus_COUNTER++;
        }

        // the end
        boosterPeakOld = boosterPeak;
        slowerPeakOld = slowerPeak;
        repumpPeakOld = repumpPeak;
        MOTPeakOld = MOTPeak;

        // auto update MAX values, only if everything is locked
        // act only for every "updateMAX_after" iterations, to stay conservative

        if (boosterLocked * repumpLocked * MOTLocked * slowerLocked == 0)
        {
          if (updateMAXCounter > updateMAX_after)
          {
            updateMAX(boosterPeak, slowerPeak, repumpPeak, MOTPeak);
            updateMAXCounter = 0; //reset
          }
          else
          {
            updateMAXCounter++;
          }
        }
        delayMicroseconds(25 * 1000);
      }
    }
  }
}

void loop()
{

  if (analogRead(A2) >= 4000)
  {
    Serial.println("Waiting to engage...");
    analogWrite(DAC0, 2048);  // DAC2 on the board = MOT
    analogWrite(DAC1, 2048);  // DAC1 on the board = repump
    delay(500);
    // reset the MAXes
    boosterMAX = 1200;
    slowerMAX = 1100;
    repumpMAX = 750;
    MOTMAX = 1200;

    MOT_mod_current = 2048;
    Repump_mod_current = 2048;
  }
  else
  {
    act();
    delayMicroseconds(10000);  // wait 10 ms
  }
  

}
