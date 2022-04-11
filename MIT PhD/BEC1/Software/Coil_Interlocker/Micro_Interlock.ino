const int switchPin = 6;
const int voltagePin = 12;
const int alarmPin = 5;
//Interlock output pin.
const int outputPin = 7;
//Pin for buzzer; if interlock engaged, buzzer is on/beeps
const int buzzerPin = 9;
//Pin for status-indicating LED; if output is on, LED is on
const int ledPin = 3;

const long alarmThreshold = 2000;


long currentTime;
long oldTime;
long startTime;
long sampleTime = 500;
long alarmIntegrator = 0;

bool interlocked;
bool highMeasured;
bool switchedOn;
bool needsUpdate;

void setup() {
  Serial.begin(9600);
  pinMode(switchPin, INPUT);
  pinMode(voltagePin, OUTPUT);
  digitalWrite(voltagePin, HIGH);
  pinMode(alarmPin, INPUT);
  pinMode(buzzerPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(outputPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  oldTime = 0;
  startTime = millis();
  currentTime = startTime;
  interlocked = false;
  highMeasured = false;
  switchedOn = digitalRead(switchPin);
  if(switchedOn) {
    setNormalOperation();
  } else {
    setSwitchedOff();
  }
}

void loop() {
  currentTime = millis();
  bool tempSwitchedOn = digitalRead(switchPin);
  needsUpdate = needsUpdate || (tempSwitchedOn != switchedOn);
  switchedOn = tempSwitchedOn;
  if(tempSwitchedOn) {
    digitalWrite(LED_BUILTIN, LOW);
  } else {
    digitalWrite(LED_BUILTIN, HIGH);
  }
  if(!interlocked && switchedOn) {
    if(needsUpdate) {
      setNormalOperation();
      needsUpdate = false;
    }
    if(digitalRead(alarmPin) == HIGH && (!highMeasured)) {
      alarmIntegrator += sampleTime;
      highMeasured = true;
    }
    if(currentTime - oldTime > sampleTime) {
      oldTime = currentTime;
      if(highMeasured) {
        highMeasured = false;
      } else if(alarmIntegrator > 0) {
        alarmIntegrator -= sampleTime;
      }
    }
    interlocked = (alarmIntegrator > alarmThreshold);
    needsUpdate = interlocked;
  }
  else if(interlocked && switchedOn) {
    if(needsUpdate) {
      setInterlocked();
      needsUpdate = false;
    }
  }
  else if (!switchedOn) {
    if(needsUpdate) {
      setSwitchedOff();
      needsUpdate = false;
    }
  }
}

void setNormalOperation() {
  noTone(buzzerPin);
  digitalWrite(ledPin, LOW);
  digitalWrite(outputPin, HIGH);
  alarmIntegrator = 0;
}

void setInterlocked() {
  digitalWrite(ledPin, HIGH);
  tone(buzzerPin, 1000);
  digitalWrite(outputPin, LOW);
  alarmIntegrator = 0;
}

void setSwitchedOff() {
  noTone(buzzerPin);
  digitalWrite(ledPin, LOW);
  digitalWrite(buzzerPin, LOW);
  digitalWrite(outputPin, LOW);
  interlocked = false;
}
  
