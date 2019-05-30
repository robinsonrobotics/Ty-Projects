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
  int measure(){
    float xm = x;//x location of measurement particle
    float ym = y;//y location of measurement particle
    float vm = 1;
    float dist = 0;
    while (xm<width&&xm>0&&ym<height&&ym>0&&brightness(map.get(int(xm),int(ym)))==255){
      xm+=vm*cos(theta+PI/2);
      ym+=vm*sin(theta+PI/2);
      dist++;
      stroke(255,0,0);
      ellipse(xm,ym,2,2);
    }
    return int(dist);
  }
  void update(){
    //take measurement 
    float dist = measure();
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
    text(dist,0,70);
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
