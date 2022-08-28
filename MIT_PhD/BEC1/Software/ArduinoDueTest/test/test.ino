// Pin 13 has an LED connected on the Arduino Due board.
//  (yellow, next to the power pin)
// give it a name:
int led = 13;
int trigger = 0; // 0 means GO, 1 means STOP
const byte interruptPin = 22;



// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  Serial.begin(115200); //setup serial connection
  pinMode(led, OUTPUT);     
  attachInterrupt(digitalPinToInterrupt(interruptPin), trig, RISING);
}

void trig()
{
  trigger = 0;
}


// the loop routine ... loops
void loop() {

  if (trigger == 0)
  {
    delay(1000); // wait for 0.4 second

    Serial.println("blah");
    trigger = 1;
  }
                
  
}
