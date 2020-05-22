import peasy.*;
// CODIGO QUE IMPLEMENTA UNA CURVA DE BEZIER
// QUE TIENE CONTINUIDAD C1 QUE ES MEJOR QUE C0


// ZONA DE VARIABLES Y OBJETOS

curvaBezier miPrimeraBezier;
boolean mouseClick = false;
boolean pointgrabbed = false;

//Cámara
PGraphics3D g3;
PeasyCam cam;
enum CamPhase {
  COURT, FIRSTPOINT, SECONDPOINT, LASTPOINT
}; // Enumerador con los diferentes estados de la camara
CamPhase cameraPhase; // La fase actual de la camara en la que se encuentra el juego
boolean freeCam = true;
long animationTimeInMillis; // Tiempo que tarda la camara en alcanzar el objetivo a mirar

enum PointSelected {
  NONE, FIRST, SECOND, LAST;
};

PointSelected selectedPoint;
boolean shouldModify;
boolean changedSelectedObject = false;

enum Phase {
  STARTING, SIMULATION, PAUSE
}; // Enumerador con los diferentes estados de la partida
Phase gamePhase; // La fase actual en la que se encuentra el juego
Phase auxiliarPhase; // Variable que guarda la fase en la que el jugador se encuentra cuando le da al pause
boolean isPaused = false; // Variable de control para controlar el flujo de codigo cuando el juego está pausado
boolean isIncreasing = false;

//TERRENO
int cols, rows, size = 20;

//ZONA SETUP

void setup()
{
  size(800, 600, P3D);
  gamePhase = Phase.SIMULATION;
  selectedPoint = PointSelected.NONE;
  // Cámara
  cam = new PeasyCam(this, 50);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2800);

  animationTimeInMillis = 1000;

  cameraPhase = CamPhase.COURT;
  updateCameraLookAt();

  lights();
  color c = color(255, 255, 0);
  PVector[] p = new PVector[4];
  p[0] = new PVector(200, -200, 200); // BEZIER SI PASA POR EL PRIMERO
  p[1] = new PVector(200, -200, 400); // BEZIER NO PASA POR EL SEGUNDO
  p[2] = new PVector(200, -200, 800); // BEZIER NO PASA POR EL TERCERO
  p[3] = new PVector(200, 0, 1000); // BEZIER SI PASA POR EL ULTIMO

  // PUNTOS A PINTAR?
  float num = 50;
  // LLAMADA AL CONSTRUCTOR DE LA CURVA
  miPrimeraBezier = new curvaBezier(p, c, num);

  cols = width/size;
  rows = height/size;
}
//ZONA DRAW

void draw()
{
  background(255);
   

  miPrimeraBezier.pintarCurva();

  drawHUD();

  //TERRENO
  drawCourt();
}
void mouseDragged()
{
  int point = 0;
  shouldModify = true;
  switch(selectedPoint)
  {
  case FIRST:
    point = 1;
    break;
  case SECOND:
    point = 2;
    break;
  case LAST:
    point = 3;
    break;
  default:
    shouldModify = false;
    break;
  }

  if (!mouseClick)
  {
    mouseClick = true;
    miPrimeraBezier.lastMouseInput = new PVector(mouseX, mouseY, 0);
  }
  if (!freeCam && shouldModify)
    miPrimeraBezier.moveControlPointsMouse(new PVector(mouseX, mouseY, 0), point);
}
void mouseReleased()
{
  if (mouseClick)
    mouseClick = false;
}
