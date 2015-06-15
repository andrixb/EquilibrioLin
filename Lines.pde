class Lines {

  float x1, y1, x2, y2;
  float vx, vy; //speed
  float easingX = 0.0;
  float easingY = 0.0;
  float strokeSize = 180.0;
  int R, G, B;

  Lines(float x1_, float y1_, float x2_, float y2_) {

    this.x1 = x1_;
    this.y1 = y1_;

    this.x2 = x2_;
    this.y2 = y2_;
  }

  void springToward(float _x, float _y) {
    this.vx += (_x - this.x1) * this.easingX;
    this.vy += (_y - this.y1) * this.easingY;
    this.vx *= .92;
    this.vy *= .90;
    this.x1 += this.vx;
    this.y1 += this.vy;
  }


  void collision() {

    if (x1 > displayWidth) {
      x1 = displayWidth;
      vx *= -1.0;
    }
    if (x1 < 0) {
      x1 = 0;
      vx *= -1.0;
    }
    if (y1 > displayHeight) {
      y1 = displayHeight;
      vy *= -1.0;
    }
    if (y1 < 0) {
      y1 = 0;
      vy *= -1.0;
    }
  
}

void update() {

  if (this.x1 > displayWidth/2) {
    R = 0;
    G = 0;
    B = 0;
  }  

  if (this.x1 <= displayWidth/2) {
    R = 255;
    G = 255;
    B = 255;
  }

  stroke(R, G, B, 50);
  strokeWeight(10);
  line(this.x1, this.y1, this.x2, this.y2);
  this.x1 -= ax*vx;
  this.y1 += ay*vy;


  //collision();
}
}
