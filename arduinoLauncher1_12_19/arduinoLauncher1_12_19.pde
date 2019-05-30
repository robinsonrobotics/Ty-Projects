//Simulation and Launcher
//Arduino setup code
//import processing.serial.*;
//import cc.arduino.*;
//Arduino arduino;

//Simulation
//Validate simulation using hand calculations
//Note for all calculation, we have set a scale of 80 px/m

//Launch parameters
float ang;//degrees of initial launch
float vReal=4.1026;//Initial velocity in m/s
float targX;
float t, maxDist;

//Variables for ball physics - all units in pixels and frames
float x, y, a, v, xVel, yVel;

//Scaling parameters
float pxPerM;//number of pixels per meter

boolean launch = false;
 int yOffset=70;

void setup() {
  size(1200, 600);
  maxDist = 0.1*vReal*vReal;
  println(maxDist);
  pxPerM = width/maxDist;
  v = vReal*pxPerM/60;
  a = 9.8*pxPerM/pow(60, 2);
  y = height-yOffset;
  x = 20;
  //Arduino stuff
  // Prints out the available serial ports.
  //println(Arduino.list());
  //arduino = new Arduino(this, Arduino.list()[0], 57600);
  //arduino.pinMode(9, Arduino.SERVO);
  textSize(36);
}
void draw() {
  fill(255);
  if (!launch)rect(2,2,width-4,height-4);
  targX = mouseX;

  //Calculate real time required
  float xReal = (targX)/pxPerM;
  float c = (4*pow(vReal, 2)+sqrt(16*pow(vReal, 4)-4*pow(9.8, 2)*4*pow(xReal, 2)))/(2*pow(9.8, 2));
  t = sqrt(c);
  //println(t);
  ang = -acos(xReal/(vReal*t));

  //Draw target
  int targWidth = 80;
  int targHeight = 20;
  line(targX-targWidth/2, height-yOffset, targX+targWidth/2, height-(yOffset));//draw bottom line
  line(targX-targWidth/2, height-yOffset, targX-targWidth/2, height-(yOffset+20));//Draw left side
  line(targX+targWidth/2, height-yOffset, targX+targWidth/2, height-(yOffset+20));//draw right side

  //Draw launcher
  fill(0);
  strokeWeight(5);
  line(20+40*cos(ang), height-yOffset+40*sin(ang), 20, height-yOffset);
  ellipse(x, y, 10, 10);
  
  if (launch) {
    //update positions and velocity
    yVel=yVel+a;
    x=xVel+x;
    y=yVel+y;
  }


  //Arduino code
  int inches = int(maxDist/0.025);
  for (int i=0; i<=inches; i+=inches/12) {
    float lineX = map(i, 0, inches, 20, width-50);
    line(lineX, height, lineX, height-20);
    fill(0);
    text(i, lineX, height-30);
  }
  float distIn = map(mouseX, 0, width-50, 0, 68);
  float distM = distIn*0.025;
  //println("distM ", distM);
  //println(distM);
  //println("x");
  //println(x);
  //Add code to find angle given a distance
  //Write angle to servo
  //arduino.servoWrite(9, int(map(mouseX,0,width,5,45)));
  //If mouse is pressed, fire ball in simulation, and in the real world
  //add animation of launcher and ball
  //if(mousePressed)arduino.digitalWrite(11,1);
  //else arduino.digitalWrite(11,0);
  //If the ball has landed, print the change in x (in meters) and time
  if (y>height-50&& launch) {
    float xLandReal = (x-20)/pxPerM;
    //println("xReal");
    //println(xReal);
    //println(frameCount/60.0);
    launch = false;
    x = 20;
    y = height-yOffset;
    save("landing.png");
  }
}

void mousePressed() {
  launch = true;
  xVel = v*cos(ang);
  yVel = v*sin(ang);
  println(xVel, yVel);
}