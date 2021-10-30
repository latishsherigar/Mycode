/*
    This sketch demonstrates how to set up a simple HTTP-like server.
    The server will set a GPIO pin depending on the request
      http://server_ip/gpio/0 will set the GPIO2 low,
      http://server_ip/gpio/1 will set the GPIO2 high
    server_ip is the IP address of the ESP8266 module, will be
    printed to Serial when the module is connected.
*/

#include <ESP8266WiFi.h>

#ifndef STASSID
#define STASSID "MatrixSheriLtd"
#define STAPSK  "exoticairplane349"
#endif

const char* ssid = STASSID;
const char* password = STAPSK;
const char* radioserverhost = "192.168.1.13";
const uint16_t radioserverport = 80;


// Create an instance of the server
// specify the port to listen on as an argument
WiFiServer server(80);

void setup() {
  Serial.begin(115200);

  // prepare LED
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, 0);

  // Connect to WiFi network
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
  Serial.println(F("This is the Radio remote client."));

  // Print the IP address
  Serial.println(WiFi.localIP());
}

void loop() {
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
//    return;
  connect2radioserver();

  }else{
    serviceclient(client);
  }




}







void serviceclient(WiFiClient client){
  Serial.println(F("new client"));

  client.setTimeout(5000); // default is 1000

  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(F("request: "));
  Serial.println(req);

  // Match the request
  int val;
  if (req.indexOf(F("/fmtuner/next")) != -1) {
    val = 0;
  } else if (req.indexOf(F("/fmtuner/previous")) != -1) {
    val = 1;
  } else {
    Serial.println(F("invalid request"));
    val = digitalRead(LED_BUILTIN);
  }

  // Set LED according to the request
  digitalWrite(LED_BUILTIN, val);

  // read/ignore the rest of the request
  // do not client.flush(): it is for output only, see below
  while (client.available()) {
    // byte by byte is not very efficient
    client.read();
  }

  // Send the response to the client
  // it is OK for multiple small client.print/write,
  // because nagle algorithm will group them into one single packet
  client.print(F("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>\r\nCurrent frequency is : "));
 // client.print((val) ? F("high") : F("low"));
  client.print(F("<br><br>Click <a href='http://"));
  client.print(WiFi.localIP());
  client.print(F("/fmtuner/next'>here</a> to play the next station, or <a href='http://"));
  client.print(WiFi.localIP());
  client.print(F("/fmtuner/previous'>here</a> to play the previous station.</html>"));

  // The client will actually be *flushed* then disconnected
  // when the function returns and 'client' object is destroyed (out-of-scope)
  // flush = ensure written data are received by the other side
  Serial.println(F("Disconnecting from client"));    
}







void connect2radioserver(){
    Serial.print("connecting to ");
  Serial.print(radioserverhost);
  Serial.print(':');
  Serial.println(radioserverport);

    // Use WiFiClient class to create TCP connections
  WiFiClient client;
  if (!client.connect(radioserverhost, radioserverport)) {
    Serial.println("connection failed");
    delay(5000);
    return;
  }



 
     // This will send the request to the server
  Serial.println("sending data to server");
  if (client.connected()) {
      client.print(String("GET ") + "/" + " HTTP/1.1\r\n" +
               "Host: " + radioserverhost + "\r\n" +
               "Connection: close\r\n\r\n");

  }

  // wait for data to be available
  unsigned long timeout = millis();
  while (client.available() == 0) {
    if (millis() - timeout > 5000) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      delay(60000);
      return;
    }
  }

  // Read all the lines of the reply from server and print them to Serial
  Serial.println("receiving from remote server");
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }

  // Close the connection
  Serial.println();
  Serial.println("closing connection");
  client.stop();
  delay(1000);
}
