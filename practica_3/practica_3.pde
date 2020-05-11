import peasy.*;

int dimension = 20;
int cols, rows;
PImage groundTexture;


void setup() {
  size(1000, 800, P3D);

  cols = width/2 / dimension;
  rows = height / dimension;
}

void draw() {
  background(0);
  stroke(222, 184, 135);
  //fill(222, 184, 135);
  

  pushMatrix();
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-width/4, -height/2);  

  for (int i = 0; i < rows; i++) {
    textureMode(NORMAL);
    beginShape(TRIANGLE_STRIP);
    texture(img);
    for (int j = 0; j < cols; j++) {
      vertex(j*dimension, i*dimension);
      vertex(j*dimension, (j+1)*dimension);
      //rect(j*dimension, i*dimension, dimension, dimension);
    }
    endShape();
  }
  popMatrix();
}
