void serveSimulation() // Funcion que controla toda la simulacion de la bola y las diferentes curvas
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
    ballPos =  beginCurve.calculateInterpolPoint(u); //--> Pestaña InterpolClass

    if (u >= 1)
    {
      initServing = false;
      u = 0;
      ballIteration = 50;
      ballIncrementU = 1.0 /  ballIteration;
    } else if (u > 0.65 && arrayPlayers[0].pos.y >= -(playerHeight/2) - 200)
    {
      arrayPlayers[0].pos.y -= 10; 
      arrayPlayers[0].pos.z += 5;
    } else
    {
      arrayPlayers[0].pos.z = ballPos.z;
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
        ballPos =  serveCurve.calculatePointBezier(u); //--> Pestaña BezierClass
      } else if (ballCollided == 1)
      {
        ballPos = blockCurve.calculateInterpolPoint(u); //--> Pestaña InterpolClass
      } else
      {  
        if (auxPrevBallState == 0)
        {
          ballPos =  serveCurve.calculatePointBezier(u); //--> Pestaña InterpolClass
        } else
        {
          ballPos = blockCurve.calculateInterpolPoint(u); //--> Pestaña InterpolClass
        }
        if (millis() - ballFellTime >= timeForReset)
        {

          stopServing(); //--> Pestaña GameControlFunctions
        }
      }
    } else
    {
      if (!ballSpiked)
      {
        ballPos = recieveCurve.calculateInterpolPoint(u); //--> Pestaña InterpolClass
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
        ballPos = spikeCurve.calculateInterpolPoint(u); //--> Pestaña InterpolClass
      }
    }

    if (ballPos.y- ballSize > -ballSize)
    {
      ballPos.y = -ballSize;
      if (ballCollided != 2)
      {
        if (!endingComplete)
        {
          if ((ballPos.x <= courtSize.x/2 && ballPos.x >= -courtSize.x/2) && (ballPos.z > courtPos.z && ballPos.z <= courtSize.z/2))
          {
            playerWin = true;
            // Player wins C:
          } else
          {
            // Player loses :C
          }
          endingComplete = true;
        }
        auxPrevBallState = ballCollided;
        ballFellTime = millis();
        ballCollided = 2;
      }
    }
    if ( ballPos.z < 20 && ballPos.z > -20 && ballPos.y >= -antenaHeight && ballCollided == 0)
    {
      ballCollided = 1;
      calcBlockCurve();
      u = 0;
    }
  }
  u+= ballIncrementU;

  if ( (u > 4 || ( !ballInGame && u > 1)) && !initServing) {
    if (!ballInGame && !ballSpiked)
    {
      u = 0;
      calcSpikeCurve();

      ballSpiked = true;
      ballIteration = 20;
      ballIncrementU = 1.0 /  ballIteration;
    } else
    {
      stopServing(); //--> Pestaña GameControlFunctions
    }
  }
}

float calculateModuleVector(PVector vector) //Calcula un vector unitario entre dos posiciones recibidas como parámetro
{
  float module = 0;

  // Se calcula el modulo del vector
  // La raiz cuadrada de la suma de las componentes o coordenadas al cuadrado

  float calculatedVector = sq(vector.x)+sq(vector.y)+sq(vector.z);

  if (calculatedVector != 0) // Prevenimos que no se haga la raiz cuadrada de 0
  {
    module = sqrt(calculatedVector);
  }

  return module;
}

PVector calculateVector(PVector pos1, PVector pos2) //Calcula un vector unitario entre dos posiciones recibidas como parámetro
{
  PVector calculatedVector;
  calculatedVector = new PVector(0, 0, 0);

  // Pos final (pos 2) menos pos inicial (pos1)
  calculatedVector.x = pos2.x - pos1.x;
  calculatedVector.y = pos2.y - pos1.y;
  calculatedVector.z = pos2.z - pos1.z;

  return calculatedVector;
}


void calcFirstCurve() // Calcula la curva que hace la bola cuando el jugador la lanza para arriba antes de realizar el golpe para sacar
{

  PVector [] pf;
  pf = new PVector[4];
  pf[0] = new PVector(0, 0, 0);
  pf[0].x = arrayPlayers[0].pos.x;
  pf[0].y = arrayPlayers[0].pos.y;
  pf[0].z = arrayPlayers[0].pos.z + playerWidthZ + ballSize;

  pf[3] = new PVector(courtInitPos.x + 200, -playerHeight - 200, courtInitPos.z);



  float distanceZ;

  distanceZ = (pf[3].z - pf[0].z);
  distanceZ = sqrt(sq(distanceZ));       

  PVector secondPointAux = new PVector(0, 0, 0);
  secondPointAux.x = ballPos.x;
  secondPointAux.y = ballPos.y - 400;
  secondPointAux.z = ballPos.z + (distanceZ / 4);
  pf[1] = new PVector(secondPointAux.x, secondPointAux.y, secondPointAux.z);

  PVector thirdPointAux = new PVector(0, 0, 0);
  thirdPointAux.x = ballPos.x;
  thirdPointAux.y = ballPos.y - 400;
  thirdPointAux.z = ballPos.z + ((3*distanceZ) / 4);
  pf[2] = new PVector(thirdPointAux.x, thirdPointAux.y, thirdPointAux.z);

  beginCurve.modifyPoints(pf); //--> Pestaña InterpolClass
}

void calcSpikeCurve() // Calcula la curva que sucede cuando el jugador contrario realiza un mate. Usamos esta basa de dos puntos ya que el mate es recto, los 2 restantes se determinan usando la equacion vectorial de la recta que forman los puntos
{
  PVector [] ps;
  float distanceX, distanceZ, distanceY;

  distanceX = (destinationSpike.x - ballPos.x);
  distanceX = sqrt(sq(distanceX));

  distanceY = (destinationSpike.y - ballPos.y);
  distanceY = sqrt(sq(distanceY));

  distanceZ = (destinationSpike.z - ballPos.z);
  distanceZ = sqrt(sq(distanceZ));       

  ps = new PVector[4];
  ps[0] = new PVector(ballPos.x, ballPos.y, ballPos.z);

  PVector secondPointAux = new PVector(0, 0, 0);
  secondPointAux.x = ballPos.x - (distanceX / 4);
  secondPointAux.y = ballPos.y + (distanceY / 4);
  secondPointAux.z = ballPos.z - (distanceZ / 4);
  ps[1] = new PVector(secondPointAux.x, secondPointAux.y, secondPointAux.z);

  PVector thirdPointAux = new PVector(0, 0, 0);
  thirdPointAux.x = ballPos.x - ((3*distanceX) / 4);
  thirdPointAux.y = ballPos.y + ((3*distanceY) / 4);
  thirdPointAux.z = ballPos.z - ((3*distanceZ) / 4);
  ps[2] = new PVector(thirdPointAux.x, thirdPointAux.y, thirdPointAux.z);

  ps[3] = new PVector(destinationSpike.x, destinationSpike.y, destinationSpike.z);

  spikeCurve.modifyPoints(ps); //--> Pestaña InterpolClass
}

void calcBlockCurve() // Calcula la curva que usa la bola para cuando choca o con la propia red o cuando choca con un jugador aliado
{
  PVector [] ps; 

  ps = new PVector[4];
  ps[0] = new PVector(ballPos.x, ballPos.y, ballPos.z);

  PVector secondPointAux = new PVector(0, 0, 0);
  secondPointAux.x = ballPos.x;
  secondPointAux.y = ballPos.y - 20;
  secondPointAux.z = ballPos.z - 200;
  ps[1] = new PVector(secondPointAux.x, secondPointAux.y, secondPointAux.z);

  PVector thirdPointAux = new PVector(0, 0, 0);
  thirdPointAux.x = ballPos.x;
  thirdPointAux.y = ballPos.y + 200;
  thirdPointAux.z = ballPos.z - 400;
  ps[2] = new PVector(thirdPointAux.x, thirdPointAux.y, thirdPointAux.z);

  PVector lastPointAux = new PVector(0, 0, 0);
  lastPointAux.x = ballPos.x;
  lastPointAux.y = ballPos.y + 600;
  lastPointAux.z = ballPos.z - 500;
  ps[3] = new PVector(lastPointAux.x, lastPointAux.y, lastPointAux.z);

  blockCurve.modifyPoints(ps); //--> Pestaña InterpolClass
}


PVector calculateUnitVector(PVector pos1, PVector pos2) // Calcula un vector unitario entre dos posiciones recibidas como parámetro
{
  PVector calculatedVector;
  calculatedVector = new PVector(0, 0, 0);

  // Pos final (pos 2) menos pos inicial (pos1)
  calculatedVector.x = pos2.x - pos1.x;
  calculatedVector.y = pos2.y - pos1.y;
  calculatedVector.z = pos2.z - pos1.z;

  // Se calcula el modulo del vector
  // La raiz cuadrada de la suma de las componentes o coordenadas al cuadrado

  float vector = sq(calculatedVector.x)+sq(calculatedVector.y)+sq(calculatedVector.z);

  if (vector != 0) // Prevenimos que no se haga la raiz cuadrada de 0
  {
    float module = sqrt(vector);

    // Se divide cada componente o coordenada del vector por el modulo para
    // hacerlo unitario

    calculatedVector.x /= module;
    calculatedVector.y /= module;
    calculatedVector.z /= module;
  }

  return calculatedVector;
}
