void setup() {
  size(1920, 1080);
  background(color(250, 250, 255));
  frameRate(15);
}

float noiseController = 5;
float COLOR_NOISE = 0.001;
int NUM_LINES = 3;
color BG_COLOR = color(250, 250, 255);

int R = 100;
byte rInc = 3;
int G = 200;
byte gInc = 1;
int B = 255;
byte bInc = 1;

void draw() {
  stroke(newColor());
  strokeWeight(2);
  noFill();
  
  float xoff = noiseController;
  for (int line = 0; line < NUM_LINES; line++) {
    beginShape();
    for (float x = 0; x < width; x++) {
      float y_up_bound = height/NUM_LINES * line - 50;
      float y_lo_bound = y_up_bound + height/NUM_LINES + 100;
      float y = map(noise(xoff, noiseController), 0, 1, y_up_bound, y_lo_bound);
      vertex(x,y);
      xoff += 0.01;
    }
    endShape();
    noiseController += 0.01;
  }
}

color newColor() {
  if (R <= 100 || R >= 200) {
    rInc *= -1;
  } 
  if (G <= 150 || G >= 250) {
    gInc *= -1;
  }
  if (B <= 200 || B >= 255) {
    bInc *= -1;
  }
  R += rInc;
  G += gInc;
  B += bInc;
  return color(R, G, B);
}
