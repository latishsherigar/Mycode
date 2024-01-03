
// Date and time functions using a DS3231 RTC connected via I2C and Wire lib
#include <Wire.h>
#include "RTClib.h"
#include <EEPROM.h>


RTC_DS3231 rtc;


#define IN1  8
#define IN2  9
#define IN3  10
#define IN4  11
#define LIGHT_RELAY_CONTROL_PIN  12

#define EPROM_ADD_MONTH 0
#define EPROM_ADD_DAY 1
#define EPROM_ADD_MORNING_FEED 2
#define EPROM_ADD_EVENING_FEED 3

#define LIGHT_SWITCHON_TIME 9
#define LIGHT_SWITCHOFF_TIME 21

#define MORNING_FEED_TIME 9
#define EVENING_FEED_TIME 19

int Steps = 0;
boolean Direction = true;// gre
unsigned long last_time;
unsigned long currentMillis ;
int steps_left = 4095;
long time;
int rotation = 0;
const unsigned long SleepInterval = 43200000UL; //12 hr
//const unsigned long SleepInterval = 3600000UL; //1 hr
unsigned long SleepStart = 0;
boolean relay_state = false;
boolean lights_switched_on = false;
boolean morning_feed = false;
boolean evening_feed = false;

void setup()
{
  Serial.begin(115200);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(LIGHT_RELAY_CONTROL_PIN, OUTPUT);
  // delay(1000);

  initRTC();

  read_stored_feed_data();

  switchOffLights();

}


void loop()
{




  DateTime now = rtc.now();
  int timeHour = (int) now.hour();
  int timeYear = (int) now.year();
  int timeMonth = (int) now.month();
  int timeDay = (int) now.day();

  //reset the feed status as day has changed
  if (morning_feed  || evening_feed ) {
    int last_feed_day = EEPROM.read(EPROM_ADD_DAY);
    Serial.print("last_feed_day : ");
    Serial.println (last_feed_day);
    Serial.print("timeDay : ");
    Serial.println (timeDay);

    if (last_feed_day != timeDay) {
      morning_feed = false;
      evening_feed = false;
      Serial.println ("feed status is reset due to day change");
    }

  }
  //

  Serial.print("light status : ");
  Serial.println(lights_switched_on);


  //switch on the lights at 9 am till 9 pm
  if (!lights_switched_on && timeHour >= LIGHT_SWITCHON_TIME && timeHour < LIGHT_SWITCHOFF_TIME) {
    Serial.println("switch on lights");
    switchOnLights();
  }

  //switch off the lights at 9 pm
  if (lights_switched_on && timeHour >= LIGHT_SWITCHOFF_TIME) {
    Serial.println("switch off lights");
    switchOffLights();
  }

  Serial.print("morning feed status : ");
  Serial.println(morning_feed);
  Serial.print("evening feed status : ");
  Serial.println(evening_feed);

  //feed at 9 am
  if (!morning_feed && timeHour >= MORNING_FEED_TIME && timeHour < MORNING_FEED_TIME + 3 ) {

    Serial.println("morning feed");
    feed_fish_morning(timeMonth , timeDay );


  }


  //feed at 7 pm
  if (!evening_feed && timeHour >= EVENING_FEED_TIME && timeHour < EVENING_FEED_TIME + 3 ) {

    Serial.println("evening feed");
    feed_fish_evening(timeMonth , timeDay );

  }


  delay (50000);

}

void read_stored_feed_data() {
  int eprom_feed_month = EEPROM.read(EPROM_ADD_MONTH);
  int eprom_feed_day = EEPROM.read(EPROM_ADD_DAY);

  DateTime now = rtc.now();
  int timeMonth = (int) now.month();
  int timeDay = (int) now.day();

  Serial.print("eprom_feed_month: ");
  Serial.println(eprom_feed_month);
  Serial.print("eprom_feed_day: ");
  Serial.println(eprom_feed_day);
  Serial.print("timeMonth: ");
  Serial.println(timeMonth);
  Serial.print("timeDay: ");
  Serial.println(timeDay);

  if (eprom_feed_month == timeMonth && eprom_feed_day == timeDay) {
    Serial.println("reading feed flags from EPROM: ");
    morning_feed = EEPROM.read(EPROM_ADD_MORNING_FEED);
    evening_feed = EEPROM.read(EPROM_ADD_EVENING_FEED);
    Serial.print("morning_feed: ");
    Serial.println(morning_feed);
    Serial.print("evening_feed: ");
    Serial.println(evening_feed);

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

void switchOnLights() {
  digitalWrite(LIGHT_RELAY_CONTROL_PIN, LOW);
  lights_switched_on = true;
  Serial.println("lights switched on");
}

void switchOffLights() {
  digitalWrite(LIGHT_RELAY_CONTROL_PIN, HIGH);
  lights_switched_on = false;
  Serial.println("lights switched off");
}

void feed_fish_morning(int strmonth, int strday) {

  feed_fish();
  morning_feed = true;
  EEPROM.write(EPROM_ADD_MONTH, strmonth);
  EEPROM.write(EPROM_ADD_DAY, strday);
  EEPROM.write(EPROM_ADD_MORNING_FEED, 1);
  Serial.println("feed fish morning");
}



void feed_fish_evening(int strmonth, int strday) {

  feed_fish();
  evening_feed = true;
  EEPROM.write(EPROM_ADD_MONTH, strmonth);
  EEPROM.write(EPROM_ADD_DAY, strday);
  EEPROM.write(EPROM_ADD_EVENING_FEED, 1);
  Serial.println("feed fish evening");
}


void feed_fish() {
  for (int i = 0; i < 4; ++i) {
    Serial.print("rotation - ");
    Serial.println(i);
    rotateMotorClockAndAntiClock();
  }
}

void rotateMotorClockAndAntiClock() {
  while (steps_left > 0) {
    currentMillis = micros();
    if (currentMillis - last_time >= 1000) {
      stepper(1);
      time = time + micros() - last_time;
      last_time = micros();
      steps_left--;
    }
  }
  Serial.println(time);
  Serial.println("Wait...!");
  delay(2000);
  Direction = !Direction;
  steps_left = 4095;
  SleepStart = millis();
  rotation ++;

}

void stepper(int xw) {
  for (int x = 0; x < xw; x++) {
    switch (Steps) {
      case 0:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        break;
      case 1:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, HIGH);
        break;
      case 2:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
        break;
      case 3:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, HIGH);
        digitalWrite(IN3, HIGH);
        digitalWrite(IN4, LOW);
        break;
      case 4:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, HIGH);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
      case 5:
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, HIGH);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
      case 6:
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
      case 7:
        digitalWrite(IN1, HIGH);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, HIGH);
        break;
      default:
        digitalWrite(IN1, LOW);
        digitalWrite(IN2, LOW);
        digitalWrite(IN3, LOW);
        digitalWrite(IN4, LOW);
        break;
    }
    SetDirection();
  }
}
void SetDirection() {
  if (Direction == 1) {
    Steps++;
  }
  if (Direction == 0) {
    Steps--;
  }
  if (Steps > 7) {
    Steps = 0;
  }
  if (Steps < 0) {
    Steps = 7;
  }
}
