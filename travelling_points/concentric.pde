float THETA = 0;
float ANGLE_INC = 0.005;
float N_X = 0.2;
float N_Y = 0.8;
color[] COLORS = {color(255, 224, 138),        // golden
                  color(255, 163, 138),        // coral
                  color(138, 255, 234),        // teal
                  color(200, 168, 255),        // lavender
                  color(255, 138, 161),        // pink
                  color(138, 173, 255)};       // blue
float WEIGHT = 40;
float R = -WEIGHT/2; // smallest radius; every subsequent circle will be farther from the center.
byte NUM_CIRCLES = 30;
ArrayList<CircleThingy> CIRCLES = new ArrayList<CircleThingy>();

void concentric_init() {
  background(50);
  noStroke();
  
  float prevR = R;
  for (int i = 1; i <= NUM_CIRCLES; i++) {
    float weight = random(WEIGHT - 20, WEIGHT + 15);
    CIRCLES.add(new CircleThingy(random(PI/8, TWO_PI), // starting angle
                                 prevR + weight/2,     // radius
                                 random(0, 500),       // id
                                 weight,               // thiccness
                                 COLORS[int(random(0, COLORS.length - 1))])); 
    prevR += weight;
  }
}

void concentric_draw() {
  translate(width/2, height/2);
  for (CircleThingy thing : CIRCLES) {
    if (thing.totalTraversed() <= TWO_PI) { // only draw if the Thing has yet to complete its circle.
      thing.squat();
      thing.incrementAngle(map(noise(N_X, N_Y, thing.getID()), 0, 1, ANGLE_INC/100, ANGLE_INC*2));
    }
    N_X += 0.001;
  }
  N_Y += 0.001;
}

class CircleThingy extends Thingy {
  float angle;
  float radius;
  float totalTraversed; // # of radians the Thing has travelled so far;
  
  CircleThingy(float a, float r, float i, float w, color c) {
    super(cos(a) * r, sin(a) * r, i, w, c);
    this.angle = a;
    this.radius = r;
    this.totalTraversed = 0;
  }
  
  void incrementAngle(float inc) {
    this.angle += inc;
    this.totalTraversed += inc;
    this.x = cos(this.angle) * this.radius;
    this.y = sin(this.angle) * this.radius;
  }
  
  float totalTraversed() {
    return this.totalTraversed;
  }
}
