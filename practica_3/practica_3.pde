//import peasy.*;

//PeasyCam cam;

curvaBezier miPrimeraBezier;
boolean mouseClick = false;
boolean pointgrabbed = false;

void setup() {
  size(800, 600, P3D);
  //cam = new PeasyCam(this, 100);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(500);

  color c = color(255, 255, 0);
  PVector[] p = new PVector[4];
  p[0] = new PVector(200, 200); // BEZIER SI PASA POR EL PRIMERO
  p[1] = new PVector(300, 500); // BEZIER NO PASA POR EL SEGUNDO
  p[2] = new PVector(400, 200); // BEZIER NO PASA POR EL TERCERO
  p[3] = new PVector(500, 500); // BEZIER SI PASA POR EL ULTIMO

  // PUNTOS A PINTAR?
  float num = 50;
  // LLAMADA AL CONSTRUCTOR DE LA CURVA
  miPrimeraBezier = new curvaBezier(p, c, num);
}

void draw() {
  background(0);
  camera();
  rectMode(CENTER);
  fill(51);
  stroke(255);

  translate(width/2, height/2, 0);
  rotateX(PI/3);
  rect(0, 200, width/2, height);

  //miPrimeraBezier.pintarCurva();
}

void mouseDragged() {
  miPrimeraBezier.moveControlPoints(new PVector(mouseX, mouseY));
}
