#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))

// Define global variables
unsigned long startTime; //start time
float FPsignal = 0.0; //voltage read
float maxVoltage = 0.0; // maxVoltage
float trigLevel = 1.2; //trigger level
float threshold = 1.53; // lock threshold, 90% of absolute max
int booster = 9;  // booster lock
int currentOffset = 0;
int currentDelta = 0; // used in ACTIVE STABILIZATION
float period = 1000. / 48.688; // period of FP scan in millisecs
float peakThreshold = 1.0;
int taskCounter = 340;



void setup() {
  // put your setup code here, to run once:
  Serial.begin(230400); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);

  sbi(ADCSRA, ADPS2);
  cbi(ADCSRA, ADPS1);
  cbi(ADCSRA, ADPS0);
}



void loop() {

  // find trigger
  float oldVal = analogRead(A0) * 5. / 1023.;
  delay(2); //wait 3 ms before finding next val
  float val = analogRead(A0) * 5. / 1023.;


  if (val >= trigLevel and oldVal <= trigLevel) // rising edge
  {
    // if trigger condition is met...
    float FParray[taskCounter];
    for (int i = 0; i <= taskCounter; i++)
    {
      FPsignal = analogRead(A1) * 5. / 1023.;
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

    // put peak detect logic here
    // very simple algorithm for now...
    
    Serial.println(" ");
    float peaks[20]; // accomodates 20 peaks... or more IDK!
    int freePosition = 0;
    
    for (int j = 0; j <= taskCounter-3; j++)
    {
      float val1 = FParray[j];
      float val2 = FParray[j+1];
      float val3 = FParray[j+2];
     
      if (val1 < val2 and val3 < val2) // is a peak!
      {
        if (val2 >= peakThreshold)
        {
          //Serial.println(val2);
          peaks[freePosition] = val2;
          freePosition++;
        }
      }
      //Serial.println(FParray[j]);
    }

    // now sort the peaks into correct categories:
    float boosterPeaks[6];
    float slowerPeaks[6];
    int boosterFreePosition = 0;
    int slowerFreePosition = 0;

    // print out peaks!
    for (int i = 0; i <= freePosition-1; i++)
    {
      if (i==0 or i==2 or i==5 or i==7 or i==9)
      {
        slowerPeaks[slowerFreePosition] = peaks[i];
        slowerFreePosition++;
      }
      if (i==1 or i==3 or i==4 or i==6 or i==8)
      {
        boosterPeaks[boosterFreePosition] = peaks[i];
        boosterFreePosition++;
      }
      //Serial.println(peaks[i]);
    }

    // print out slower peaks!
    Serial.println("Slower peaks:");
    for (int i=0; i <= slowerFreePosition-1;i++)
    {
      Serial.println(slowerPeaks[i]);
    }

    // print out booster peaks!
    Serial.println("Booster peaks:");
    for (int i=0; i <= boosterFreePosition-1;i++)
    {
      Serial.println(boosterPeaks[i]);
    }       

    //Serial.println(maxVoltage);


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
//      startTime = millis();
//
//      //analogWrite(booster, currentOffset + 10); // adding about 4 mA, keep on for 100 ms
//      delay(200); // wait to thermalize
//
//      maxVoltage = 0;
//
//      for (int i = 0; i <= taskCounter; i++)
//      {
//        FPsignal = analogRead(A1) * 5. / 1023.;
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

    maxVoltage = 0;

    delay(1000);
  }
}
