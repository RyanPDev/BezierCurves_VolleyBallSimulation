import peasy.*;
// CODIGO QUE IMPLEMENTA UNA CURVA DE BEZIER
// QUE TIENE CONTINUIDAD C1 QUE ES MEJOR QUE C0


// ZONA DE VARIABLES Y OBJETOS

curvaBezier miPrimeraBezier;
InterpolCurve recieveCurve; 
InterpolCurve spikeCurve; 
InterpolCurve blockCurve;
InterpolCurve beginCurve;


boolean mouseClick = false;
boolean pointgrabbed = false;
boolean printCurves = false;
boolean playerWin = false;
boolean endingComplete = false;

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
boolean ballInGame, initServing, showRedArrow = true;

boolean curveInGame = true;
int iteracionDeBola = 50;
PVector puntoBola = new PVector(0, 0, 0);
float incrementoBolaU = 1.0 /  iteracionDeBola;
float u = 0;
color ballColor = color(255, 165, 0);
int ballCollided = 0;
int auxPrevBallState = 0;
boolean ballSpiked = false;
boolean camera7, camera8, camera9, spikerRecieve, showControls = false;

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

//STRINGS
String showControlsText = "Press 'H' to show simulation controls";
String showControlsText2 = "Drag Mouse to try another Serve";
String showControlsText3 = "Press space to activate edit Mode";
String simulationControlsText= "Press 'S' to serve the ball\nPress 'SPACE' to show or hide the curves\nYou can press the numbers 1 to 9 to get diferent camera angles.\nThe ANGLES ARE:\nSTATIC:\n  1-4: Diferent Court Views\nANIMATED\n  5: Referee view - 6: Spectator view - 7: Ball view\n  8: Player view (first person) - 9: Enemy's captain (first person) ";
String addingControlText = "Drag the mouse UP and SIDEWAYS to move\n the selected point of your serve------->\nPress 'C' or 'X' to change which point you are moving\nYou have DIRECTION,SPIN and POWER\nTo move power just move up or down the mouse\n";
String cameraControlsText= "\n                                                        -Press 'H' to hide controls-";


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
  miPrimeraBezier.pintarCurva();
  if (gamePhase == Phase.SERVE) {
    serveBall();
    beginCurve.pintaCurva();
    if (ballCollided == 1)
      blockCurve.pintaCurva();
    if (!ballInGame)
    {
      recieveCurve.pintaCurva();
      spikeCurve.pintaCurva();
    }
  }
  for (int i = 0; i < arrayPlayers.length; i++)
  {
    if (i == 0 && camera8)
    {
    } else
    {
      arrayPlayers[i].drawPlayer();
    }
    arrayPlayers[i].calcCollisionBall();
    arrayPlayers[i].jumpPlayer();
  }
  pushMatrix();
  translate(puntoBola.x, puntoBola.y, puntoBola.z);
  if (!camera7)
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

  if (initServing)
  {
    puntoBola =  beginCurve.calculameUnPunto(u);

    if (u >= 1)
    {
      initServing = false;
      u = 0;
      iteracionDeBola = 50;
      incrementoBolaU = 1.0 /  iteracionDeBola;
    } else if (u > 0.65 && arrayPlayers[0].pos.y >= -(playerHeight/2) - 200)
    {
      arrayPlayers[0].pos.y -= 10; 
      arrayPlayers[0].pos.z += 5;
    } else
    {
      arrayPlayers[0].pos.z = puntoBola.z;
    }
  } else {
    if (ballInGame)
    {
      if (ballCollided == 0)
      {
        if (arrayPlayers[0].pos.y <= -playerHeight/2)
        {
          arrayPlayers[0].pos.y += 10; 
          arrayPlayers[0].pos.z += 5;
        }
        puntoBola =  miPrimeraBezier.calculameUnPunto(u);
      } else if (ballCollided == 1)
      {
        puntoBola = blockCurve.calculameUnPunto(u);
      } else
      {  
        if (auxPrevBallState == 0)
        {
          puntoBola =  miPrimeraBezier.calculameUnPunto(u);
        } else
        {
          puntoBola = blockCurve.calculameUnPunto(u);
        }
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
        if (u > 0.7)
        {
          if (!spikerRecieve)
            arrayPlayers[7].makeJump = true; 
          else
          {
            arrayPlayers[6].makeJump = true;
          }
        }
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
        if (!endingComplete)
        {
          if ((puntoBola.x <= courtSize.x/2 && puntoBola.x >= -courtSize.x/2) && (puntoBola.z > courtPos.z && puntoBola.z <= courtSize.z/2))
          {
            playerWin = true;
            println("player WINS!!!!!!");
          } else
          {
            println("player Lose");
          }
          endingComplete = true;
        }
        auxPrevBallState = ballCollided;
        ballFellTime = millis();
        ballCollided = 2;
      }
    }
    if ( puntoBola.z < 20 && puntoBola.z > -20 && puntoBola.y >= -antenaHeight && ballCollided == 0)
    {
      //stroke(0, 0, 255);
      ballCollided = 1;
      calcBlockCurve();
      u = 0;
    }
    // fill(ballColor);
  }
  u+= incrementoBolaU;

  if ( (u > 4 || ( !ballInGame && u > 1)) && !initServing) {
    if (!ballInGame && !ballSpiked)
    {
      u = 0;
      calcSpikeCurve();

      ballSpiked = true;
      iteracionDeBola = 20;
      incrementoBolaU = 1.0 /  iteracionDeBola;
    } else
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
      arrayPlayers[0].pos = new PVector(courtInitPos.x + 200, -playerHeight / 2, courtInitPos.z - 500);
      resetBallPos();
      playerWin = false;
      endingComplete = false;
      mouseClick = true;
      miPrimeraBezier.lastMouseInput = new PVector(mouseX, mouseY, 0);
    }
    if (!freeCam && shouldModify)
    {

      miPrimeraBezier.moveControlPointsMouse(new PVector(mouseX, mouseY, 0), point);
    }
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
