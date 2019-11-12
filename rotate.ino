int pot; 
void setup() {
  Serial.begin(9600); //Begin serial communication 
}

void loop() {
  pot=analogRead(A0); //reading analog value from pin A0
  Serial.write(map(pot,0,1023,0,255)); //maping the value from 0 to 1023 to 0 to 255
  delay(100);

}
