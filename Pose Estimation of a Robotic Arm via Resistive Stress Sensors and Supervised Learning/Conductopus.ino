int aPin0 = 0;
int aPin1 = 1;
int aPin2 = 2;
int aPin3 = 3;
int aPin4 = 4;
int raw0 = 0;
int raw1 = 0;
int raw2 = 0;
int raw3 = 0;
int raw4 = 0;
int Vin = 5;
float Vout0 = 0;
float Vout1 = 0;
float Vout2 = 0;
float Vout3 = 0;
float Vout4 = 0;
float R1_0 = 10000;
float R1_1 = 10000;
float R1_2 = 10000;
float R1_3 = 10000;
float R1_4 = 10000;
float R2_0 = 0;
float R2_1 = 0;
float R2_2 = 0;
float R2_3 = 0;
float R2_4 = 0;
float buffer0 = 0;
float buffer1 = 0;
float buffer2 = 0;
float buffer3 = 0;
float buffer4 = 0;
unsigned long timerOld = 0;
unsigned long timerNew;
unsigned long timerWait;

const int buttonPin = 6;
const int ledPin = 13;

int buttonState = 0;

void setup() { 
  / / bitrate
  Serial.begin(9600);

  pinMode (ledPin, OUTPUT);
  pinMode (buttonPin, INPUT);
}

void loop() {
  if (buttonState == 0){
    buttonState = digitalRead(buttonPin);
    timerWait = millis();
  }
  raw0 = analogRead(aPin0);
  raw1 = analogRead(aPin1);
  raw2 = analogRead(aPin2);
  raw3 = analogRead(aPin3);
  raw4 = analogRead(aPin4);

  if (buttonState == HIGH) {
    digitalWrite(ledPin, HIGH);
    buttonState = 1;
    timerNew = millis();
  }

  float frameRate = 10;
  if ((timerNew - timerOld) >= 1000/frameRate && buttonState == 1){
    buffer0 = raw0*Vin;
    Vout0 = (buffer0)/1024.0;
    buffer0 = (Vin/Vout0) - 1;
    R2_0 = R1_0*buffer0;

    buffer1 = raw1*Vin;
    Vout1 = (buffer1)/1024.0;
    buffer1 = (Vin/Vout1) - 1;
    R2_1 = R1_1*buffer1;

    buffer2 = raw2*Vin;
    Vout2 = (buffer2)/1024.0;
    buffer2 = (Vin/Vout2) - 1;
    R2_2 = R1_2*buffer2;

    buffer3 = raw3*Vin;
    Vout3 = (buffer3)/1024.0;
    buffer3 = (Vin/Vout3) - 1;
    R2_3 = R1_3*buffer3;

    buffer4 = raw4*Vin;
    Vout4 = (buffer4)/1024.0;
    buffer4 = (Vin/Vout4) - 1;
    R2_4 = R1_4*buffer4;

    Serial.print(timerNew - timerWait);
    Serial.print(”, ”);
    Serial.print(R2_0);
    Serial.print(”, ”);
    Serial.print(R2_1);
    Serial.print(”, ”);
    Serial.print(R2_2);
    Serial.print(”, ”);
    Serial.print(R2_3);
    Serial.print(”, ”);
    Serial.print(R2_4);
    Serial.println(’ ’);

    timerOld = timerNew;
    timerNew = millis();
    }
  }

