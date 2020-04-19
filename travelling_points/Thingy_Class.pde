class Thingy {
  float x;
  float y;
  float weight;
  color colr;
  float id;
  
  Thingy(float x, float y, float i, float w, color c) {
    this(x, y, i, w);
    this.colr = c;
  }
  
  Thingy(float x, float y, float i, float w) {
    this(x, y, i);
    this.weight = w;
  }
  
  Thingy(float x, float y, float i) {
    this(x, y);
    this.id = i;
  }
  
  Thingy(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Thingy() {
    this.x = 0;
    this.y = 0;
    this.id = 5;
    this.colr = color(0, 0, 0);
    this.weight = 5;
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
    ellipse(this.x, this.y, this.weight, this.weight);
  }
}