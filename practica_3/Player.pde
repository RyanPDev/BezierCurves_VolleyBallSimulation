class Player
{
   PVector pos,initialPos, vel;
   color playerColor;
   int playerType;
   float pHeight, pWidthX,pWidthZ;
   boolean hasCollided;
   
  
   Player(PVector p, int pType, float h, float wX, float wZ)
   {
     pos = new PVector (0,0,0);
     initialPos = new PVector (0,0,0);
     
     pos = p;
     initialPos = p;
     
     playerType = pType;
     switch(playerType)
     {
        case 0:
          playerColor = color(0,255,127);
          break;
        case 1:
          playerColor = color(32,178,170);
          break;  
        case 2:
          playerColor = color(220,38,38);
          break;
     }
     
     pHeight = h;
     pWidthX = wX;
     pWidthZ = wZ;
     hasCollided = true; // LUEGO CAMBIAR ESTO A FALSE
     
   }
   
   
   
   void movePlayer()
   {
     
   }
   
   void calcCollisionBall()
   {
       if(playerType == 2 && ballInGame && gamePhase == Phase.SERVE && ballCollided == 0)
       {
         if(puntoBola.y + ballSize >= -playerHeight)
         {
           if(puntoBola.x + ballSize >= pos.x - pWidthX && puntoBola.x - ballSize <= pos.x + pWidthX)
           {
              if(puntoBola.z + ballSize >= pos.z - pWidthZ && puntoBola.z - ballSize <= pos.z + pWidthZ)
              {
                ballInGame = false;
                calcNewRecievingPoint();
                println("NICE RECIEEEEVE");
              }
           }
         }
       }
   }
   
   void calcNewRecievingPoint()
   {
       PVector [] pc;
       float distanceX,distanceZ;
       u = 0;
       
       distanceX = (destinationPoint.x - puntoBola.x);
       distanceX = sqrt(sq(distanceX));
       
       distanceZ = (destinationPoint.z - puntoBola.z);
       distanceZ = sqrt(sq(distanceZ));       
       
       pc = new PVector[4];
       pc[0] = new PVector(puntoBola.x,puntoBola.y,puntoBola.z);
       
       PVector secondPointAux = new PVector(0,0,0);
       secondPointAux.x = puntoBola.x + (distanceX / 4);
       secondPointAux.y = -reciviengHeight;
       secondPointAux.z = puntoBola.z - (distanceZ / 4);
       pc[1] = new PVector(secondPointAux.x,secondPointAux.y,secondPointAux.z);
       
       PVector thirdPointAux = new PVector(0,0,0);
       thirdPointAux.x = puntoBola.x + ((3*distanceX) / 4);
       thirdPointAux.y = -reciviengHeight;
       thirdPointAux.z = puntoBola.z - ((3*distanceZ) / 4);
       pc[2] = new PVector(thirdPointAux.x,thirdPointAux.y,thirdPointAux.z);
       
       pc[3] = new PVector(destinationPoint.x,destinationPoint.y,destinationPoint.z);
       
       recieveCurve.modifyPoints(pc);
     
   }
   
   void drawPlayer()
   {
       pushMatrix();
       translate(pos.x,pos.y,pos.z);
       fill(playerColor);
       stroke(255);
       strokeWeight(2);
       
       box(pWidthX,pHeight,pWidthZ);
       
       popMatrix();
   }
  
}
