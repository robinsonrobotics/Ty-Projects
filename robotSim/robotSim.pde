PImage map;
float pxPerM = 500;
Robot[] robots;//Create array of robots
void setup() {
  size(1000, 500);
  robots = new Robot[6];//tells Processing how many robots to create
  //create 10 robots at random locations
  for(int i = 0; i<robots.length; i++){
    robots[i] = new Robot(random(2),random(1),0.04);
  }
  map = loadImage("map.png");//load map
  
}

void draw() {
  //background(255);
  image(map, 0, 0);
  //Special for loop for arrays of objects that updates each robot
  for(Robot r: robots){
    r.update();
  }
  //r.vr = map(mouseX, 0, width, 0, 2);
  //r.vl = map(mouseX, 0, width, 2, 0);
  
}

void mousePressed() {
  for (int x = mouseX; x<mouseX+20; x++) {
    for (int y = mouseY; y<mouseY+20; y++) {
      map.set(x, y, color(0));
    }
  }
  map.save("map.png");
}
