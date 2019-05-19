float pxPerM = 500;
Robot r;
void setup() {
  size(1000, 500);
  r = new Robot(1,0.5,0.1);
}

void draw() {
  background(255);
  r.update();
  r.vr = map(mouseX,0,width,0,2);
  r.vl = map(mouseX,0,width,2,0);
}

class Robot {
  float x,y,d,vl,vr,theta,r,dTheta;
  //Inputs to the constructor are x, y, and d in meters, but x and y variables are in px
  Robot(float _x, float _y, float _d){
    x = _x*pxPerM;
    y = _y*pxPerM;
    d = _d*pxPerM;
    vr = 2;
    vl = 1.5;
  }
  void update(){
    //Step 1: find circle on which robot is turning
    if(vl!=vr)r=(d/2)*(vl+vr)/(-vr+vl);
    float xc = x-r*cos(theta);
    float yc = y-r*sin(theta);
    //Update robot position
    dTheta=((vl+vr)/2)/r;
    theta+=dTheta;
    x=xc+r*cos(theta);
    y=yc+r*sin(theta);
    //draw circle on which robot is turning
    strokeWeight(1);
    noFill();
    ellipse(xc,yc,r*2,r*2);
    ellipse(xc,yc,2,2);
    //display robot
    pushMatrix();
    translate(x,y);
    rotate(theta);
    fill(0);
    stroke(0);
    ellipse(0,0,d,d);
    strokeWeight(3);
    stroke(200);
    line(0,-d/2,0,d/2);
    ellipse(0,d/2,10,10);
    line(d/2,0,d/2,vl*50);
    line(-d/2,0,-d/2,vr*50);
    popMatrix();
    
    
  }
}
