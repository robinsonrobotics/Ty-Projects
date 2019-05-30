PImage map;
float pxPerM = 500;
Robot r;
void setup() {
  size(1000, 500);
  map = loadImage("map.png");
  r = new Robot(1, 0.5, 0.1);
}

void draw() {
  //background(255);
  image(map, 0, 0);
  r.update();
  r.vr = map(mouseX, 0, width, 0, 2);
  r.vl = map(mouseX, 0, width, 2, 0);
}

void mousePressed() {
  for (int x = mouseX; x<mouseX+20; x++) {
    for (int y = mouseY; y<mouseY+20; y++) {
      map.set(x, y, color(0));
    }
  }
  map.save("map.png");
}
