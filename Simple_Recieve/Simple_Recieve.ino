#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(8, 10);

const byte rxAddr[6] = "00001";

void setup()
{
  while (!Serial);
  Serial.begin(115200);
  
  radio.begin();
  radio.openReadingPipe(0, rxAddr);
  
  radio.startListening();

    pinMode(4, OUTPUT);
  digitalWrite(4, HIGH);
}

void loop()
{
  if (radio.available())
  {
    char text[32] = {0};
    radio.read(&text, sizeof(text));
    
    Serial.println(text);
  }
}
