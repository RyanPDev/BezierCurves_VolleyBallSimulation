class Player
{
  PVector pos, initialPos, vel;
  color playerColor;
  int playerType;
  float pHeight, pWidthX, pWidthZ;
  boolean hasCollided;
  boolean goingUp;
  boolean makeJump;
  boolean isSetter, isPlayer;


  Player(PVector p, int pType, float h, float wX, float wZ, boolean s)
  {
    pos = new PVector (0, 0, 0);
    initialPos = new PVector (0, 0, 0);

    isSetter = s;
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
    hasCollided = true; // LUEGO CAMBIAR ESTO A FALSE
  }



  void jumpPlayer()
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

  void calcCollisionBall()
  {
    if (ballInGame && gamePhase == Phase.SERVE && ballCollided == 0)
    {
      if (puntoBola.y + ballSize >= -playerHeight)
      {
        if (puntoBola.x + ballSize >= pos.x - pWidthX && puntoBola.x - ballSize <= pos.x + pWidthX)
        {
          if (puntoBola.z + ballSize >= pos.z - pWidthZ && puntoBola.z - ballSize <= pos.z + pWidthZ)
          {
            if (playerType == 2)
            {
              ballInGame = false;

              calcNewRecievingPoint();

              makeJump = true;
              println("NICE RECIEEEEVE");
            } else if (playerType == 1)
            {
              ballCollided = 1;
              calcBlockCurve();
              u = 0;
            }
          }
        }
      }
    }
  }

  void calcNewRecievingPoint()
  {
    float auxPos = destinationPoint.x;
    if (isSetter)
    {
      spikerRecieve = true;
      destinationPoint.x = arrayPlayers[6].pos.x;
    }
    PVector [] pc;
    float distanceX, distanceZ;
    u = 0;

    distanceX = (destinationPoint.x - puntoBola.x);
    distanceX = sqrt(sq(distanceX));

    distanceZ = (destinationPoint.z - puntoBola.z);
    distanceZ = sqrt(sq(distanceZ));       

    pc = new PVector[4];
    pc[0] = new PVector(puntoBola.x, puntoBola.y, puntoBola.z);

    PVector secondPointAux = new PVector(0, 0, 0);
    if (puntoBola.x < -100)
      secondPointAux.x = puntoBola.x + (distanceX / 4);
    else
    {
      secondPointAux.x = puntoBola.x - (distanceX / 4);
    }
    secondPointAux.y = -reciviengHeight;
    secondPointAux.z = puntoBola.z - (distanceZ / 4);
    pc[1] = new PVector(secondPointAux.x, secondPointAux.y, secondPointAux.z);

    PVector thirdPointAux = new PVector(0, 0, 0);
    if (puntoBola.x < -100)
      thirdPointAux.x = puntoBola.x + ((3*distanceX) / 4);
    else
    {
      thirdPointAux.x = puntoBola.x - ((3*distanceX) / 4);
    }
    thirdPointAux.y = -reciviengHeight;
    thirdPointAux.z = puntoBola.z - ((3*distanceZ) / 4);
    pc[2] = new PVector(thirdPointAux.x, thirdPointAux.y, thirdPointAux.z);

    pc[3] = new PVector(destinationPoint.x, destinationPoint.y, destinationPoint.z);

    recieveCurve.modifyPoints(pc);
    destinationPoint.x = auxPos;
  }

  void drawPlayer()
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
