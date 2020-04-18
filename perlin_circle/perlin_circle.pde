float noiseMax = 0.8;
float zoff = 0; // animation noise
int red_lower = 100;
int red_upper = 200;
int green_lower = 160;
int green_upper = 220;
int blue_lower = 220;
int blue_upper = 255;
color fill_c = color(red_upper, green_upper, blue_upper);
color stroke_c = color(red_lower-20, green_lower-20, blue_lower-20);

float RESIZE_FACTOR = 0.5;

void setup() {
  size(1920, 1080);
  frameRate(15);
}

void draw() {
  background(color(250, 250, 255));
  noFill();
  stroke(stroke_c);
  translate(width/2, height/2);
  beginShape();
  
  for (float theta = 0; theta < TWO_PI; theta += 0.1) {
      float xoff = map(cos(theta), -1, 1, 0, noiseMax);
      float yoff = map(sin(theta), -1, 1, 0, noiseMax);
      float r = map(noise(xoff, yoff, zoff), 0, 1, 50 + RESIZE_FACTOR, 100 + RESIZE_FACTOR);
      
      strokeWeight(map(noise(zoff), 0, 1, 1 + RESIZE_FACTOR/5, 20 + RESIZE_FACTOR/5));
      vertex(r * cos(theta), r * sin(theta));
      //vertex(r/4 * cos(theta), r/4 * sin(theta));
      stroke_c = color(map(noise(zoff*2), 0, 1, red_lower, red_upper), 
                map(noise(zoff), 0, 1, green_lower, green_upper),
                map(noise(zoff*5), 0, 1, blue_lower, blue_upper));
   }
   RESIZE_FACTOR += 0.5;
   endShape(CLOSE);
   zoff += 0.1; //next 'frame'
}
