//Variables for ball physics - all units in pixels and frames
float x, y, xVel, yVel;
float ang = -60;
float vel = 15;
float acc = 0.5;

float xO;
float yO = 0;
float yOvel = 0;

void setup() {
  size(800, 400);
  y = height;
  xO = -height/tan(radians(ang));
  println(xO);
  xVel = vel*cos(radians(ang));
  yVel = vel*sin(radians(ang));

  background(255);
  fill(0);
}

void draw() {
  x+=xVel;
  y+=yVel;
  yVel+=acc;

  yO+=yOvel;
  yOvel+=acc;

  if (dist(x, y, xO, yO)<20)noLoop();
  ellipse(x, y, 10, 10);
  ellipse(xO, yO, 20, 20);
}