import peasy.*;

int dimension = 20;
int cols, rows;

void setup() {
  size(600, 600, P3D);
  cols = width/2 / dimension;
  rows = height / dimension;
}

void draw() {
  background(0);
  noStroke();
  fill(222, 184, 135);  

  pushMatrix();
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-width/4, -height/2);  

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      rect(j*dimension, i*dimension, dimension, dimension);
    }
  }
  
  popMatrix();
}
