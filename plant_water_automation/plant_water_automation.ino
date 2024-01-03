
// Date and time functions using a DS3231 RTC connected via I2C and Wire lib
#include <Wire.h>
#include "RTClib.h"
#include <EEPROM.h> 


RTC_DS3231 rtc;


//#define IN1  8
//#define IN2  9
//#define IN3  10
//#define IN4  11
#define LIGHT_RELAY_CONTROL_PIN_1  6
#define LIGHT_RELAY_CONTROL_PIN_2  7

#define EPROM_ADD_MONTH 0
#define EPROM_ADD_DAY 1
//#define EPROM_ADD_MORNING_FEED 2
//#define EPROM_ADD_EVENING_FEED 3

#define PUMP_SWITCHON_TIME 12
#define PUMP_ON_DURATION 2

//#define MORNING_FEED_TIME 9
//#define EVENING_FEED_TIME 19


unsigned long pumpOnTime = 0;
boolean relay_state = false;
boolean pump1_switched_on = false;
boolean pump2_switched_on = false;
boolean plants_watered = false;

void setup() 
{
  Serial.begin(115200);
 // pinMode(IN1, OUTPUT);
 // pinMode(IN2, OUTPUT);
 // pinMode(IN3, OUTPUT);
 // pinMode(IN4, OUTPUT);
  pinMode(LIGHT_RELAY_CONTROL_PIN_1, OUTPUT);
  pinMode(LIGHT_RELAY_CONTROL_PIN_2, OUTPUT);
  // delay(1000);

  initRTC();

  read_stored_feed_data();

  switchOffPump1();
  switchOffPump2();

}


void loop()
{




  DateTime now = rtc.now();
  int timeHour = (int) now.hour();
  int timeYear = (int) now.year();
  int timeMonth = (int) now.month();
  int timeDay = (int) now.day();
  int timeMin = (int) now.minute();

   Serial.print("timeMonth: ");
  Serial.println(timeMonth);
  Serial.print("timeDay: ");
  Serial.println(timeDay);
 Serial.print("timeHour: ");
  Serial.println(timeHour);
 Serial.print("timeMin: ");
  Serial.println(timeMin);


    
  //reset the watered status as day has changed
  if (plants_watered) {
    int last_watered_day = EEPROM.read(EPROM_ADD_DAY);
    Serial.print("last_watered_day : ");
    Serial.println (last_watered_day);
    Serial.print("timeDay : ");
    Serial.println (timeDay);

    if (last_watered_day != timeDay) {
      plants_watered = false;
      Serial.println ("watered status is reset due to day change");
    }

  }
  //

  Serial.print("pump1 status : ");
  Serial.println(pump1_switched_on);

  Serial.print("pump2 status : ");
  Serial.println(pump2_switched_on);

  //switch on the pumps at 12 pm 
  if (!pump1_switched_on && !pump2_switched_on && !plants_watered && timeHour >= PUMP_SWITCHON_TIME ) {
    Serial.println("switch on pump");
    switchOnPump();
  }

  // switch off pump1 if 5 mins over
  if (pump1_switched_on && (millis() - pumpOnTime >= 300000 ) ) {
    Serial.println("switch off pump1");
    switchOffPump1();

    plants_watered = true;


    EEPROM.write(EPROM_ADD_MONTH, timeMonth);
    EEPROM.write(EPROM_ADD_DAY, timeDay);

  }

  // switch off pump2 if 5 mins over
  if (pump2_switched_on && (millis() - pumpOnTime >= 420000 ) ) {
    Serial.println("switch off pump2");
    switchOffPump2();

    plants_watered = true;


    EEPROM.write(EPROM_ADD_MONTH, timeMonth);
    EEPROM.write(EPROM_ADD_DAY, timeDay);

  }



  Serial.print("watered status : ");
  Serial.println(plants_watered);







  delay (10000);

}

void read_stored_feed_data() {
  int eprom_feed_month = EEPROM.read(EPROM_ADD_MONTH);
  int eprom_feed_day = EEPROM.read(EPROM_ADD_DAY);

  DateTime now = rtc.now();
  int timeMonth = (int) now.month();
  int timeDay = (int) now.day();

  Serial.print("eprom_month: ");
  Serial.println(eprom_feed_month);
  Serial.print("eprom_feed_day: ");
  Serial.println(eprom_feed_day);
  Serial.print("timeMonth: ");
  Serial.println(timeMonth);
  Serial.print("timeDay: ");
  Serial.println(timeDay);

  if (eprom_feed_month == timeMonth && eprom_feed_day == timeDay) {
    Serial.println("reading feed flags from EPROM: ");
    plants_watered = true;
    Serial.print("plants_watered: ");
    Serial.println(plants_watered);


  }

}


void initRTC() {
  if (! rtc.begin()) {
    Serial.println("Couldn't find RTC");
    //while (1);
  }

  if (rtc.lostPower()) {
    Serial.println("RTC lost power, lets set the time!");
    // following line sets the RTC to the date & time this sketch was compiled
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    // rtc.adjust(DateTime(2014, 1, 21, 3, 0, 0));
  }
}

void switchOnPump() {
  digitalWrite(LIGHT_RELAY_CONTROL_PIN_1, HIGH);
  digitalWrite(LIGHT_RELAY_CONTROL_PIN_2, HIGH);
  pump1_switched_on = true;
  pump2_switched_on = true;
  pumpOnTime = millis();

  Serial.println("pump_switched on");
}

void switchOffPump1() {
  digitalWrite(LIGHT_RELAY_CONTROL_PIN_1, LOW);
  pump1_switched_on = false;

  Serial.println("pump_switched off");
}


void switchOffPump2() {
  digitalWrite(LIGHT_RELAY_CONTROL_PIN_2, LOW);
  pump2_switched_on = false;

  Serial.println("pump_switched off");
}
