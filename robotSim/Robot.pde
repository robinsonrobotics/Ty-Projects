class Robot {
  float x, y, d, vl, vr, theta, r, dTheta, dist;
  boolean turn= false;
  //Inputs to the constructor are x, y, and d in meters, but x and y variables are in px
  Robot(float _x, float _y, float _d) {
    x = _x*pxPerM;
    y = _y*pxPerM;
    d = _d*pxPerM;
    vr = 1;
    vl = 1;
    theta = random(PI);
  }
  void measure() {
    float xm = x;//x location of measurement particle
    float ym = y;//y location of measurement particle
    float vm = 1;
    dist = 0;//keep track of distance light has traveled
    while (xm<width&&xm>0&&ym<height&&ym>0&&brightness(map.get(int(xm), int(ym)))!=0) {
      xm+=vm*cos(theta+PI/2);//It would be nice if the angle was right and we didn't have to add 90 degrees
      ym+=vm*sin(theta+PI/2);
      dist++;
      stroke(255, 0, 0);//draw light
      point(xm,ym);
      //ellipse(xm, ym, 2, 2);
    }
  }
  void update() {
    //take measurement 
    measure();
    avoidObstacles();
    //Step 1: find circle on which robot is turning
    if (vl!=vr)r=(d/2)*(vl+vr)/(-vr+vl);
    //else r = 10000000;
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
    ellipse(xc, yc, r*2, r*2);
    ellipse(xc, yc, 2, 2);
    //display robot
    pushMatrix();
    translate(x, y);
    text(dist, 0, 40);//print distance
    rotate(theta);
    fill(0);
    stroke(0);
    ellipse(0, 0, d, d);
    strokeWeight(3);
    stroke(200);
    line(0, -d/2, 0, d/2);
    ellipse(0, d/2, 10, 10);
    line(d/2, 0, d/2, vl*50);
    line(-d/2, 0, -d/2, vr*50);
    popMatrix();
  }
  void avoidObstacles() {
    if (dist<300||turn) {
      turn=true;
      vl=1;
      vr=-1.1;
    } else {
      println(frameCount);
      vr=1.001;
      vl=1;
    }
    if (dist>400) {
      turn=false;
    }
  }
}
