const int audioPin = A0;
const int switchPinA = 2; // Chua 1
const int switchPinB = 3; // Chua 2
const int threshold = 768; // THRESHOLD DEPENDS ON AUDIO FILE AND WINDOWS/MUSIC PLAYER VOLUME

void setup() {
  Serial.begin(9600);
  pinMode(switchPinA, OUTPUT);
  pinMode(switchPinB, OUTPUT); 
}

void loop() {
  int level = analogRead(audioPin);
  Serial.println(level);
  delay(500);
  if (level > threshold) {
      Serial.println("SWITCHED HIGH");
      digitalWrite(switchPinA, HIGH);
      digitalWrite(switchPinB, HIGH);
  } else {
    Serial.println("SWITCHED LOW");
      digitalWrite(switchPinA, LOW);
      digitalWrite(switchPinB, LOW);
  }
  /*
  digitalWrite(switchPinA, HIGH);
  digitalWrite(switchPinB, HIGH);
  delay(3000);
  digitalWrite(switchPinA, LOW);
  digitalWrite(switchPinB, LOW);
  delay(3000);
  */
}
