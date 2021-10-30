/*
    This sketch demonstrates how to set up a simple HTTP-like server.
    The server will set a GPIO pin depending on the request
      http://server_ip/gpio/0 will set the GPIO2 low,
      http://server_ip/gpio/1 will set the GPIO2 high
    server_ip is the IP address of the ESP8266 module, will be
    printed to Serial when the module is connected.
*/

#include <ESP8266WiFi.h>
#include <Wire.h>
#include <TEA5767.h>

#ifndef STASSID
#define STASSID "MatrixSheriLtd"
#define STAPSK  "Sheriprivatenet@5678"
#endif

const char* ssid = STASSID;
const char* password = STAPSK;


// Create an instance of the server
// specify the port to listen on as an argument
WiFiServer server(80);

TEA5767 Radio;
double old_frequency;
double frequency;
double max_frequency=108;
int search_mode = 0;
int search_direction;
unsigned long last_pressed;


unsigned char buf[5];
int stereo;
int signal_level;
double current_freq;


void setup() {
  Serial.begin(115200);

  // prepare LED
  //  pinMode(LED_BUILTIN, OUTPUT);
  // digitalWrite(LED_BUILTIN, 0);

  // Connect to WiFi network
  connetct2WIFI();

  initRadio(Radio);
}


void initRadio(TEA5767 Radio) {
  Wire.begin(D1, D2);
  Radio.init();
  String initial_freq = "91.1";
  Radio.set_frequency(initial_freq.toFloat()); // pick your own frequency
  printRadioInfo();
}

void connetct2WIFI() {
  Serial.println();
  Serial.println();
  Serial.print(F("Connecting to "));
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(F("."));
  }
  Serial.println();
  Serial.println(F("WiFi connected"));

  // Start the server
  server.begin();
  Serial.println(F("Server started"));

  // Print the IP address
  Serial.println(WiFi.localIP());

}


void printRadioInfo() {
  //  unsigned long current_millis = millis();

  if (Radio.read_status(buf) == 1) {
    current_freq =  floor (Radio.frequency_available (buf) / 100000 + .5) / 10;
    stereo = Radio.stereo(buf);
    signal_level = Radio.signal_level(buf);

    Serial.println("Printing details......");
    Serial.println(current_freq);
    Serial.println(stereo);
    Serial.println(signal_level);
    Serial.println("Done.");

    //lcd.setCursor(0,0);
    //lcd.print("FM: "); lcd.print(current_freq);
    //lcd.setCursor(0,1);
    //if (stereo) lcd.print("STEREO "); else lcd.print("MONO ");
  }

}

void setFrequency(double frequency) {
  Radio.set_frequency(frequency); // pick your own frequency
  printRadioInfo();

}

void searchUP() {
  Serial.println("Searching UP....");

  //last_pressed = current_millis;
  //search_mode = 1;
  search_direction = TEA5767_SEARCH_DIR_UP;
  Radio.search_up(buf);

  printRadioInfo();
  Serial.println("Searching UP....DONE");
  delay(300);
}

void searchDOWN() {
  Serial.println("Searching DOWN....");
  //last_pressed = current_millis;
  // search_mode = 1;
  search_direction = TEA5767_SEARCH_DIR_DOWN;
  Radio.search_down(buf);

  printRadioInfo();

  Serial.println("Searching DOWN....DONE");
  delay(300);
}


//void search() {
//  Serial.println("Searching ....");
//  //    while(Radio.process_search (buf, search_direction)==1){
//  //    printRadioInfo();
//  //    }
//
//
//  while (current_freq < max_frequency) {
//     printRadioInfo();
//    //searchUP();
//    //setFrequency(current_freq);
//    Serial.println("Searching ....");
//    if (Radio.process_search(buf,search_direction) == 1) {
//        Serial.println("TUNED.");
//      return;
//    }
//    delay(300);
//
//  }
//
//  Serial.println("Searching DONE....");
//
//}



String readFrequencyFromRequest(String req) {
  int endPos = req.indexOf("HTTP/1.1");
  int startPos = req.lastIndexOf("/", endPos) + 1;
  String req_frequency = req.substring(startPos, endPos);
  Serial.print("Request frequency is ");
  Serial.println(req_frequency);
  return req_frequency;

}


//
//  if (search_mode == 1) {
//      if (Radio.process_search (buf, search_direction) == 1) {
//          search_mode = 0;
//      }
//  }
//


void loop() {
boolean show_landing_page =false;
boolean show_current_details_page=false;
  
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  Serial.println(F("new client"));

  client.setTimeout(5000); // default is 1000

  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(F("request: "));
  Serial.println(req);

  // Match the request
  if (req.indexOf(F("/fmtuner/next")) != -1) {
    searchUP();
    setFrequency(current_freq);
    show_landing_page=true;

   // search();
  } else if (req.indexOf(F("/fmtuner/previous")) != -1) {
    searchDOWN();
    setFrequency(current_freq);
    show_landing_page=true;
  }  else if (req.indexOf(F("/fmtuner/channel")) != -1) {
    String req_frequency = readFrequencyFromRequest(req);
    double dbl_req_freq = req_frequency.toFloat();
     show_current_details_page=true;

    if(dbl_req_freq > 1){
       Serial.println(dbl_req_freq );
      setFrequency(dbl_req_freq );
    }
  } else {
      show_landing_page=true;
    Serial.println(F("invalid request"));
  }


  // read/ignore the rest of the request
  // do not client.flush(): it is for output only, see below
  while (client.available()) {
    // byte by byte is not very efficient
    client.read();
  }


  // Send the response to the client

if(show_landing_page==true){
  //sendMainPageHTML(client);
  sendChannelSelectionGUI(client);
}

if(show_current_details_page==true){
      //  client.print(F("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\nCurrent frequency is : "));
      // client.print(current_freq);
      sendChannelSelectionGUI(client);
 
}

  // The client will actually be *flushed* then disconnected
  // when the function returns and 'client' object is destroyed (out-of-scope)
  // flush = ensure written data are received by the other side
  Serial.println(F("Disconnecting from client"));

}


void sendChannelSelectionGUI(WiFiClient client){
client.print("<!DOCTYPE html><html><head><meta name='viewport' content='width=device-width, initial-scale=1'>");
client.print("<title>HiFi FM Radio</title>");
client.print("<style>");
client.print(".button { ");
client.print("  padding: 15px 25px; ");
client.print("  font-size: 24px; ");
client.print("  text-align: center; ");
client.print("  cursor: pointer; ");
client.print("  outline: none; ");
client.print("  color: #fff; ");
client.print("  background-color: #4CAF50; ");
client.print("  border: none; ");
client.print("  border-radius: 15px; ");
client.print("  box-shadow: 0 9px #999; ");
client.print("   width: 40%; ");
client.print("} ");


client.print(".button:hover {background-color: #3e8e41} ");

client.print(".button:active { ");
client.print("  background-color: #3e8e41; ");
client.print("  box-shadow: 0 5px #666; ");
client.print("  transform: translateY(4px); ");
client.print("} ");


client.print("</style> ");
client.print("</head> ");
client.print("<body> ");

client.print("<h2>Current channel: ");
client.print(current_freq);
client.print("</h2> ");



client.print("<button class='button'  onclick='changeChannel(91.1)'>91.1</button> ");
client.print("<button class='button'  onclick='changeChannel(91.9)'>91.9</button><p/> ");
client.print("<button class='button'  onclick='changeChannel(92.7)'>92.7</button> ");
client.print("<button class='button'  onclick='changeChannel(93.5)'>93.5</button><p/> ");
client.print("<button class='button'  onclick='changeChannel(94.3)'>94.3</button> ");
client.print("<button class='button'  onclick='changeChannel(98.3)'>98.3</button><p/> ");
client.print("<button class='button'  onclick='changeChannel(100.7)'>100.7</button> ");
client.print("<button class='button'  onclick='changeChannel(104)'>104</button><p/> ");
client.print("<button class='button'  onclick='changeChannel(104.8)'>104.8</button> ");
client.print("<button class='button'  onclick='changeChannel(106.4)'>106.4</button><p/> ");

client.print("<script> ");
client.print("function changeChannel(channelCode) { ");
client.print("  window.location='http://");
client.print(WiFi.localIP());
client.print("/fmtuner/channel/' + channelCode;");
client.print("} ");
client.print("</script></body></html> ");



}


void sendMainPageHTML(  WiFiClient client) {
  // it is OK for multiple small client.print/write,
  // because nagle algorithm will group them into one single packet
  client.print(F("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>\r\nCurrent frequency is : "));
  client.print(current_freq);
  client.print("<br>Signal Strength: ");
  client.print(signal_level);
  client.print("<br>Stereo: ");
  client.print(stereo);
  // client.print((val) ? F("high") : F("low"));
  client.print(F("<br><br>Click <a href='http://"));
  client.print(WiFi.localIP());
  client.print(F("/fmtuner/next'>here</a> to play the next station, or <a href='http://"));
  client.print(WiFi.localIP());
  client.print(F("/fmtuner/previous'>here</a> to play the previous station.</html>"));

}
