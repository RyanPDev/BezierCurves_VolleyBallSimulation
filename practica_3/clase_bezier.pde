class curvaBezier {
  //ATRIBUTOS
  PVector[] puntosDeControl;
  PVector[] coeficientes;
  color colorCurva;
  color colorPuntosDeControl = color(255, 0, 255);
  float numeroDePuntosAPintar;
  //CONSTRUCTOR
  curvaBezier(PVector[] pc, color c, float num)
  {

    //INICIALIZAMOS EL ARRAY DE PUNTOS 
    puntosDeControl = new PVector[4];
    //INICIALIZAMOS EL ARRAY DE CORFICIENTES
    coeficientes = new PVector[4];
    // TENGO QUE DETERMINAR DE CUANTAS DIMENSIONES SON LOS PUNTOS

    // ME GUARDO LOS PUNTOS QUE ME HAN PASADO Y EL COLOR
    for (int i=0; i<4; i++) {
      //INICIALIZAR LAS POSICIONES DEL ARRAY DE PUNTOS DE CONTROL y coeficientes
      puntosDeControl[i]= new PVector(0, 0);

      coeficientes[i]= new PVector(0, 0);

      // COPIAR LOS PUNTOS
      puntosDeControl[i] = pc[i];

      //ALMACENAMOS EL RESTO
      colorCurva = c;

      numeroDePuntosAPintar = num;
    }
    calculoCoefs();
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

  void moveControlPoints(PVector mousePosition)
  {

    int closestPoint = 0;
    float closestDistance = 100000;

    for (int i= 0; i < 4; i++)
    {
      float currentDistanceAux = sq(mousePosition.x - puntosDeControl[i].x) + sq(mousePosition.y - puntosDeControl[i].y) + sq(mousePosition.z - puntosDeControl[i].z);
      if (currentDistanceAux != 0)
      {
        float currentDistance = sqrt(currentDistanceAux);
        if (currentDistance < closestDistance)
        {
          closestDistance = currentDistance;
          closestPoint = i;
        }
      } else
      {
        closestPoint = i;
        closestDistance = 0;
      }
    }
    if (closestDistance <= 5)
    {
      puntosDeControl[closestPoint].x = mousePosition.x;
      puntosDeControl[closestPoint].y = mousePosition.y;
      puntosDeControl[closestPoint].z = mousePosition.z;
      calculoCoefs();
    }
  }

  PVector calculameUnPunto(float u)
  {
    PVector puntoCalculado = new PVector(0, 0);
    // LO CALCULO SEGUND LA EQUACION DE LA CURVA
    // P(u) = C0 + C1*u + C2*u2 + C3*u3

    puntoCalculado.x = coeficientes[0].x + coeficientes[1].x * u + coeficientes[2].x *u*u + coeficientes[3].x *u*u*u;
    puntoCalculado.y = coeficientes[0].y + coeficientes[1].y * u + coeficientes[2].y *u*u + coeficientes[3].y *u*u*u;
    puntoCalculado.z = coeficientes[0].z + coeficientes[1].z * u + coeficientes[2].z *u*u + coeficientes[3].z *u*u*u;
    return puntoCalculado;
  }

  void pintarCurva()
  {
    //NECESITO UN PUNTO
    PVector punto = new PVector(0, 0);
    stroke(colorPuntosDeControl);
    strokeWeight(5);
    for (int i= 0; i < 4; i++)
    {
      punto = puntosDeControl[i];

      point(punto.x, punto.y, punto.z);
    }

    // Defino como pintar
    stroke(colorCurva);
    //ME desplazo por la curva desde u = 0 hasta u igual a 1
    float incrementoU = 1.0 / numeroDePuntosAPintar;
    for (float u= 0; u<= 1; u += incrementoU)
    {
      punto = calculameUnPunto(u); 
      point(punto.x, punto.y, punto.z);
    }
  }
}
