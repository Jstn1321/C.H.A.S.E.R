// Arduino 1 Code
// Connections:
// - Pin 2: Sync wire to Arduino 2's Pin 2
// - Pin 13: Output pin (turns ON/OFF randomly)

const int SYNC_PIN = 12;
const int OUTPUT_PIN = 3;
const unsigned long SEED = 12345; // Shared seed for random numbers

unsigned long lastChangeTime = 0;
int changeCount = 0;
bool isMaster = false;
bool synced = false;
bool outputState = LOW;

void setup() {
  Serial.begin(9600);
  pinMode(OUTPUT_PIN, OUTPUT);
  digitalWrite(OUTPUT_PIN, LOW);
  
  // Initially set sync pin as input with pullup
  pinMode(SYNC_PIN, INPUT_PULLUP);
  delay(100);
  
  // Determine master/slave based on who pulls the line low first
  if (digitalRead(SYNC_PIN) == HIGH) {
    pinMode(SYNC_PIN, OUTPUT);
    digitalWrite(SYNC_PIN, LOW);
    delay(50);
    isMaster = true;
    Serial.println("I am MASTER");
  } else {
    Serial.println("I am SLAVE");
  }
  
  // Synchronization handshake
  if (isMaster) {
    pinMode(SYNC_PIN, OUTPUT);
    // Send sync pulse pattern
    for (int i = 0; i < 3; i++) {
      digitalWrite(SYNC_PIN, LOW);
      delay(100);
      digitalWrite(SYNC_PIN, HIGH);
      delay(100);
    }
    digitalWrite(SYNC_PIN, LOW);
  } else {
    pinMode(SYNC_PIN, INPUT);
    // Wait for sync pattern
    while (!synced) {
      if (digitalRead(SYNC_PIN) == LOW) {
        delay(50);
        if (digitalRead(SYNC_PIN) == HIGH) {
          synced = true;
          Serial.println("Synced!");
        }
      }
    }
  }
  
  // Initialize random seed
  randomSeed(SEED);
  
  // Synchronize time reference
  lastChangeTime = millis();
  
  Serial.println("System ready");
}

void loop() {
  unsigned long currentTime = millis();
  
  // Generate random interval around 1-2 seconds (500ms to 2500ms range)
  unsigned long randomInterval = random(500, 2500);
  
  // Check if it's time to change state
  if (currentTime - lastChangeTime >= randomInterval) {
    // Toggle output state
    outputState = !outputState;
    digitalWrite(OUTPUT_PIN, outputState);
    
    Serial.print("Change #");
    Serial.print(changeCount);
    Serial.print(" - State: ");
    Serial.print(outputState ? "HIGH" : "LOW");
    Serial.print(" - Next interval: ");
    Serial.print(randomInterval);
    Serial.println("ms");
    
    // Update time reference
    lastChangeTime = currentTime;
    changeCount++;
  }
}