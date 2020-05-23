class curvaBezier {
  //ATRIBUTOS
  PVector[] puntosDeControl;
  PVector[] maxPosPoint;
  PVector[] minPosPoint;
  PVector[] initialPoint;
  PVector[] coeficientes;

  PVector lastMouseInput;
  float movingLimit;
  color colorCurva;
  color colorPuntosDeControl = color(255, 0, 255);
  float numeroDePuntosAPintar;
  //CONSTRUCTOR
  curvaBezier(PVector[] pc, color c, float num)
  {
    lastMouseInput = new PVector(0, 0, 0);
    //INICIALIZAMOS EL ARRAY DE PUNTOS 
    puntosDeControl = new PVector[4];
    maxPosPoint = new PVector[4];
    minPosPoint = new PVector[4];
    initialPoint = new PVector[4];

    //INICIALIZAMOS EL ARRAY DE CORFICIENTES
    coeficientes = new PVector[4];
    movingLimit = 250;
    // TENGO QUE DETERMINAR DE CUANTAS DIMENSIONES SON LOS PUNTOS

    // ME GUARDO LOS PUNTOS QUE ME HAN PASADO Y EL COLOR
    for (int i=0; i<4; i++) {
      //INICIALIZAR LAS POSICIONES DEL ARRAY DE PUNTOS DE CONTROL y coeficientes
      puntosDeControl[i] = new PVector(0, 0, 0);
      maxPosPoint[i] = new PVector(0, 0, 0);
      minPosPoint[i] = new PVector(0, 0, 0);
      initialPoint[i] = new PVector(0, 0, 0);

      coeficientes[i]= new PVector(0, 0, 0);

      // COPIAR LOS PUNTOS
      puntosDeControl[i].x = pc[i].x;
      puntosDeControl[i].y = pc[i].y;
      puntosDeControl[i].z = pc[i].z;
      
      initialPoint[i].x = puntosDeControl[i].x;
      initialPoint[i].y = puntosDeControl[i].y;
      initialPoint[i].z = puntosDeControl[i].z;
      
      
      //ALMACENAMOS EL RESTO
      colorCurva = c;

      numeroDePuntosAPintar = num;
    }
    rearrangeMaxMin();
    calculoCoefs();
  }
  
  void rearrangeMaxMin()
  {
    
       float firstLastDistance;
       
        maxPosPoint[1].x = courtSize.x / 2;
        maxPosPoint[1].y = initialPoint[1].y + movingLimit;

        minPosPoint[1].x = -courtSize.x / 2;
        minPosPoint[1].y = initialPoint[1].y - movingLimit;
     
    
         maxPosPoint[2].x = puntosDeControl[1].x + movingLimit;
         minPosPoint[2].x = puntosDeControl[1].x - movingLimit; 
         
         
         maxPosPoint[2].y = puntosDeControl[1].y + movingLimit;
         minPosPoint[2].y = puntosDeControl[1].y - movingLimit; 
     
        maxPosPoint[3].x = puntosDeControl[2].x;
        maxPosPoint[3].z = courtPos.z + (courtSize.z/2);
        //maxPosPoint[3].y = puntosDeControl[2].y + 100;
        maxPosPoint[3].y =  -70;
        
        minPosPoint[3].x = puntosDeControl[2].x;
        minPosPoint[3].z = courtPos.z;
      //  minPosPoint[3].y = puntosDeControl[2].y + 100;
        minPosPoint[3].y = -70;
        
        firstLastDistance = (puntosDeControl[3].z - puntosDeControl[0].z);
        firstLastDistance = sqrt(sq(firstLastDistance));
        puntosDeControl[1].z = puntosDeControl[0].z + (firstLastDistance/ 4);
        puntosDeControl[2].z = puntosDeControl[0].z + ((3* firstLastDistance) / 4);    
        
        maxPosPoint[1].z =puntosDeControl[1].z;
        
        minPosPoint[2].z = puntosDeControl[2].z;
         maxPosPoint[2].z =puntosDeControl[2].z;
        
        minPosPoint[1].z = puntosDeControl[1].z;
     
      
  }
  //METODOS
  void calculoCoefs()
  {
    coeficientes[0].x = puntosDeControl[0].x;
    coeficientes[0].y = puntosDeControl[0].y;
    coeficientes[0].z = puntosDeControl[0].z;

    coeficientes[1].x = -3*puntosDeControl[0].x + 3 * puntosDeControl[1].x;
    coeficientes[1].y = -3*puntosDeControl[0].y + 3 * puntosDeControl[1].y;
    coeficientes[1].z = -3*puntosDeControl[0].z + 3 * puntosDeControl[1].z;

    coeficientes[2].x = 3*puntosDeControl[0].x -6 * puntosDeControl[1].x + 3 * puntosDeControl[2].x;
    coeficientes[2].y = 3*puntosDeControl[0].y -6 * puntosDeControl[1].y + 3 * puntosDeControl[2].y;
    coeficientes[2].z = 3*puntosDeControl[0].z -6 * puntosDeControl[1].z + 3 * puntosDeControl[2].z;

    coeficientes[3].x = -1*puntosDeControl[0].x +3 * puntosDeControl[1].x - 3 * puntosDeControl[2].x + puntosDeControl[3].x;
    coeficientes[3].y = -1*puntosDeControl[0].y +3 * puntosDeControl[1].y - 3 * puntosDeControl[2].y + puntosDeControl[3].y;
    coeficientes[3].z = -1*puntosDeControl[0].z +3 * puntosDeControl[1].z - 3 * puntosDeControl[2].z + puntosDeControl[3].z;
  }

  void moveControlPointsMouse(PVector mousePosition, int point)
  {
    float[] camPos = cam.getPosition();  // x, y, and z coordinates of camera in model space
    //  float[] camRot = cam.getRotations(); // x, y, and z rotations required to face camera in model spac
    float moduleMovementVec;
    int reverseDirectionZ = 1;
    int reverseDirectionX = 1;
    // PVector cameraPosition = new PVector(0, 0, 0);
    //PVector camaraAPunto = new PVector(0, 0, 0);
    PVector movimientoPunto = new PVector(0, 0, 0);
    // PVector aDondeIr = new PVector(0, 0, 0);
    /*
    cameraPosition.x = camPos[0]; 
     cameraPosition.y = camPos[1];  
     cameraPosition.z = camPos[2];  
     */
    //  camaraAPunto = calculateVector(cameraPosition, puntosDeControl[point]);

    if (puntosDeControl[point].z < camPos[2])
    {
      reverseDirectionZ = -1;
    }
    if (puntosDeControl[point].x < camPos[0])
    {
      reverseDirectionX = -1;
    }

    movimientoPunto = calculateVector(mousePosition, lastMouseInput);

    //movimientoPunto = calculateUnitVector(mousePosition,lastMouseInput);
    moduleMovementVec = calculateModuleVector(movimientoPunto);

    if (moduleMovementVec == 0)
    {
    } else
    {
      if (point != 3)
      {

        puntosDeControl[point].x += movimientoPunto.x * reverseDirectionZ;
        puntosDeControl[point].y -= movimientoPunto.y;
        puntosDeControl[point].z = puntosDeControl[point].z;
      } else
      {
       // puntosDeControl[point].x = puntosDeControl[point].x;
       //// puntosDeControl[point].y = puntosDeControl[point].y;
        puntosDeControl[3].z += movimientoPunto.y  * reverseDirectionX;
      }
      
      rearrangePoints();
      calculoCoefs();
      lastMouseInput.x = mousePosition.x;
      lastMouseInput.y = mousePosition.y;
    }
  }


  PVector calculameUnPunto(float u)
  {
    PVector puntoCalculado = new PVector(0, 0, 0);
    // LO CALCULO SEGUND LA EQUACION DE LA CURVA
    // P(u) = C0 + C1*u + C2*u2 + C3*u3

    puntoCalculado.x = coeficientes[0].x + coeficientes[1].x * u + coeficientes[2].x *u*u + coeficientes[3].x *u*u*u;
    puntoCalculado.y = coeficientes[0].y + coeficientes[1].y * u + coeficientes[2].y *u*u + coeficientes[3].y *u*u*u;
    puntoCalculado.z = coeficientes[0].z + coeficientes[1].z * u + coeficientes[2].z *u*u + coeficientes[3].z *u*u*u;
    
    return puntoCalculado;
  }
  
  void rearrangePoints()
  {
    
     rearrangeMaxMin();
    
    for(int point = 1; point < 4; point++)
    {
      if (puntosDeControl[point].x > maxPosPoint[point].x)
      {
        puntosDeControl[point].x =  maxPosPoint[point].x;
      } else if (puntosDeControl[point].x < minPosPoint[point].x)
      {
        puntosDeControl[point].x =  minPosPoint[point].x;
      }
      if (puntosDeControl[point].y > maxPosPoint[point].y)
      {
        puntosDeControl[point].y =  maxPosPoint[point].y;
      } else if (puntosDeControl[point].y < minPosPoint[point].y)
      {
        puntosDeControl[point].y =  minPosPoint[point].y;
      }
      if (puntosDeControl[point].z > maxPosPoint[point].z)
      {
        puntosDeControl[point].z =  maxPosPoint[point].z;
      } else if (puntosDeControl[point].z < minPosPoint[point].z)
      {
        puntosDeControl[point].z =  minPosPoint[point].z;
      }
    }
  }

  void pintarCurva()
  {

    // strokeWeight(1);
    // fill(205, 255, 255, 0);
   
    fill(200, 0, 0, 50); // semi-transparent
    stroke(10);
/*
    pushMatrix();

    switch(selectedPoint)
    {
    case DIRECCION:
      translate(courtPos.x, -123, puntosDeControl[1].z);
      box(courtSize.x, movingLimit * 2, -1);
      break;
    case EFECTO:
      translate(courtPos.x, puntosDeControl[1].y, puntosDeControl[2].z);
      box(movingLimit*2, movingLimit*2, -1);
      break;
    case POTENCIA:
      translate(initialPoint[3].x, initialPoint[3].y, initialPoint[3].z);
      box(movingLimit*2, 1, movingLimit*2);
      break;
    default:

      break;
    }
    
    popMatrix();
*/
    boolean curveInGame = true;
    fill(0, 255);
    //NECESITO UN PUNTO
    PVector punto = new PVector(0, 0, 0);
    stroke(colorPuntosDeControl);
    strokeWeight(5);
    for (int i= 0; i < 4; i++)
    {
      punto = puntosDeControl[i];
     
      pushMatrix();
      translate(punto.x, punto.y, punto.z);
      point(0, 0, 0);
      stroke(255, 0, 0);
      line(0, 0, 0, 100, 0, 0);
      stroke(0, 255, 0);
      line(0, 0, 0, 0, -100, 0);
      stroke(0, 0, 255);
      line(0, 0, 0, 0, 0, 100);
      popMatrix();
     
       
    }
    
    // Defino como pintar
    stroke(colorCurva);
    //ME desplazo por la curva desde u = 0 hasta u igual a 1
    float incrementoU = 1.0 / numeroDePuntosAPintar;
    for (float u= 0; u<= 4 && curveInGame; u += incrementoU)
    {
      punto = calculameUnPunto(u); 
      //punto.z < 220 && punto.z > -220 &&
      if( punto.z < 20 && punto.z > -20 && punto.y >= -antenaHeight)
      {
        stroke(0,0,255);
      }
      if(punto.y >= 0)
      {
          //curveInGame=false;
          stroke(255,0,0);
      }
      point(punto.x, punto.y, punto.z);
    }
   
  }
}
