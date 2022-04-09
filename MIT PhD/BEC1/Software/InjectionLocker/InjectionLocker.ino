// Define global variables
float taskTime = 200; // do some task for taskTime millisecs. 
unsigned long startTime; //start time
unsigned long endTime; //end time
float val = 0.0; //voltage read
float input = 0.0; //voltage read
float maxVoltage = 0.0; // maxVoltage
int trigCount = 0;
float threshold = 0; // lock threshold
int outputPin = 9;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
}

// FP scan freq is 48.72 Hz.

void loop() {

  startTime = millis();
  endTime=startTime;

  // find maxVoltage over taskTime
  while(endTime - startTime <= taskTime)
  {
    digitalWrite(LED_BUILTIN,HIGH);
    input = analogRead(A1)*5./1023.;
    if (input > maxVoltage)
    {
      maxVoltage = input;
    }
    endTime = millis();
  }

  // implement lock logic here
  // first compare against threshold:
  if (maxVoltage < threshold)  // probably have to set threshold manually first
  {
    // enters recovery mode
    threshold = 0; // do nothing for now

    // first jump current to something high...
    analogWrite(outputPin,1);

    // then slowly rammp down:
    // make for loop here.
  }
  else
  {
    //enters active stabilization mode
    threshold = 0; // do nothing for now
  }
  
  //
  Serial.println(maxVoltage);
  endTime = 0;
  startTime = 0;  
  maxVoltage = 0;

  
  delay(200);
}
