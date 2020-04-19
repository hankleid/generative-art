class Thingy {
  float x;
  float y;
  float weight;
  color colr;
  float id;
  
  Thingy(float x, float y, float w, float i) {
    this.x = x;
    this.y = y;
    this.id = i;
    this.colr = color(0, 0, 0);
    this.weight = w;
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
