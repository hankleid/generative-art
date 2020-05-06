int NUMDOTS = 12; // squared
int START_X = 700;
int START_Y = 300;
float VOID = 20; // pixels in between each base dot
float GROWTH_WEIGHT = 2;
int LENGTH = 100; // length of each stalk (in dots)
ArrayList<Thingy> GROWTHS = new ArrayList<Thingy>();
float TIME = 0;

void growth_init() {
  frameRate(15);
  background(255);
  
  for (int x = 0; x < NUMDOTS; x++) {
    for (int y = 0; y < NUMDOTS; y++) {
      Thingy t = new Thingy(
                              START_X + x*VOID,    // x
                              START_Y + y*VOID,    // y
                              5,                   // id
                              GROWTH_WEIGHT);     // weight
      GROWTHS.add(t);
    }
  }
}

int h = 1; // current height

void growth_draw() {
  background(255);
  strokeWeight(0.5);
  
  for (Thingy t : GROWTHS) {
    t.squat();
    noFill();
    beginShape();
    for (int i = 0; i < h; i++) {
      float x = t.getX();
      float y = t.getY();
      vertex(x, y);
      float x_tolerance = 5;
      float y_tolerance = 5;
      t.setX(map(noise(x, y, TIME), 0, 1, x - x_tolerance/2, x + x_tolerance/2));
      t.setY(map(noise(x, y, TIME), 0, 1, y - y_tolerance, y));
    }
    endShape();
    float x_init = t.getXInit();
    float y_init = t.getYInit();
    t.setX(x_init);
    t.setY(y_init);
  }
  
  TIME += 0.0001;
  if (h < LENGTH) { h++; }
}
