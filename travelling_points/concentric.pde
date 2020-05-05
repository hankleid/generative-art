boolean hasStarted = false; // this is so that the Thing draws at least once before falling into the stop condition
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
byte NUM_CIRCLES = 25;
ArrayList<CircleThingy> CIRCLES = new ArrayList<CircleThingy>();

void concentric_init() {
  background(50);
  noStroke();
  
  float prevR = R;
  for (int i = 1; i <= NUM_CIRCLES; i++) {
    float weight = random(WEIGHT - 15, WEIGHT + 15);
    CIRCLES.add(new CircleThingy(random(PI, TWO_PI),
                                 prevR + weight/2,
                                 random(0, 500), 
                                 weight, 
                                 COLORS[int(random(0, COLORS.length - 1))]));
    prevR += weight;
  }
}

void concentric_draw() {
  translate(width/2, height/2);
  for (CircleThingy thing : CIRCLES) {
    if (thing.atInitPos() && hasStarted) {
      continue; 
    } else { // only draw if the thing has yet to return to its initial position.
      thing.squat();
      thing.incrementAngle(map(noise(N_X, thing.getID(), N_Y), 0, 1, -ANGLE_INC, ANGLE_INC*3));
    }
    N_X += 0.001;
  }
  hasStarted = true; // this really only needs to be set once but I'm too lazy to optimize this line.
  N_Y += 0.001;
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
