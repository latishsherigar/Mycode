    const unsigned long SleepInterval = 10000UL; //24 hr
    unsigned long SleepStart = 0;
    const int motor_relay_pin =  13;      // the number of the LED pin


void setup() {
  // put your setup code here, to run once:
  // initialize the LED pin as an output:
   Serial.begin(115200);
  pinMode(motor_relay_pin, OUTPUT);
  digitalWrite(motor_relay_pin, LOW);

}

void loop() {
  // put your main code here, to run repeatedly:
       if (millis() - SleepStart > SleepInterval){
        /*activate when sleepinterval(24hrs) is crossed*/
        Serial.print("activating relay");
        Serial.println(millis());
        activate_motor_relay();
        
      }
      


}

void activate_motor_relay(){

     digitalWrite(motor_relay_pin, HIGH);
     Serial.println("Activated..ON for 5 sec");
     delay(5000);
     digitalWrite(motor_relay_pin, LOW);
     Serial.println("Switch off");
     SleepStart = millis();
}

