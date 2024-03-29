void initGame() // Funcion que actua como SetUp, inicializa todos los objetos y parametros
{
  
  gamePhase = Phase.SIMULATION;
  selectedPoint = PointSelected.DIRECTION;

  camVariables();
  loadTextures();
  courtVariable();

  lights();

  timerReset();
  generatePlayers();
  initCurves();
  
  noStroke();
  loadTextures(); 
  ball = createShape(SPHERE, ballSize);
  ball.setTexture(ballTexture);
  resetBooleans();
}

void loadTextures() // Carga todas las texturas del juego 
{
  ballTexture = loadImage("ballT.png");
}

void generatePlayers() // Inicializa y genera a todos los jugadores (aliados, enemigos y el propio player)
{
  arrayPlayers = new Player[12];
  playerHeight = 180;
  playerWidthX = 45;
  playerWidthZ = 20;
  PVector auxVector = new PVector(0, 0, 0);
  int auxType = 0;

  destinationPoint = new PVector(courtPos.x, - playerHeight * 2, courtPos.z + (((courtSize.z/2))/4)); // AQUI

  reciviengHeight = 500;
  ballSize = 32.5;
  boolean thisIsASetter = false;
  for (int i = 0; i < 12; i++)
  {
    switch(i)
    {
    case 0:
      auxType = 0;
      auxVector = new PVector(courtInitPos.x + 200, -playerHeight / 2, courtInitPos.z - 500);
      break;
    case 1:
      auxType = 1;//
      auxVector = new PVector(courtPos.x, -playerHeight / 2, courtPos.z - ((3*(courtSize.z/2))/4));
      break;
    case 2:
      auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z - ((3*(courtSize.z/2))/4));
      break;
    case 3:
      auxVector = new PVector(courtPos.x - ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z - (((courtSize.z/2))/4));
      break;
    case 4:
      auxVector = new PVector(courtPos.x, -playerHeight / 2, courtPos.z - (((courtSize.z/2))/4));
      break;
    case 5:
      auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z - (((courtSize.z/2))/4));
      break;
    case 6:
      auxType = 2;
      auxVector = new PVector(courtPos.x - ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z + (((courtSize.z/2))/4));
      break;
    case 7:
      thisIsASetter = true;
      auxVector = new PVector(courtPos.x, -playerHeight / 2, courtPos.z + (((courtSize.z/2))/4));
      break;
    case 8:
      thisIsASetter = false;
      auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z + (((courtSize.z/2))/4));
      break;
    case 9:
      auxVector = new PVector(courtPos.x - ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z + ((3*(courtSize.z/2))/4));
      break;
    case 10:
      auxVector = new PVector(courtPos.x, -playerHeight / 2, courtPos.z + ((3*(courtSize.z/2))/4));
      break;
    case 11:
      auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4), -playerHeight / 2, courtPos.z + ((3*(courtSize.z/2))/4));
      break;
    default:
      break;
    }
    arrayPlayers[i] = new Player(
      auxVector, 
      auxType, 
      playerHeight, 
      playerWidthX, 
      playerWidthZ, 
      thisIsASetter
      );
  }
  resetBallPos(); 
}

void resetBooleans() // Resetea los booleanos
{
  initServing = true;
  spikerRecieve = false;
  isServing = false;
  ballSpiked = false;
  ballIteration = 80;
  ballIncrementU = 1.0 /  ballIteration;
  curveInGame = true;
  ballInGame = true;
  ballCollided = 0;
  u = 0;
}

void resetBallPos() // Resetea la posicion de la bola a las manos del jugador 
{
  ballPos.x = arrayPlayers[0].pos.x;
  ballPos.y = arrayPlayers[0].pos.y;
  ballPos.z = arrayPlayers[0].pos.z + playerWidthZ + ballSize;
}

void timerReset() // Inicializa el timer
{
  timeForReset = 200;
  ballFellTime = 0;
}

void camVariables() // Inicializa todo lo relacionado con la camara
{
  // Cámara
  cam = new PeasyCam(this, 2800);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2800);
  cam.rotateX(45);  // rotate around the x-axis passing through the subject
  // cam.rotateZ(180);  // rotate around the z-axis passing through the subject

  animationTimeInMillis = 1000;


}

void courtVariable() // Inicializa las variables que se usar para definir posiciones clave de la cancha
{
  courtPos = new PVector(0, 0, 0);
  floorSize = new PVector(0, 0, 0); 
  courtSize = new PVector(900, 1, 1800);
  destinationPoint = new PVector(0, 0, 0);

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
}

void initCurves() // Inicializa todas las curvas (que no significa darles valores)
{

  beginCurve = new InterpolCurve(color(30));
  calcFirstCurve(); //--> Pestaña CalculationFunctions

  destinationSpike = new PVector(0, 0, 0);
  destinationSpike = new PVector(courtPos.x - ((3*(courtSize.x/2))/4), 100, courtPos.z - ((3*(courtSize.z/2))/4));

  spikeCurve = new InterpolCurve(color(260, 21, 133));
  blockCurve = new InterpolCurve(color(60, 22, 133));
  color c = color(255, 255, 0);
  PVector[] p = new PVector[4];
  //p[0] =  new PVector(courtInitPos.x + 200, - playerHeight, courtInitPos.z - 200);
  p[0] = new PVector(courtInitPos.x + 200, -playerHeight - 200, courtInitPos.z);          // BEZIER SI PASA POR EL PRIMERO
  p[1] = new PVector(courtInitPos.x +100, -250, courtInitPos.z + courtSize.z / 3);             // BEZIER NO PASA POR EL SEGUNDO
  p[2] = new PVector(courtInitPos.x +100, -270, courtInitPos.z + ( 2* courtSize.z / 3));       // BEZIER NO PASA POR EL TERCERO
  p[3] = new PVector(courtInitPos.x +100, -100, courtInitPos.z + ( 2* courtSize.z / 3) + 200); // BEZIER SI PASA POR EL ULTIMO

  // PUNTOS A PINTAR?
  float num = 50;
  // LLAMADA AL CONSTRUCTOR DE LA CURVA
  serveCurve = new BezierCurve(p, c, num);

  serveCurve.rearrangePoints();  //--> Pestaña BezierClass  

  recieveCurve = new InterpolCurve(color(199, 21, 133));
}
