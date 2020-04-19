void setup() {
  size(1920, 1080);
  background(color(250, 250, 255));
  noStroke();
  frameRate(12);
  initialize();
}

int DENSITY = 10;
int STROKE_COLOR = 255;
byte COLOR_INC = 1;
float GENERAL_WEIGHT = 400;
float SHRINK_RATE = 0.99;
float MIN_WEIGHT = 10;
color INIT_COLOR = color(200, 250, 255);
ArrayList<Thingy> THINGS = new ArrayList<Thingy>();

float X_TOL = 5;
float Y_TOL = 5;
float NOISE_X = 2.8;
float NOISE_Y = 0.5;

void draw() {
  for (Thingy thing : THINGS) {
    thing.squat();
    
    float x = thing.getX();
    float y = thing.getY();
    float noise = thing.getID();
    float xNext = map(noise(NOISE_X, noise), 0, 1, x - X_TOL, x + X_TOL);
    float yNext = map(noise(NOISE_Y, noise), 0, 1, y - Y_TOL, y + Y_TOL);

    thing.setX(xNext);
    thing.setY(yNext);
    
    NOISE_X += 0.0001;
    NOISE_Y += 0.0001;
    thing.updateWeight();
    thing.decreaseColor();
  }
}

void initialize() {
  float xSpace = width / DENSITY;
  float ySpace = height / DENSITY;
  for (float x = 0; x <= width; x += xSpace) {
    for (float y = 0; y <= height; y += ySpace) {
      println(DENSITY, x, xSpace, y, ySpace);
      THINGS.add(new MorphedThingy(x, y, random(0, 500)));
    }
  } 
}


class MorphedThingy extends Thingy{
  float x;
  float y;
  float weight;
  color colr;
  float id;
  
  Thingy(float x, float y, float i) {
    this.x = x;
    this.y = y;
    this.id = i;
    this.colr = INIT_COLOR;
    this.weight = map(this.id, 0, 500, GENERAL_WEIGHT/2, GENERAL_WEIGHT);
  }
  
  void updateWeight() {
   if (this.weight <= MIN_WEIGHT) {
      return;
    }
   this.weight *= SHRINK_RATE;
  }
  
  void increaseColor() {
    float r = red(this.colr);
    float g = green(this.colr);
    float b = blue(this.colr);
    if (max(r, g, b) >= 255) {
      return;
    }
    r += 1;
    g += 1;
    b += 2;
    this.colr = color(r, g, b);
  }
  
  void decreaseColor() {
    float r = red(this.colr);
    float g = green(this.colr);
    float b = blue(this.colr);
    if (min(r, g, b) <= 0) {
      return;
    }
    r -= 1;
    g -= 1;
    b -= 1;
    this.colr = color(r, g, b);
  }
  
  float getX() {
    return this.x;
  }
  
  float getY() {
    return this.y;
  }
  
  float getID() {
    return this.id;
  }
  
  void setX(float x) {
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }
  
  void squat() {
    fill(this.colr);
    if (this.weight >= MIN_WEIGHT) {
      ellipse(this.x, this.y, this.weight, this.weight);
    }
  }
}
