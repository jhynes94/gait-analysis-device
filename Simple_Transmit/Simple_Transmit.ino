#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(8, 10);

const byte rxAddr[6] = "00001";

void setup()
{
  radio.begin();
  radio.setRetries(15, 15);
  radio.openWritingPipe(rxAddr);
  
  radio.stopListening();
  radio.setPALevel(RF24_PA_MIN);

  Serial.begin(115200);
  Serial.println("Transmitter");
}

void loop()
{
  const char text[] = "Hello World";
  radio.write(&text, sizeof(text));
  Serial.println("Sending");
  
  delay(1000);
}
