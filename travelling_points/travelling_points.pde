int DENSITY = 10;
int STROKE_COLOR = 255;
byte COLOR_INC = 1;
float GENERAL_WEIGHT = 400;
float SHRINK_RATE = 0.99;
float MIN_WEIGHT = 10;
color INIT_COLOR = color(200, 250, 255);
ArrayList<MorphedThingy> THINGS = new ArrayList<MorphedThingy>();

float X_TOL = 5;
float Y_TOL = 5;
float NOISE_X = 2.8;
float NOISE_Y = 0.5;

void travelling_points_init() {
  background(color(250, 250, 255));
  noStroke();
  frameRate(12);
  
  float xSpace = width / DENSITY;
  float ySpace = height / DENSITY;
  for (float x = 0; x <= width; x += xSpace) {
    for (float y = 0; y <= height; y += ySpace) {
      THINGS.add(new MorphedThingy(x, y, random(0, 500)));
    }
  } 
}

void travelling_points_draw() {
  for (MorphedThingy thing : THINGS) {
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

class MorphedThingy extends Thingy{
  
  MorphedThingy(float x, float y, float i) {
    super(x, y, i);
    this.weight = map(this.id, 0, 500, GENERAL_WEIGHT/2, GENERAL_WEIGHT);
    this.colr = INIT_COLOR;
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
  
  void squat() {
    fill(this.colr);
    if (this.weight >= MIN_WEIGHT) {
      ellipse(this.x, this.y, this.weight, this.weight);
    }
  }
}
