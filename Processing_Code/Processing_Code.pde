import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
int inBytex = 0;
int inBytey = 0;
int inBytez = 0;
int lastHeightx = 0;
int lastHeighty = 0;
int lastHeightz = 0;

void setup () {
  // set the window size:
  size(1300, 500);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  background(0);
}
void draw () {
  // draw the line:
  stroke(0, 255, 255);
  line(xPos, lastHeightx, xPos, inBytex);
  lastHeightx = (int)inBytex;
  
  // draw the line:
  stroke(255, 255, 0);
  line(xPos, lastHeighty, xPos, inBytey);
  lastHeighty = (int)inBytey;
  
  // draw the line:
  stroke(255, 0, 255);
  line(xPos, lastHeightz, xPos, inBytez);
  lastHeightz = (int)inBytez;

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);
  } else {
    // increment the horizontal position:
    xPos++;
  }
}

void drawAccel(int x, int y, int z){
  //
}

void drawGyro(int x, int y, int z){
  //
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inStringx = myPort.readStringUntil(',');
  String inStringy = myPort.readStringUntil(',');
  String inStringz = myPort.readStringUntil('\n');
  
  if (inStringx != null) {
    // trim off any whitespace:
    inStringx = trim(inStringx);
    
    inBytex = (int)((height/2) + 10*(int(inStringx)));
    
    print("X: ");
    println(inBytex);
  }

  if (inStringy != null) {
    // trim off any whitespace:
    inStringy = trim(inStringy);
    
    inBytey = (int)((height/2) + 10*(int(inStringy)));
    
    print("Y: ");
    println(inBytey);
  }
  
  if (inStringz != null) {
    // trim off any whitespace:
    inStringz = trim(inStringz);
    
    inBytez = (int)((height/2) + 10*(int(inStringz)));
    
    print("Z: ");
    println(inBytez);
  }
}