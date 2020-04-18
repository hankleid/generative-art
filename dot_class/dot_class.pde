void setup() {
  size(1920, 1080);
  background(0);
}

int i = 0;
int DOT_LIFETIME = 100;
int DOT_WEIGHT = 20;

void draw() {
  Dot d = new Dot(500, 500, DOT_LIFETIME, color(255, 204, 0), 20);
  d.update();
  Dot next = d.nextDot();
  next.update();
}

class Dot {
  float x, y;
  boolean dead;
  int lifetime;
  color dot_color;
  int fade;
  int weight;
  
  Dot(float x, float y, int life, color c, int w) {
    this.x = x;
    this.y = y;
    this.lifetime = life;
    this.dot_color = c;
    this.fade = 255;
    this.weight = w;
    
    this.squat();
  }
  
  void update() {
    this.lifetime --;
    if (this.lifetime <= 0) {
      this.dead = true;
    }
    if (!this.dead) {
      squat();
    } else {
      return;
    }
  }
  
  void squat() {
    if (this.fade > 0 && this.weight > 0) {
      strokeWeight(this.weight);
      stroke(red(this.dot_color), green(this.dot_color), blue(this.dot_color), this.fade);
      point(this.x, this.y);
      this.fade--;
      this.weight--;
    }
  }
  
  Dot nextDot() {
    return new Dot(this.x+1, this.y+0.5, DOT_LIFETIME, this.dot_color, DOT_WEIGHT);
  }

}
