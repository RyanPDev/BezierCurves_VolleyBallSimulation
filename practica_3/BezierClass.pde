class BezierCurve {
  //ATRIBUTOS
  PVector[] bezierControlPoints;
  PVector[] maxPosPoint;
  PVector[] minPosPoint;
  PVector[] initialPoint;
  PVector[] bezierCoefficients;

  PVector lastMouseInput;
  float movingLimit;
  color bezierColorCurve;
  color bezierControlPointsColor = color(255, 0, 255);
  float numOfBezierPointsToDraw;
  //CONSTRUCTOR
  BezierCurve(PVector[] pc, color c, float num)
  {
    lastMouseInput = new PVector(0, 0, 0);
    bezierControlPoints = new PVector[4];
    maxPosPoint = new PVector[4];
    minPosPoint = new PVector[4];
    initialPoint = new PVector[4];

    //INICIALIZAMOS EL ARRAY DE CORFICIENTES
    
    bezierCoefficients = new PVector[4];
    movingLimit = 250;
    
    // TENGO QUE DETERMINAR DE CUANTAS DIMENSIONES SON LOS PUNTOS

    // ME GUARDO LOS PUNTOS QUE ME HAN PASADO Y EL COLOR
    
    for (int i=0; i<4; i++) 
    {
      //INICIALIZAR LAS POSICIONES DEL ARRAY DE PUNTOS DE CONTROL y coeficientes
      bezierControlPoints[i] = new PVector(0, 0, 0);
      maxPosPoint[i] = new PVector(0, 0, 0);
      minPosPoint[i] = new PVector(0, 0, 0);
      initialPoint[i] = new PVector(0, 0, 0);

      bezierCoefficients[i]= new PVector(0, 0, 0);

      // COPIAR LOS PUNTOS
      bezierControlPoints[i].x = pc[i].x;
      bezierControlPoints[i].y = pc[i].y;
      bezierControlPoints[i].z = pc[i].z;

      initialPoint[i].x = bezierControlPoints[i].x;
      initialPoint[i].y = bezierControlPoints[i].y;
      initialPoint[i].z = bezierControlPoints[i].z;


      //ALMACENAMOS EL RESTO
      bezierColorCurve = c;

      numOfBezierPointsToDraw = num;
    }
    rearrangeMaxMin();
    calcBezierCoeffs();
  }

  void rearrangeMaxMin() // Recalcula los maximos y minimos que pueden ir los puntos de la bezier en base a la posicion del punto anterior (esto es para hacer que todas las possibles curvas respeten las leyes de la fisica)
  {

    float firstLastDistance;

    maxPosPoint[1].x = courtSize.x / 2;
    maxPosPoint[1].y = initialPoint[1].y + movingLimit;

    minPosPoint[1].x = -courtSize.x / 2;
    minPosPoint[1].y = initialPoint[1].y - movingLimit;


    maxPosPoint[2].x = bezierControlPoints[1].x + movingLimit - 220;
    minPosPoint[2].x = bezierControlPoints[1].x - movingLimit; 


    maxPosPoint[2].y = bezierControlPoints[1].y + movingLimit;
    minPosPoint[2].y = bezierControlPoints[1].y - movingLimit; 
    if (minPosPoint[2].y > -75)
    {
      minPosPoint[2].y = -75;
    }
    maxPosPoint[3].x = bezierControlPoints[2].x;
    maxPosPoint[3].z = courtPos.z + (courtSize.z/2);
    maxPosPoint[3].y =  -70;

    minPosPoint[3].x = bezierControlPoints[2].x;
    minPosPoint[3].z = courtPos.z;
    minPosPoint[3].y = -70;

    firstLastDistance = (bezierControlPoints[3].z - bezierControlPoints[0].z);
    firstLastDistance = sqrt(sq(firstLastDistance));
    
    bezierControlPoints[1].z = bezierControlPoints[0].z + (firstLastDistance/ 4);
    bezierControlPoints[2].z = bezierControlPoints[0].z + ((3* firstLastDistance) / 4);    

    maxPosPoint[1].z =bezierControlPoints[1].z;
    minPosPoint[1].z = bezierControlPoints[1].z;
    maxPosPoint[2].z =bezierControlPoints[2].z;
    minPosPoint[2].z = bezierControlPoints[2].z;
    
  }
  //METODOS
  void calcBezierCoeffs() // Recalcula los coeficientes de la bezier en base a los puntos que tiene
  {
    bezierCoefficients[0].x = bezierControlPoints[0].x;
    bezierCoefficients[0].y = bezierControlPoints[0].y;
    bezierCoefficients[0].z = bezierControlPoints[0].z;

    bezierCoefficients[1].x = -3*bezierControlPoints[0].x + 3 * bezierControlPoints[1].x;
    bezierCoefficients[1].y = -3*bezierControlPoints[0].y + 3 * bezierControlPoints[1].y;
    bezierCoefficients[1].z = -3*bezierControlPoints[0].z + 3 * bezierControlPoints[1].z;

    bezierCoefficients[2].x = 3*bezierControlPoints[0].x -6 * bezierControlPoints[1].x + 3 * bezierControlPoints[2].x;
    bezierCoefficients[2].y = 3*bezierControlPoints[0].y -6 * bezierControlPoints[1].y + 3 * bezierControlPoints[2].y;
    bezierCoefficients[2].z = 3*bezierControlPoints[0].z -6 * bezierControlPoints[1].z + 3 * bezierControlPoints[2].z;

    bezierCoefficients[3].x = -1*bezierControlPoints[0].x +3 * bezierControlPoints[1].x - 3 * bezierControlPoints[2].x + bezierControlPoints[3].x;
    bezierCoefficients[3].y = -1*bezierControlPoints[0].y +3 * bezierControlPoints[1].y - 3 * bezierControlPoints[2].y + bezierControlPoints[3].y;
    bezierCoefficients[3].z = -1*bezierControlPoints[0].z +3 * bezierControlPoints[1].z - 3 * bezierControlPoints[2].z + bezierControlPoints[3].z;
  }

  void moveControlPointsMouse(PVector mousePosition, int point) // Mueve un punto determinado de la bezier en base al movimiento de ratón
  {
    
    float moduleMovementVec;
    
    PVector pointMovement = new PVector(0, 0, 0);
   
    pointMovement = calculateVector(mousePosition, lastMouseInput);
    moduleMovementVec = calculateModuleVector(pointMovement);

    if (moduleMovementVec == 0)
    {
    } else
    {
      if (point != 3)
      {
        bezierControlPoints[point].x += pointMovement.x;
        bezierControlPoints[point].y -= pointMovement.y;
        bezierControlPoints[point].z = bezierControlPoints[point].z;
      } else
      {
       
        bezierControlPoints[3].z += pointMovement.y ;
      }

      rearrangePoints();
      calcBezierCoeffs();
      lastMouseInput.x = mousePosition.x;
      lastMouseInput.y = mousePosition.y;
    }
    
          // Codigo deshechado possiblemente util para un futuro (Ignorar)
     /*
    float[] camPos = cam.getPosition();  // x, y, and z coordinates of camera in model space
    //  float[] camRot = cam.getRotations(); // x, y, and z rotations required to face camera in model spac
    int reverseDirectionZ = -1;
    int reverseDirectionX = -1;
    // PVector cameraPosition = new PVector(0, 0, 0);
    //PVector camaraAPunto = new PVector(0, 0, 0);
    // PVector aDondeIr = new PVector(0, 0, 0);
    
    cameraPosition.x = camPos[0]; 
     cameraPosition.y = camPos[1];  
     cameraPosition.z = camPos[2];  
     
     camaraAPunto = calculateVector(cameraPosition, puntosDeControl[point]);

     if (puntosDeControl[point].z < camPos[2])
     {
     reverseDirectionZ = -1;
     }
     if (puntosDeControl[point].x < camPos[0])
     {
     reverseDirectionX = -1;
     }
      //movimientoPunto = calculateUnitVector(mousePosition,lastMouseInput);
       // puntosDeControl[point].x = puntosDeControl[point].x;
        //// puntosDeControl[point].y = puntosDeControl[point].y;
     */
  }


  PVector calculatePointBezier(float u) // Calcula un punto en el espacio usando los coeficientes de la bezier
  {
    PVector calculatedBezierPoint = new PVector(0, 0, 0);
    // LO CALCULO SEGUND LA EQUACION DE LA CURVA
    // P(u) = C0 + C1*u + C2*u2 + C3*u3

    calculatedBezierPoint.x = bezierCoefficients[0].x + bezierCoefficients[1].x * u + bezierCoefficients[2].x *u*u + bezierCoefficients[3].x *u*u*u;
    calculatedBezierPoint.y = bezierCoefficients[0].y + bezierCoefficients[1].y * u + bezierCoefficients[2].y *u*u + bezierCoefficients[3].y *u*u*u;
    calculatedBezierPoint.z = bezierCoefficients[0].z + bezierCoefficients[1].z * u + bezierCoefficients[2].z *u*u + bezierCoefficients[3].z *u*u*u;

    return calculatedBezierPoint;
  }

  void rearrangePoints() // Recoloca los puntos de la bezier en base a sus minimos i maximos ( para evitar que la bola desafie las leyes de la fisica
  {

    rearrangeMaxMin();

    for (int point = 1; point < 4; point++)
    {
      if (bezierControlPoints[point].x > maxPosPoint[point].x)
      {
        bezierControlPoints[point].x =  maxPosPoint[point].x;
      } else if (bezierControlPoints[point].x < minPosPoint[point].x)
      {
        bezierControlPoints[point].x =  minPosPoint[point].x;
      }
      if (bezierControlPoints[point].y > maxPosPoint[point].y)
      {
        bezierControlPoints[point].y =  maxPosPoint[point].y;
      } else if (bezierControlPoints[point].y < minPosPoint[point].y)
      {
        bezierControlPoints[point].y =  minPosPoint[point].y;
      }
      if (bezierControlPoints[point].z > maxPosPoint[point].z)
      {
        bezierControlPoints[point].z =  maxPosPoint[point].z;
      } else if (bezierControlPoints[point].z < minPosPoint[point].z)
      {
        bezierControlPoints[point].z =  minPosPoint[point].z;
      }
    }
  }

  void drawBezierCurve() // Dibuja la bezier mediante una serie de puntos en el espacio, tambien dibuja el punto que el juegador está modificando en estos momentos
  {

    if (!freeCam)
    {
      fill(200, 0, 0, 50); // semi-transparent
      stroke(10);

      boolean curveInGame = true;
      fill(0, 255);
      //NECESITO UN PUNTO
      PVector auxPoint = new PVector(0, 0, 0);
      stroke(bezierControlPointsColor);
      strokeWeight(5);
      int i,pX,pY,pZ;
      pX = 0;
      i = 0;
      pY = 0;
      pZ = 0;
      color auxColor = color(0);
      switch(selectedPoint)
      {
         case DIRECCION:
           i = 1;
           pX = 100;
           pY = 100;
           pZ = 0;
           auxColor = color(0, 100, 0);
           break;
         case EFECTO:
           i = 2;
           pX = 100;
           pY = 100;
           pZ = 0;
           auxColor = color(0, 0, 100);
           break;
         case POTENCIA:
           i = 3;
           pX = 100;
           pY = 0;
           pZ = 100;
           auxColor = color(100, 0, 0);
           break;
         default:
           break;
      }
        pushMatrix();
        auxPoint = bezierControlPoints[i];
        translate(auxPoint.x, auxPoint.y, auxPoint.z);
        
        int distanceForMark = 20;
        stroke(auxColor);
        point(0, 0, 0);
        
        line(distanceForMark, 0, 0, pX, 0, 0);
        line(-distanceForMark, 0, 0, -pX, 0, 0);
        line(0, -distanceForMark, 0, 0, -pY, 0);
        line(0, distanceForMark, 0, 0, pY, 0);
        line(0, 0, distanceForMark, 0, 0, pZ);
        line(0, 0, -distanceForMark, 0, 0, -pZ);
        popMatrix();
     
      // Defino como pintar
      stroke(bezierColorCurve);
      //ME desplazo por la curva desde u = 0 hasta u igual a 1
      float incrementoU = 1.0 / numOfBezierPointsToDraw;
      for (float u= 0; u<= 4 && curveInGame; u += incrementoU)
      {
        auxPoint = calculatePointBezier(u); 
        //punto.z < 220 && punto.z > -220 &&
        if ( auxPoint.z < 20 && auxPoint.z > -20 && auxPoint.y >= -antenaHeight)
        {
          stroke(0, 0, 255);
        }
        if (auxPoint.y >= 0)
        {
          //curveInGame=false;
          stroke(255, 0, 0);
        }
        point(auxPoint.x, auxPoint.y, auxPoint.z);
      }
    }
  }
}
