class Player
{
  PVector pos, initialPos, vel;
  color playerColor;
  int playerType;
  float pHeight, pWidthX, pWidthZ;
  boolean goingUp;
  boolean makeJump; // Debe hacer un salto?
  boolean isSetter, isPlayer;


  Player(PVector p, int pType, float h, float wX, float wZ, boolean s)
  {
    pos = new PVector (0, 0, 0);
    initialPos = new PVector (0, 0, 0);

    isSetter = s; // Es el capitan enemigo?
    pos = p;
    initialPos = p;

    playerType = pType;
    switch(playerType)
    {
    case 0:
      playerColor = color(0, 255, 127);
      break;
    case 1:
      playerColor = color(32, 178, 170);
      break;  
    case 2:
      playerColor = color(220, 38, 38);
      break;
    }

    pHeight = h;
    pWidthX = wX;
    pWidthZ = wZ;
    goingUp = true;
    makeJump = false;
  }



  void jumpPlayer() // Esta funcion se llama todo el rato, pero hasta que makeJump no sea true, no hara un salto, una vez lo sea, el jugador saltará y caerá, volviendo la variable a falsa
  {
    if (makeJump)
    {
      float jumpVector =  destinationPoint.y - pos.y;
      jumpVector = sqrt(sq(jumpVector));
      if (goingUp)
      {
        if (pos.y > destinationPoint.y + playerHeight / 2)
        {
          pos.y -= jumpVector * 0.1;
        } else
        {
          goingUp = false;
        }
      } else
      {
        if (pos.y < -playerHeight / 2)
        {
          pos.y += jumpVector * 0.1;
        } else
        {
          goingUp = true;
          makeJump = false;
        }
      }
    }
  }

  void calcCollisionBall() // Calcula la colision entre la bola y todos los jugadores
  {
    if (ballInGame && gamePhase == Phase.SERVE && ballCollided == 0)
    {
      if (ballPos.y + ballSize >= -playerHeight)
      {
        if (ballPos.x + ballSize >= pos.x - pWidthX && ballPos.x - ballSize <= pos.x + pWidthX)
        {
          if (ballPos.z + ballSize >= pos.z - pWidthZ && ballPos.z - ballSize <= pos.z + pWidthZ)
          {
            if (playerType == 2) // Si el jugador contra el que choca es enemigo, estos reciviran la bola
            {
              ballInGame = false;

              calcNewRecievingPoint(); 

              makeJump = true;
            } else if (playerType == 1) // Si el jugador es aliado, la bola rebotará en su nuca, haciendo que te odie para siempre
            {
              boolean hatesPlayer = true; // Esta variable no es importante en el propio juego, pero si lo será en su dia a dia
              ballCollided = 1;
              calcBlockCurve(); // --> Pestaña CalculationFunctions
              u = 0;
            }
          }
        }
      }
    }
  }

  void calcNewRecievingPoint() // Crea una curva que va desde el lugar que un jugador recive la bola hasta su colocador ( Si es el colocador el que recibe, la enviara a su jugador de la izquierda)
  {
    float auxPos = destinationPoint.x;
    if (isSetter)
    {
      spikerRecieve = true;
      destinationPoint.x = arrayPlayers[6].pos.x; // Jugador 6 es el jugador a la izquierda del colocador
    }
    PVector [] pc;
    float distanceX, distanceZ;
    u = 0;

    distanceX = (destinationPoint.x - ballPos.x);
    distanceX = sqrt(sq(distanceX));

    distanceZ = (destinationPoint.z - ballPos.z);
    distanceZ = sqrt(sq(distanceZ));       

    pc = new PVector[4];
    pc[0] = new PVector(ballPos.x, ballPos.y, ballPos.z);

    PVector secondPointAux = new PVector(0, 0, 0);
    if (ballPos.x < -100)
      secondPointAux.x = ballPos.x + (distanceX / 4);
    else
    {
      secondPointAux.x = ballPos.x - (distanceX / 4);
    }
    secondPointAux.y = -reciviengHeight;
    secondPointAux.z = ballPos.z - (distanceZ / 4);
    pc[1] = new PVector(secondPointAux.x, secondPointAux.y, secondPointAux.z);

    PVector thirdPointAux = new PVector(0, 0, 0);
    if (ballPos.x < -100)
      thirdPointAux.x = ballPos.x + ((3*distanceX) / 4);
    else
    {
      thirdPointAux.x = ballPos.x - ((3*distanceX) / 4);
    }
    thirdPointAux.y = -reciviengHeight;
    thirdPointAux.z = ballPos.z - ((3*distanceZ) / 4);
    pc[2] = new PVector(thirdPointAux.x, thirdPointAux.y, thirdPointAux.z);

    pc[3] = new PVector(destinationPoint.x, destinationPoint.y, destinationPoint.z);

    recieveCurve.modifyPoints(pc); // --> Pestaña InterpolClass
    destinationPoint.x = auxPos;
  }

  void drawPlayer() // Funcion que dibuja a los jugadores
  {
    if (isSetter && camera9)
    {
    } else
    {
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(playerColor);
      stroke(255);
      strokeWeight(2);

      box(pWidthX, pHeight, pWidthZ);

      popMatrix();
    }
  }
}
