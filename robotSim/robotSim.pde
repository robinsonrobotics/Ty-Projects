PImage map;
float pxPerM = 500;
Robot[] robots;//Create array of robots
void setup() {
  size(1000, 500);
  robots = new Robot[1];//tells Processing how many robots to create
  //create 10 robots at random locations
  for (int i = 0; i<robots.length; i++) {
    robots[i] = new Robot(random(2), random(1), 0.08);
  }
  map = loadImage("map.png");//load map
  resetMap();
}

void draw() {
  background(255);
  //image(map, 0, 0);
  //Special for loop for arrays of objects that updates each robot
  for (Robot r : robots) {
    r.update();
    r.setTarget(mouseX,mouseY);
    //r.vr = map(mouseX, 0, width, 0, 2);
    //r.vl = map(mouseX, 0, width, 2, 0);
    //println(r.x);
  }
  
}

void mousePressed() {
}

void resetMap() {
  for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      map.set(x, y, color(255));
    }
  }
  map.save("map.png");
}
