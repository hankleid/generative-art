float R = 50;
float THETA = 0;
color[] COLORS = {color(255, 204, 0),        // golden
                  color(255, 100, 80),       // coral
                  color(4, 230, 255),        // teal
                  color(241, 219, 255),      // lavender
                  color(200, 50, 50),        // pink
                  color(4, 20, 255)};        // blue
float WEIGHT = 20;
byte NUM_CIRCLES = 50;
ArrayList<CircleThingy> CIRCLES = new ArrayList<CircleThingy>();

void concentric_init() {
  background(50);
  noStroke();
  
  for (int i = 1; i <= NUM_CIRCLES; i++) {
    CIRCLES.add(new CircleThingy(random(0, TWO_PI),
                                 R + (WEIGHT*1.5)*i - 1,  // -1 is for antialiasing
                                 5, 
                                 WEIGHT, 
                                 COLORS[int(random(0, COLORS.length - 1))]));
  }
}

void concentric_draw() {
  translate(width/2, height/2);
  if (THETA > TWO_PI) { stop(); }
  for (CircleThingy thing : CIRCLES) {
    thing.squat();
    thing.incrementAngle(0.01);
  }
  THETA += 0.01;
}

class CircleThingy extends Thingy {
  float angle;
  float radius;
  
  CircleThingy(float a, float r, float i, float w, color c) {
    super(cos(a) * r, sin(a) * r, i, w, c);
    this.angle = a;
    this.radius = r;
  }
  
  void incrementAngle(float inc) {
    this.angle += inc;
    this.x = cos(this.angle) * this.radius;
    this.y = sin(this.angle) * this.radius;
  }
}
