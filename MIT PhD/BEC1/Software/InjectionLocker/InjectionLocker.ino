/*
   Author: Huan Q. Bui
   MIT, April 2022

   This program is intended for stabilizing the Li injection lock setup.
   There are two modes: recovery and active stabilization.
   Inspiration: arXiv:1602.03504
*/


// Define global variables
int trigLevel = 600; // trigger level
int currentOffsetSlower = 0;
int currentOffsetRepump = 0;
int currentOffsetMOT = 0;
int currentDelta = 0; // used in ACTIVE STABILIZATION

int peakThresholdBooster = 500; //
int peakThresholdSlower = 1300; //
int peakThresholdRepump = 350; //
int peakThresholdMOT = 1500; //
int peakThreshold = 300; // has to be this big to be considered a peak!

// how many samples per scan
int taskCounter = 275; // good time span

// offset from Booster time stamp
int slowerOffset = 40;
int repumpOffset = 40 + 45;
int MOTOffset = 40 + 45 + 42;

// 0 for true, 1 for false... but only call adjust() when reaches 2 (3 strikes and you're out!)
int boosterLocked = 0;
int slowerLocked = 0;
int repumpLocked = 0;
int MOTLocked = 0;

// initial current jumps:
int slowerCurrentJump = 1000;
int repumpCurrentJump = 1000;


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
  Serial.println("============");
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


void adjustSlower()
{
  Serial.println("Adjusting Slower...");
  Serial.println("  ");
  analogWrite(DAC0, currentOffsetSlower + slowerCurrentJump); //DAC0 = DAC2 on board
  delay(1000); // wait to thermalize
}



void adjustRepump()
{
  Serial.println("Adjusting Repump...");
  Serial.println("  ");
  analogWrite(DAC1, currentOffsetRepump + repumpCurrentJump); // DAC1 = DAC1 on board
  delay(1000); // wait to thermalize
}

void adjustMOT()
{
  Serial.println("Adjusting MOT...");
  Serial.println("  ");
  //analogWrite(MOT, currentOffsetMOT + 1000); // do something for now
  delay(1000); // wait to thermalize
}


void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
  analogReadResolution(12);

  // initialize current offset on all lasers to mid range of DAC:
  analogWrite(DAC0, 500);  // DAC2 on the board = slower
  analogWrite(DAC1, 500);  // DAC1 on the board = repump
  
}

void loop()
{
  /////////////////////////////////////////////////////////
  ///////// TRIGGER & PEAK DETECTION //////////////////////
  /////////////////////////////////////////////////////////

  int oldVal = analogRead(A0);
  delay(2); //wait 2 ms before finding next val
  int val = analogRead(A0);

  delayMicroseconds(2000);

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
    // print out booster info
    // locateBooster(boosterI, boosterF, boosterPeak);


    /////////////////////////////////////////////////////////////////
    // LOCK LOGIC HERE  /////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////

    // slower
    slowerPeak = peakValBetween(FParray, boosterI + slowerOffset, boosterF + slowerOffset);

    if (slowerPeak < peakThresholdSlower)
    {
      Serial.println("Slower Unlocked...");
      if (slowerLocked < 3)
      {
        slowerLocked++;
      }
      
      if (slowerLocked == 3 and currentOffsetSlower <= slowerCurrentJump) // only act after 3 strikes
      {
        adjustSlower();
        currentOffsetSlower-=2;
      }
      else
      {
        // if after one cycle doesn't work... reset and try again
        currentOffsetSlower = 0;
      }
    }
    else
    { 
      // stop adjusting
      slowerLocked = 0;
    }

    // repump
    repumpPeak = peakValBetween(FParray, boosterI + repumpOffset, boosterF + repumpOffset);

    if (repumpPeak < peakThresholdRepump)
    {
      Serial.println("Repump Unlocked...");
      if (repumpLocked < 3)
      {
        repumpLocked++;
      }
      
      if (repumpLocked == 3 and currentOffsetRepump <= repumpCurrentJump) // only act after 3 strikes
      {
        adjustRepump();
        currentOffsetRepump-=2;
      }
      else
      {
        // if after one cycle doesn't work... reset and try again
        currentOffsetRepump = 0;
      }
    }
    else
    {
      repumpLocked = 0;
    }

    // MOT
    MOTPeak = peakValBetween(FParray, boosterI + MOTOffset, boosterF + MOTOffset);

    if (MOTPeak < peakThresholdMOT)
    {
      Serial.println("MOT Unlocked...");
      if (MOTLocked < 3)
      {
        MOTLocked++;
      }
      adjustMOT();
    }
    else
    {
      MOTLocked = 0;
    }

    // print status
    printLockStatus(boosterPeak, slowerPeak, repumpPeak, MOTPeak);

    // the end
    delay(500);
  }
  
}
