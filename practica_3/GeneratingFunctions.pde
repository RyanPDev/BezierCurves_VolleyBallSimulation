void initGame()
{
  gamePhase = Phase.SIMULATION;
  selectedPoint = PointSelected.DIRECCION;
  
  camVariables();

  courtVariable();

  lights();
  
  initCuves();
  timerReset();
  
  generatePlayers();
  
}

void generatePlayers()
{
   arrayPlayers = new Player[12];
   playerHeight = 180;
   playerWidthX = 45;
   playerWidthZ = 20;
   PVector auxVector = new PVector(0,0,0);
   int auxType = 0;
  
   
   for (int i = 0; i < 12; i++)
   {
       switch(i)
       {
            case 0:
              auxType = 0;
              auxVector = new PVector(courtInitPos.x + 200,-playerHeight / 2,courtInitPos.z - 200);
              break;
            case 1:
              auxType = 1;//
              auxVector = new PVector(courtPos.x,-playerHeight / 2,courtPos.z - ((3*(courtSize.z/2))/4));
              break;
            case 2:
              auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z - ((3*(courtSize.z/2))/4));
              break;
            case 3:
              auxVector = new PVector(courtPos.x - ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z - (((courtSize.z/2))/4));
              break;
            case 4:
              auxVector = new PVector(courtPos.x,-playerHeight / 2,courtPos.z - (((courtSize.z/2))/4));
              break;
            case 5:
              auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z - (((courtSize.z/2))/4));
              break;
            case 6:
              auxType = 2;
              auxVector = new PVector(courtPos.x - ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z + (((courtSize.z/2))/4));
              break;
            case 7:
              auxVector = new PVector(courtPos.x,-playerHeight / 2,courtPos.z + (((courtSize.z/2))/4));
              break;
            case 8:
              auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z + (((courtSize.z/2))/4));
              break;
            case 9:
              auxVector = new PVector(courtPos.x - ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z + ((3*(courtSize.z/2))/4));
              break;
            case 10:
              auxVector = new PVector(courtPos.x,-playerHeight / 2,courtPos.z + ((3*(courtSize.z/2))/4));
              break;
            case 11:
              auxVector = new PVector(courtPos.x + ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z + ((3*(courtSize.z/2))/4));
              break;
            default:
              print("error generating player " + i + "\n");
              break;
       }
       print("generating player " + i + "\n");
       arrayPlayers[i] = new Player(
         auxVector,
         auxType,
         playerHeight,
         playerWidthX,
         playerWidthZ
       );
       
   }
  
   
    
}

void timerReset()
{
  timeForReset = 200;
  ballFellTime = 0;
}

void camVariables()
{
  // Cámara
  cam = new PeasyCam(this, 2800);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2800);
  cam.rotateX(45);  // rotate around the x-axis passing through the subject
  // cam.rotateZ(180);  // rotate around the z-axis passing through the subject
  
  animationTimeInMillis = 1000;

  cameraPhase = CamPhase.COURT;
}

void courtVariable()
{
  courtPos = new PVector(0, 0, 0);
  floorSize = new PVector(0, 0, 0); 
  courtSize = new PVector(900, 1, 1800);
  destinationPoint = new PVector(0,0,0);
  
  courtInitPos = new PVector (0, 0, 0);
  courtInitPos.x = courtPos.x- (courtSize.x/2);
  courtInitPos.y = courtPos.y- (courtSize.y/2);
  courtInitPos.z = courtPos.z- (courtSize.z/2);
  
  destinationPoint = new PVector(courtPos.x, - playerHeight * 2,courtPos.z + (((courtSize.z/2))/4)); // AQUI
  
  reciviengHeight = 500;
  ballSize = 32.5;
  
  floorSize.x = courtSize.x*1.5;
  floorSize.y = courtSize.y * 0.5;
  floorSize.z = courtSize.z*1.5;

  antenaHeight = 243;
  antenaSize = 25;
  courtLinesSize = 25;
  distanceCenterAntena = 1097/2;
  netScale = 26;    
}

void initCuves()
{
  
  destinationSpike = new PVector(0,0,0);
  destinationSpike = new PVector(courtPos.x - ((3*(courtSize.x/2))/4),-playerHeight / 2,courtPos.z - ((3*(courtSize.z/2))/4));
  
 // spikeCurve = new InterpolCurve(color(260,21,133));
  
 // calcSpikeCurve();
  
  
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

  recieveCurve = new InterpolCurve(color(199,21,133));
}

void calcSpikeCurve()
{
   PVector [] ps;
   float distanceX,distanceZ;
   
   distanceX = (destinationPoint.x - puntoBola.x);
   distanceX = sqrt(sq(distanceX));
   
   distanceZ = (destinationPoint.z - puntoBola.z);
   distanceZ = sqrt(sq(distanceZ));       
   
   ps = new PVector[4];
   ps[0] = new PVector(puntoBola.x,puntoBola.y,puntoBola.z);
   
   PVector secondPointAux = new PVector(0,0,0);
   secondPointAux.x = puntoBola.x + (distanceX / 4);
   secondPointAux.y = -reciviengHeight;
   secondPointAux.z = puntoBola.z + (distanceZ / 4);
   ps[1] = new PVector(secondPointAux.x,secondPointAux.y,secondPointAux.z);
   
   PVector thirdPointAux = new PVector(0,0,0);
   thirdPointAux.x = puntoBola.x + ((3*distanceX) / 4);
   thirdPointAux.y = -reciviengHeight;
   thirdPointAux.z = puntoBola.z + ((3*distanceZ) / 4);
   ps[2] = new PVector(thirdPointAux.x,thirdPointAux.y,thirdPointAux.z);
   
   ps[3] = new PVector(destinationPoint.x,destinationPoint.y,destinationPoint.z);
   
   //recieveCurve.modifyPoints(pc);
}
