void setup() {
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("Trigger Level: 100");
  Serial.println("Booster location: 20");
  Serial.println("Booster peak: 702");
  Serial.println("Slower peak: 1126");
  Serial.println("Repump peak: 759");
  Serial.println("MOT peak: 902");
  Serial.println("------------------");
  Serial.println("boosterMAX: 800.00");
  Serial.println("slowerMAX: 1087.00");
  Serial.println("repumpMAX: 743.00");
  Serial.println("MOTMAX: 888.00");

  Serial.println("Slower unlocked!");
  Serial.println("Repump unlocked!");
  Serial.println("MOT unlocked!");


  Serial.println("===================");


  delay(1500);
}
