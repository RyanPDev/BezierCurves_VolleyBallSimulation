import peasy.*;
// CODIGO QUE IMPLEMENTA UNA CURVA DE BEZIER
// QUE TIENE CONTINUIDAD C1 QUE ES MEJOR QUE C0


// ZONA DE VARIABLES Y OBJETOS

curvaBezier miPrimeraBezier;
InterpolCurve recieveCurve; 
InterpolCurve spikeCurve; 

boolean mouseClick = false;
boolean pointgrabbed = false;
boolean printCurves = false;

// GameVariables
PVector courtPos, courtSize, floorSize, courtInitPos;
float playerHeight, playerWidthX, playerWidthZ, antenaHeight, antenaSize, courtLinesSize, distanceCenterAntena;
int rows, cols, netScale;

PVector recievingPoint, destinationPoint, destinationSpike;
float reciviengHeight, ballSize;

Player[] arrayPlayers;


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
boolean ballInGame = true;

boolean curveInGame = true;
int iteracionDeBola = 50;
PVector puntoBola = new PVector(0, 0, 0);
float incrementoBolaU = 1.0 /  iteracionDeBola;
float u = 0;
color ballColor = color(255, 165, 0);
int ballCollided = 0;
boolean ballSpiked = false;

PImage ballTexture;
PShape ball;

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

//TIMER
float timeForReset;
float ballFellTime;


//ZONA SETUP

void setup()
{
  size(800, 600, P3D);
  initGame();
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
    if (!ballInGame)
    {
      recieveCurve.pintaCurva();
      spikeCurve.pintaCurva();
    }
  }
  for (int i = 0; i < arrayPlayers.length; i++)
  {
    arrayPlayers[i].drawPlayer();
    arrayPlayers[i].calcCollisionBall();
  }
  pushMatrix();
  translate(puntoBola.x, puntoBola.y, puntoBola.z);
  shape(ball);
  popMatrix();
  
  drawCourt();
  drawHUD();
}

void serveBall()
{

  

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

  if (ballInGame)
  {
    if (ballCollided != 2)
      puntoBola =  miPrimeraBezier.calculameUnPunto(u); 
    else
    {  
      puntoBola =  miPrimeraBezier.calculameUnPunto(u); 
      if (millis() - ballFellTime >= timeForReset)
      {
       
        stopServing();
      }
    }
  } else
  {
    if (!ballSpiked)
    {
      puntoBola = recieveCurve.calculameUnPunto(u);
    } else
    {
      puntoBola = spikeCurve.calculameUnPunto(u);
    }
  }
  if (puntoBola.y- ballSize > -ballSize)
  {
    puntoBola.y = -ballSize;
    if (ballCollided != 2)
    {
      ballFellTime = millis();
      ballCollided = 2;
    }
  }
  if ( puntoBola.z < 20 && puntoBola.z > -20 && puntoBola.y >= -antenaHeight)
  {
    //stroke(0, 0, 255);
    ballCollided = 1;
  }
  // fill(ballColor);

  
  u+= incrementoBolaU;

  if ( u > 4 || ( !ballInGame && u > 1)) {
    if (!ballInGame && !ballSpiked)
    {
      u = 0;
      calcSpikeCurve();
      ballSpiked = true;
      iteracionDeBola = 20;
      incrementoBolaU = 1.0 /  iteracionDeBola;
    }
    
    else
    {
      stopServing();
    }
  }

  
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
