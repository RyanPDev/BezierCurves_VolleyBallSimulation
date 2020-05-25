class InterpolCurve
{

  // ATRIBUTOS
  // NECESITARE: PUNTOS DE CONTROL, COEFICIENTES, COLORES
  // p(u) = C0 + C1 *u + C2 *u2 + C3 * u3  

  PVector [] interpolationControlPoints;
  PVector [] interpolationCoefficients;
  color colorCurve, colorInterpolPoint;

  // CONSTRUCTOR
  InterpolCurve(color c) // Los coeficientes se calculan despues con la matriz
  {
    // Inicializamos los puntos de control
    interpolationControlPoints = new PVector[4];
    interpolationControlPoints[0] = new PVector(0, 0, 0);
    interpolationControlPoints[1] = new PVector(0, 0, 0);
    interpolationControlPoints[2] = new PVector(0, 0, 0);
    interpolationControlPoints[3] = new PVector(0, 0, 0);

    interpolationCoefficients = new PVector[4];
    interpolationCoefficients[0] = new PVector(0, 0, 0);
    interpolationCoefficients[1] = new PVector(0, 0, 0);
    interpolationCoefficients[2] = new PVector(0, 0, 0);
    interpolationCoefficients[3] = new PVector(0, 0, 0);

    // Almacenamos el color
    colorCurve = c;
    // Calcular los coeficientes 
    // empleando la matriz de la curva de Interpolacion
  }

  void modifyPoints(PVector[] newP) // Modifica los puntos de la curva de interpolacion a los parametros pasados, y luego recalcula los coeficientes
  {
    for (int i=0; i < 4; i++)
    {
      interpolationControlPoints[i].x = newP[i].x;
      interpolationControlPoints[i].y = newP[i].y;
      interpolationControlPoints[i].z = newP[i].z;
    }
    calculateInterpoleCoefficients();
  }



  // METODOS
  void calculateInterpoleCoefficients() // Solo se llama una vez y al principio, SI NO CAMBIAN LOS PUNTOS DE CNTRL CLARO
  {
    // EN INTERPOLACION, SI MULTIPLICAS LOS PUNTOS DE CONTROL POR LA MATRIZ
    // SALEN ESTAS ECUACIONES
    // C0 = P0
    // C1 = -5.5* P0 + 9 * P1 - 4.5* P2 + P3
    // C2 = 9*P0 - 22.5*P1 + 18* P2 - 4.5 * p3
    // C3 = -4.5*P0 + 13.5 *P1 - 13.5 * P2 + 4.5 * P3
    // hay que hacerlo 2 VECES

    // HACEMOS LAS X
    interpolationCoefficients[0].x = interpolationControlPoints[0].x; // C0
    interpolationCoefficients[1].x =- 5.5* interpolationControlPoints[0].x + 9 * interpolationControlPoints[1].x - 4.5* interpolationControlPoints[2].x + interpolationControlPoints[3].x; // C1
    interpolationCoefficients[2].x = 9 * interpolationControlPoints[0].x - 22.5 * interpolationControlPoints[1].x + 18* interpolationControlPoints[2].x - 4.5 * interpolationControlPoints[3].x; // C2
    interpolationCoefficients[3].x =- 4.5* interpolationControlPoints[0].x + 13.5 * interpolationControlPoints[1].x - 13.5* interpolationControlPoints[2].x + 4.5 * interpolationControlPoints[3].x; // C3
    // HACEMOS LAS Y
    interpolationCoefficients[0].y = interpolationControlPoints[0].y; // C0
    interpolationCoefficients[1].y =- 5.5* interpolationControlPoints[0].y + 9 * interpolationControlPoints[1].y - 4.5* interpolationControlPoints[2].y + interpolationControlPoints[3].y; // C1
    interpolationCoefficients[2].y = 9 * interpolationControlPoints[0].y - 22.5 * interpolationControlPoints[1].y + 18* interpolationControlPoints[2].y - 4.5 * interpolationControlPoints[3].y; // C2
    interpolationCoefficients[3].y =- 4.5* interpolationControlPoints[0].y + 13.5 * interpolationControlPoints[1].y - 13.5* interpolationControlPoints[2].y + 4.5 * interpolationControlPoints[3].y; // C3
    // HACEMOS LAS Z
    interpolationCoefficients[0].z = interpolationControlPoints[0].z; // C0
    interpolationCoefficients[1].z =- 5.5* interpolationControlPoints[0].z + 9 * interpolationControlPoints[1].z - 4.5* interpolationControlPoints[2].z + interpolationControlPoints[3].z; // C1
    interpolationCoefficients[2].z = 9 * interpolationControlPoints[0].z - 22.5 * interpolationControlPoints[1].z + 18* interpolationControlPoints[2].z - 4.5 * interpolationControlPoints[3].z; // C2
    interpolationCoefficients[3].z =- 4.5* interpolationControlPoints[0].z + 13.5 * interpolationControlPoints[1].z - 13.5* interpolationControlPoints[2].z + 4.5 * interpolationControlPoints[3].z; // C3
  }


  PVector calculateInterpolPoint(float u) // Calcula un punto en el espacio teniendo en cuenta los coeficientes y la variable u usando un sistema de equaciones lineal
  {

    PVector interpolCalculatedPoint = new PVector(0, 0, 0);
    // Calculo un punto con la formula de la curva -> p(u) = C0 + C1 *u + C2 *u2 + C3 * u3
    // x(u) = C0x + C1x *u + C2x *u2 + C3x * u3 
    // y(u) = C0y + C1y *u + C2y *u2 + C3y * u3 
    // z(u) = C0z + C1z *u + C2z *u2 + C3z * u3 
    interpolCalculatedPoint.x = interpolationCoefficients[0].x + interpolationCoefficients[1].x * u + interpolationCoefficients[2].x * u*u + interpolationCoefficients[3].x *u*u*u;
    interpolCalculatedPoint.y = interpolationCoefficients[0].y + interpolationCoefficients[1].y * u + interpolationCoefficients[2].y * u*u + interpolationCoefficients[3].y *u*u*u;
    interpolCalculatedPoint.z = interpolationCoefficients[0].z + interpolationCoefficients[1].z * u + interpolationCoefficients[2].z * u*u + interpolationCoefficients[3].z *u*u*u;

    return interpolCalculatedPoint;
  }

  void drawInterpolationCurve()  // Pinta la cuva mediante puntos
  {
    if (!freeCam)
    {
      PVector drawingPointInterpol = new PVector(0, 0, 0);
      // GRUESO DE LA CURVA
      strokeWeight(6);
      // Color de la curva
      stroke(colorCurve);
      // ITERAMOS POR LA CURVA PINTANDO LOS PUNTOS QUE QUERAMOS
      // DANDO VALORES AL PARAMETRO u DESDE 0 HASTA 1 EN INCREMENTOS DE 0.01
      // A MAYOR EL INCREMENTO, MAS PUNTOS PINTAREMOS
     
      for (float u = 0; u < 1; u+=0.01)
      {
        drawingPointInterpol = calculateInterpolPoint(u);
        // Lo pintos
        point(drawingPointInterpol.x, drawingPointInterpol.y, drawingPointInterpol.z);
      }
    }
  }
}
