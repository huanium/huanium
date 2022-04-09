// Define global variables
float taskTime = 200; // do some task for taskTime millisecs.
unsigned long startTime; //start time
unsigned long endTime; //end time
float val = 0.0; //voltage read
float oldVal = 0.0; //voltage read
float FPsignal = 0.0; //voltage read
float maxVoltage = 0.0; // maxVoltage
float trigLevel = 1.0; //trigger level
float threshold = 0; // lock threshold, 90% of absolute max
int booster = 9;  // booster lock
int currentOffset = 0; 
int currentAdjust = 0;
int currentDelta = 0; // used in ACTIVE STABILIZATION
float period = 1000. / 48.72; // period of FP scan in millisecs

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
}


void loop() {

  // find trigger
  oldVal = analogRead(A0) * 5. / 1023.;
  delay(3); //wait 3 ms before finding next val
  val = analogRead(A0) * 5. / 1023.;

  if (val >= trigLevel and oldVal <= trigLevel) // rising edge
  {
    // if trigger condition is met...
    startTime = millis();
    endTime = startTime;

    // find maxVoltage over two periods of FP scan
    while (endTime - startTime <= 2 * period)
    {
      digitalWrite(LED_BUILTIN, HIGH);
      FPsignal = analogRead(A1) * 5. / 1023.;
      if (FPsignal > maxVoltage)
      {
        maxVoltage = FPsignal;
      }
      Serial.println(FPsignal);
      endTime = millis();
    }

    // once done, write only 0's for 500 ms
    endTime = startTime;
    while (endTime - startTime <= 500)
    {
      digitalWrite(LED_BUILTIN, HIGH);
      Serial.println(1.0);
    }

    // implement lock logic here
    if (maxVoltage < threshold)  // probably have to set threshold manually first
    {
      // RECOVERY MODE

      // first jump current to something high for 100 ms
      // voltage to current control: 0.1 mA = 5 mV
      // voltage resolution of Uno: 5/255 = 0.02 V = 20 mW --> 0.4 mA per stop
      analogWrite(booster, currentOffset + 10); // adding about 4 mA, keep on for 100 ms
      delay(100);
      // then slowly ramp down in steps of 0.4 mA (smallest possible)
      // ramping down is important due to hysteresis

      while (currentAdjust >= 0)
      {
        currentAdjust = currentOffset--;
        analogWrite(booster, currentAdjust); // set a lower current offset
        delay(300); // wait for thermalization

        // find new maxVoltage over two periods of FP scan
        startTime = millis();
        endTime = startTime;
        maxVoltage = 0;
        
        while (endTime - startTime <= 2 * period)
        {
          FPsignal = analogRead(A1) * 5. / 1023.;
          if (FPsignal > maxVoltage)
          {
            maxVoltage = FPsignal;
          }
          endTime = millis();
        }
        endTime = startTime;

        // compare this against threshold, check if threshold is attained...
        if (maxVoltage >= threshold)
        {
          // locked ==> exit the recovery loop
          currentOffset = currentAdjust; // change the offset current to currentAdjust
          continue;
        }
        else
        {
          // if not locked yet, then repeat untill good
          currentAdjust--;
        }
        
      }
    }
    
    else // if maxVoltage >= threshold --> still locked
    {
      // ACTIVE STABILIZATION MODE
      // samples for peaks at currentOffset & currentOffset +/- currentDelta
      // if the peak detected at (+) decreases by no more than p1 percent --> set offset to (+)

      // if peak detected at (-) increases by p2 percent --> set offset to (-)
      threshold = 0;
    }

    // reset everything except for currentOffset
    Serial.println(maxVoltage);
    endTime = 0;
    startTime = 0;
    maxVoltage = 0;

    delay(200);
  }
  // if trigger condition not met then do nothing, loop repeats...

}
