int totalBlobs = 10;
Blobs[] blobs = new Blobs[totalBlobs];
int width, height;
color strokeColor = color(255, 0, 0);
color fillColor = color(255, 255, 255);
float targetX, targetY;
AccelerometerManager accel;
float ax, ay, az;


void setup() {
  accel = new AccelerometerManager(this);
  orientation(PORTRAIT);
  width = displayWidth;
  height = displayHeight;
  targetX = random(width);
  targetY = random(height);
  size(displayWidth, displayHeight);
  noStroke();
  smooth();
  background(0);
  for (int i = 0; i < totalBlobs; i++) {
    Blobs blob = new Blobs();
    blob.x = targetX;
    blob.y = targetY;
    blob.easingX = .02 + random(.10);
    blob.easingY = .02 + random(.10);
    blob.strokeSize = 100 + random(160.0);
    blob.fillSize = blob.strokeSize - 20.0;
    blobs[i] = blob;
  }
};

void draw() {
  background(0);
  for (int i = 0; i < totalBlobs; i++) {
    blobs[i].collision();
  } 

  fill(strokeColor);
  for (int i = 0; i < totalBlobs; i++) {
    if (ax < 0.5 && ay < 0.1) {
      blobs[i].springToward(displayWidth/2, 0);
      blobs[i].renderStroke();
    }
    else {
      blobs[i].springToward(blobs[i].x*ax, blobs[i].y*ay);
      blobs[i].renderStroke();
    }
  }
  fill(fillColor);
  for (int i = 0; i < totalBlobs; i++) {
    blobs[i].renderFill();
  }
}


//-------ACCELLEROMETER--------

public void resume() {
  if (accel != null) {
    accel.resume();
  }
}


public void pause() {
  if (accel != null) {
    accel.pause();
  }
}


public void shakeEvent(float force) {
  println("shake : " + force);
}


public void accelerationEvent(float x, float y, float z) {
  //  println("acceleration: " + x + ", " + y + ", " + z);
  ax = -x;
  ay = y;
  az = z;
  redraw();
}

//-------ACCELLEROMETER ENDS----------

class Blobs {
  float x = 0.0;
  float y = 0.0;
  float vx = 0.0;
  float vy = 0.0;
  float easingX = 0.0;
  float easingY = 0.0;
  float strokeSize = 180.0;
  float fillSize = 160.0;


  void renderStroke() {
    stroke((int)abs(ax*27), (int)abs(ay*27), (int)abs(az*27));
    strokeWeight(10);
    line(this.x, this.y, displayWidth/2, displayHeight);
  }

  void renderFill() {
    fill(255);
    line(this.x, this.y, displayWidth/2, displayHeight);
  }

  void springToward(float _x, float _y) {
    this.vx += (_x - this.x) * this.easingX;
    this.vy += (_y - this.y) * this.easingY;
    this.vx *= .92;
    this.vy *= .90;
    this.x += this.vx;
    this.y += this.vy;
  }

  void collision() {

    if (x > displayWidth) {
      x = displayWidth;
      vx *= -1.0;
    }
    if (x < 0) {
      x = 0;
      vx *= -1.0;
    }
    if (y > displayHeight) {
      y = displayHeight;
      vy *= -1.0;
    }
    if (y < 0) {
      y = 0;
      vy *= -1.0;
    }
  }
}

