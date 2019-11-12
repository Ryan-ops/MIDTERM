import processing.serial.*; //importing serial library 
PImage rick; // to store meter needle image
PImage portal; // to store meter image 
float increment; 
float inByte; //to store incomming value from serial port
float reading=0; //to store mapped inByte value
float rickSize;
Serial arduino; //naming our serial port as "arduino"
void setup() //only runs one time when program starts
{
   //making background color as black
  
  fullScreen(); //output window size full screen
  rick=loadImage("rick.jpg"); //loading rick.jpg image
  portal=loadImage("portal.png"); //loading portal.png image 
  rick.resize(60, 60); //resizing needle image to fit our 
  //printArray(Serial.list()); //listing serial port to find the port in which arduino is connected
  arduino = new Serial(this, Serial.list()[2], 9600); //initializing port, in my case arduino is no.4 in the list 
}
void draw() //this will loop by 60 frame per second by default , frame rate can be changed by frameRate() function
{
  background(255);
  imageMode(CENTER); //draw image using center mode
  image(portal, width/2, height/2); //drawing meter image 
  pushMatrix(); //saving current transformation matrix onto the matrix stack
  imageMode(CORNER); //draw image using corner mode
  translate((width/2)+2, (height/2)+15); //translating "(width/2)+2, (height/2)+15" to "0,0"
  rotate(((HALF_PI)-19.69)+reading); //rotation image to position to zero in portal image 
  push();
  //tint(255, rickSize);
  image(rick , 20, 20,rickSize,rickSize); //drawing rick image
  pop();
  //rick.resize(10,10);
  
  popMatrix();//removing the current transformation matrix off the matrix stack
  if (arduino.available()>0) //checking whether there is incomming serial values
  {
    inByte=arduino.read(); //storing incomming values to variable inByte
  } else
  {
    reading=0; //if no values are comming from our port reading will be zero
  }
  rickSize = map(inByte, 0, 255, 80, 0);
  reading=map(inByte, 0, 255, 0, 4.72); //maping and storing the inByte value from 0 to 255 to 0 to 4.72, watch the video to find how i got the value 4.72
  println(inByte);//printing inByte value , only for debuging purpose, we can command this line 
}
