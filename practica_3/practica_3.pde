import peasy.*;
// CODIGO QUE IMPLEMENTA UNA CURVA DE BEZIER
// QUE TIENE CONTINUIDAD C1 QUE ES MEJOR QUE C0


// ZONA DE VARIABLES Y OBJETOS

curvaBezier miPrimeraBezier;
boolean mouseClick = false;
boolean pointgrabbed = false;

// GameVariables
PVector courtPos, courtSize, floorSize, courtInitPos;
float playerHeight, antenaHeight, antenaSize, courtLinesSize, distanceCenterAntena;
int rows, cols, netScale;

PVector recievingPoint, destinationPoint, secondRecievingPoint, ThirdRecievingPoint;
float reciviengHeight, ballSize;

//Cámara
PGraphics3D g3;
PeasyCam cam;
enum CamPhase {
  COURT, FIRSTPOINT, SECONDPOINT, LASTPOINT
}; // Enumerador con los diferentes estados de la camara
CamPhase cameraPhase; // La fase actual de la camara en la que se encuentra el juego
boolean freeCam = false;
long animationTimeInMillis; // Tiempo que tarda la camara en alcanzar el objetivo a mirar

enum PointSelected {
  NONE, DIRECCION, EFECTO, POTENCIA;
};

PointSelected selectedPoint;
boolean shouldModify;
boolean changedSelectedObject = false;


enum Phase {
  STARTING, SIMULATION, PAUSE, SERVE
}; // Enumerador con los diferentes estados de la partida
Phase gamePhase; // La fase actual en la que se encuentra el juego
Phase auxiliarPhase; // Variable que guarda la fase en la que el jugador se encuentra cuando le da al pause
boolean isServing = false; // Variable de control para controlar el flujo de codigo cuando el juego está pausado
boolean isIncreasing = false;


boolean curveInGame = true;
int iteracionDeBola = 50;
PVector puntoBola = new PVector(0, 0, 0);
float incrementoBolaU = 1.0 /  iteracionDeBola;
float u = 0;
color ballColor = color(255, 224, 60);
int ballCollided = 0;

final int view1=1;
final int view2=2;
final int view3=3;
final int view4=4;
final int view5=5;
final int view6=6;
final int view7=7;
final int view8=8;
final int view9=9;
int state = view1;

//ZONA SETUP

void setup()
{
  size(800, 600, P3D);
  gamePhase = Phase.SIMULATION;
  selectedPoint = PointSelected.DIRECCION;
  // Cámara
  cam = new PeasyCam(this, 2800);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2800);
  cam.rotateX(45);  // rotate around the x-axis passing through the subject
  // cam.rotateZ(180);  // rotate around the z-axis passing through the subject
  ballSize = 65;
  animationTimeInMillis = 1000;

  cameraPhase = CamPhase.COURT;

  courtPos = new PVector(0, 0, 0);
  floorSize = new PVector(0, 0, 0); 
  courtSize = new PVector(900, 1, 1800);

  courtInitPos = new PVector (0, 0, 0);
  courtInitPos.x = courtPos.x- (courtSize.x/2);
  courtInitPos.y = courtPos.y- (courtSize.y/2);
  courtInitPos.z = courtPos.z- (courtSize.z/2);

  floorSize.x = courtSize.x*1.5;
  floorSize.y = courtSize.y * 0.5;
  floorSize.z = courtSize.z*1.5;

  antenaHeight = 243;
  antenaSize = 25;
  courtLinesSize = 25;
  distanceCenterAntena = 1097/2;
  netScale = 26;

  lights();
  color c = color(255, 255, 0);
  PVector[] p = new PVector[4];
  p[0] = new PVector(courtInitPos.x, -200, courtInitPos.z); // BEZIER SI PASA POR EL PRIMERO
  p[1] = new PVector(courtInitPos.x +100, -250, courtInitPos.z + courtSize.z / 3); // BEZIER NO PASA POR EL SEGUNDO
  p[2] = new PVector(courtInitPos.x +100, -270, courtInitPos.z + ( 2* courtSize.z / 3)); // BEZIER NO PASA POR EL TERCERO
  p[3] = new PVector(courtInitPos.x +100, -100, courtInitPos.z + ( 2* courtSize.z / 3) + 200); // BEZIER SI PASA POR EL ULTIMO

  // PUNTOS A PINTAR?
  float num = 50;
  // LLAMADA AL CONSTRUCTOR DE LA CURVA
  miPrimeraBezier = new curvaBezier(p, c, num);

  miPrimeraBezier.rearrangePoints();    

  //updateCameraLookAt();
  // cam.setPitchRotationMode();
}
//ZONA DRAW

void draw()
{
  //TERRENO
  background(111);
  cameraAngle();

  if (gamePhase == Phase.SIMULATION) {
    miPrimeraBezier.pintarCurva();
  } else if (gamePhase == Phase.SERVE) {
    serveBall();
  }
  drawCourt();
  drawHUD();
}

void serveBall()
{

  pushMatrix();
  switch(ballCollided)
  {
  case 0:
    stroke(ballColor);
    break;
  case 1:
    stroke(0, 0, 255);
    break;
  case 2:
    stroke(255, 0, 0);
    break;
  default:
    break;
  }

  puntoBola =  miPrimeraBezier.calculameUnPunto(u);  
  if ( puntoBola.z < 20 && puntoBola.z > -20 && puntoBola.y >= -antenaHeight)
  {
    stroke(0, 0, 255);
    ballCollided = 1;
  }
  if (puntoBola.y >= 0)
  {
    stroke(255, 0, 0);

    ballCollided = 2;
  }
  translate(puntoBola.x, puntoBola.y, puntoBola.z);
  sphere(ballSize);
  u+= incrementoBolaU;
  if ( u > 4) {
    stopServing();
  }

  popMatrix();
}


void mouseDragged()
{
  if (gamePhase == Phase.SIMULATION)
  {
    int point = 0;
    shouldModify = true;
    switch(selectedPoint)
    {
    case DIRECCION:
      point = 1;
      break;
    case EFECTO:
      point = 2;
      break;
    case POTENCIA:
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
}
void mouseReleased()
{
  if (gamePhase == Phase.SIMULATION)
  {
    if (mouseClick)
      mouseClick = false;
  }
}
