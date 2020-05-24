class InterpolCurve
{

  // ATRIBUTOS
  // NECESITARE: PUNTOS DE CONTROL, COEFICIENTES, COLORES
  // p(u) = C0 + C1 *u + C2 *u2 + C3 * u3  

  PVector [] puntoDeControl;
  PVector [] coeficiente;
  color colorCurva, colorPunto;

  // CONSTRUCTOR
  InterpolCurve(color c) // Los coeficientes se calculan despues con la matriz
  {
    // Inicializamos los puntos de control
    puntoDeControl = new PVector[4];
    puntoDeControl[0] = new PVector(0, 0, 0);
    puntoDeControl[1] = new PVector(0, 0, 0);
    puntoDeControl[2] = new PVector(0, 0, 0);
    puntoDeControl[3] = new PVector(0, 0, 0);

    coeficiente = new PVector[4];
    coeficiente[0] = new PVector(0, 0, 0);
    coeficiente[1] = new PVector(0, 0, 0);
    coeficiente[2] = new PVector(0, 0, 0);
    coeficiente[3] = new PVector(0, 0, 0);

    // Almacenamos el color
    colorCurva = c;
    // Calcular los coeficientes 
    // empleando la matriz de la curva de Interpolacion
  }

  void modifyPoints(PVector[] newP)
  {
    for (int i=0; i < 4; i++)
    {
      puntoDeControl[i].x = newP[i].x;
      puntoDeControl[i].y = newP[i].y;
      puntoDeControl[i].z = newP[i].z;
    }
    calculaCoefs();
  }



  // METODOS
  void calculaCoefs() // Solo se llama una vez y al principio, SI NO CAMBIAN LOS PUNTOS DE CNTRL CLARO
  {
    // EN INTERPOLACION, SI MULTIPLICAS LOS PUNTOS DE CONTROL POR LA MATRIZ
    // SALEN ESTAS ECUACIONES
    // C0 = P0
    // C1 = -5.5* P0 + 9 * P1 - 4.5* P2 + P3
    // C2 = 9*P0 - 22.5*P1 + 18* P2 - 4.5 * p3
    // C3 = -4.5*P0 + 13.5 *P1 - 13.5 * P2 + 4.5 * P3
    // hay que hacerlo 2 VECES

    // HACEMOS LAS X
    coeficiente[0].x = puntoDeControl[0].x; // C0
    coeficiente[1].x =- 5.5* puntoDeControl[0].x + 9 * puntoDeControl[1].x - 4.5* puntoDeControl[2].x + puntoDeControl[3].x; // C1
    coeficiente[2].x = 9 * puntoDeControl[0].x - 22.5 * puntoDeControl[1].x + 18* puntoDeControl[2].x - 4.5 * puntoDeControl[3].x; // C2
    coeficiente[3].x =- 4.5* puntoDeControl[0].x + 13.5 * puntoDeControl[1].x - 13.5* puntoDeControl[2].x + 4.5 * puntoDeControl[3].x; // C3
    // HACEMOS LAS Y
    coeficiente[0].y = puntoDeControl[0].y; // C0
    coeficiente[1].y =- 5.5* puntoDeControl[0].y + 9 * puntoDeControl[1].y - 4.5* puntoDeControl[2].y + puntoDeControl[3].y; // C1
    coeficiente[2].y = 9 * puntoDeControl[0].y - 22.5 * puntoDeControl[1].y + 18* puntoDeControl[2].y - 4.5 * puntoDeControl[3].y; // C2
    coeficiente[3].y =- 4.5* puntoDeControl[0].y + 13.5 * puntoDeControl[1].y - 13.5* puntoDeControl[2].y + 4.5 * puntoDeControl[3].y; // C3
    // HACEMOS LAS Z
    coeficiente[0].z = puntoDeControl[0].z; // C0
    coeficiente[1].z =- 5.5* puntoDeControl[0].z + 9 * puntoDeControl[1].z - 4.5* puntoDeControl[2].z + puntoDeControl[3].z; // C1
    coeficiente[2].z = 9 * puntoDeControl[0].z - 22.5 * puntoDeControl[1].z + 18* puntoDeControl[2].z - 4.5 * puntoDeControl[3].z; // C2
    coeficiente[3].z =- 4.5* puntoDeControl[0].z + 13.5 * puntoDeControl[1].z - 13.5* puntoDeControl[2].z + 4.5 * puntoDeControl[3].z; // C3
  }


  PVector calculameUnPunto(float u)
  {

    PVector puntoCalculado = new PVector(0, 0, 0);
    // Calculo un punto con la formula de la curva -> p(u) = C0 + C1 *u + C2 *u2 + C3 * u3
    // x(u) = C0x + C1x *u + C2x *u2 + C3x * u3 
    // y(u) = C0y + C1y *u + C2y *u2 + C3y * u3 
    puntoCalculado.x = coeficiente[0].x + coeficiente[1].x * u + coeficiente[2].x * u*u + coeficiente[3].x *u*u*u;
    puntoCalculado.y = coeficiente[0].y + coeficiente[1].y * u + coeficiente[2].y * u*u + coeficiente[3].y *u*u*u;
    puntoCalculado.z = coeficiente[0].z + coeficiente[1].z * u + coeficiente[2].z * u*u + coeficiente[3].z *u*u*u;

    return puntoCalculado;
  }

  void pintaCurva()  //SE LLAMA TODO EL RATO
  {
    if (!freeCam)
    {
      PVector punto = new PVector(0, 0, 0);
      // GRUESO DE LA CURVA
      strokeWeight(6);
      // Color de la curva
      stroke(colorCurva);
      // ITERAMOS POR LA CURVA PINTANDO LOS PUNTOS QUE QUERAMOS
      // DANDO VALORES AL PARAMETRO u DESDE 0 HASTA 1 EN INCREMENTOS DE ??
      // A MAYOR EL INCREMENTO, MAS PUNTOS PINTAREMOS
      // OJO, NO ESTAMOS HABLANDO DE LOS PUNTOS DE CONTROL, SINO DE LOS PUNTOS QUE FORMAN LA CURVA

      for (float u = 0; u < 1; u+=0.01)
      {
        punto = calculameUnPunto(u);
        // Lo pintos
        point(punto.x, punto.y, punto.z);
      }
    }
  }
}
