import peasy.*;


// CURVES

BezierCurve serveCurve;
InterpolCurve recieveCurve; 
InterpolCurve spikeCurve; 
InterpolCurve blockCurve;
InterpolCurve beginCurve;

// BOOLEANS

boolean mouseClick = false;
boolean pointgrabbed = false;
boolean printCurves = false;
boolean playerWin = false;
boolean endingComplete = false;
boolean freeCam = false;
boolean isServing = false; // Variable de control para controlar el flujo de codigo cuando el juego está pausado
boolean isIncreasing = false;
boolean ballInGame, initServing, showRedArrow = true;
boolean impossibleServe = false;
boolean curveInGame = true;
boolean shouldModify;
boolean changedSelectedObject = false;
boolean ballSpiked = false;
boolean camera7, camera8, camera9, spikerRecieve, showControls = false;

// GameVariables

PVector courtPos, courtSize, floorSize, courtInitPos, recievingPoint, destinationPoint, destinationSpike;
float playerHeight, playerWidthX, playerWidthZ, antenaHeight, antenaSize, courtLinesSize, distanceCenterAntena,reciviengHeight, ballSize;;
int rows, cols, netScale;
long animationTimeInMillis;
int ballIteration = 50;
PVector ballPos = new PVector(0, 0, 0);
float ballIncrementU = 1.0 /  ballIteration;
float u = 0;
color ballColor = color(255, 165, 0);
int ballCollided = 0;
int auxPrevBallState = 0;
int numOfBleachers = 6; // Numero de gradas del estadio

PImage ballTexture;
PShape ball;

// GameObjects

    //Players
Player[] arrayPlayers;

    //Camera
PGraphics3D g3;
PeasyCam cam;

// Enums
enum PointSelected {
  NONE, DIRECTION, SPIN, POWER;
};
PointSelected selectedPoint;
enum Phase {
  STARTING, SIMULATION, PAUSE, SERVE
}; // Enumerador con los diferentes estados de la partida
Phase gamePhase; // La fase actual en la que se encuentra el juego
Phase auxiliarPhase; // Variable que guarda la fase en la que el jugador se encuentra cuando saca

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


void setup()
{
  size(800, 600, P3D);
  initGame(); // --> Pestaña GeneratingFunctions
}

void draw()
{
  background(111);
  cameraAngle(); // --> Pestaña CameraFunctions
  serveCurve.drawBezierCurve(); // --> Pestaña BezierClass
  if (gamePhase == Phase.SERVE) {
    
    serveSimulation(); // --> Pestaña CalculationFunctions
    beginCurve.drawInterpolationCurve(); // --> Pestaña InterpolClass
    if (ballCollided == 1)
      blockCurve.drawInterpolationCurve(); // --> Pestaña InterpolClass
    if (!ballInGame)
    {
      recieveCurve.drawInterpolationCurve(); // --> Pestaña InterpolClass
      spikeCurve.drawInterpolationCurve(); // --> Pestaña InterpolClass
    }
  }
  for (int i = 0; i < arrayPlayers.length; i++)
  {
    if (i == 0 && camera8)
    {
    } else
    {
      arrayPlayers[i].drawPlayer(); // --> Pestaña PlayerClass
    }
    arrayPlayers[i].calcCollisionBall(); // --> Pestaña PlayerClass
    arrayPlayers[i].jumpPlayer(); // --> Pestaña PlayerClass
  }
  pushMatrix();
  translate(ballPos.x, ballPos.y, ballPos.z);
  if (!camera7)
    shape(ball);
  popMatrix();

  drawCourt(); // --> Pestaña Terrain
  drawHUD();  // --> Pestaña HUD
}
