Circle blue = new Circle(200,300,2,color(0,0,255));
Circle red = new Circle(100,300,3,color(255,0,0));
void setup() {
  background(40, 50, 11);
  size(400, 400);
}

void draw() {
  background(0);
  blue.update();
  println(blue.d);
  red.update();
}

class Circle {
  color c = color(255, 0, 0);
  int d, x, y, vel; 
  Circle(int _x, int _y, int _vel, color _c) {//constructor
    x = _x;
    y = _y;
    vel = _vel;
    c = _c;
  }

  void update() {
    fill(c);
    ellipse(x, y, d, d);
    d+=vel;
  if(x+d/2>width||x-d/2<0||y+d/2>height||y-d/2<0){
    d=0;
     x= int(random(0, 400));
     y= int(random(0, 400));
}
}
}
