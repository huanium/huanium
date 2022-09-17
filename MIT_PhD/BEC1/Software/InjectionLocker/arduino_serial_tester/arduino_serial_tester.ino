int unlock_counter = 0;
int unlock_window = 0;
int a = 0 ;

void setup() {
  Serial.begin(115200); //setup serial connection
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  a++;
  Serial.println("Trigger Level: 100");
  Serial.println("Booster location: 20");
  Serial.println("Booster peak: 702");
  Serial.println("Slower peak: 1126");
  Serial.println("Repump peak: 759");
  Serial.println("MOT peak: 902");
  Serial.println("------------------");
  Serial.print("boosterMAX: ");
  Serial.println(a);
  Serial.print("slowerMAX: ");
  Serial.println(a);
  Serial.print("repumpMAX: ");
  Serial.println(a);
  Serial.print("MOTMAX: ");
  Serial.println(a);

  unlock_counter++;

  if (unlock_counter >= 20 && unlock_window <= 10)
  {
    Serial.println("Slower unlocked!");
    Serial.println("Repump unlocked!");
    Serial.println("MOT unlocked!");
    // reset unlock_counter
    unlock_window++;
  }

  if (unlock_window > 10)
  {
    unlock_counter = 0;
    unlock_window = 0;
  }

  Serial.println("===================");

  delay(1000);
}
