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

void calcSpikeCurve()
{
  PVector [] ps;
  float distanceX, distanceZ, distanceY;

  distanceX = (destinationSpike.x - puntoBola.x);
  distanceX = sqrt(sq(distanceX));

  distanceY = (destinationSpike.y - puntoBola.y);
  distanceX = sqrt(sq(distanceX));

  distanceZ = (destinationSpike.z - puntoBola.z);
  distanceZ = sqrt(sq(distanceZ));       

  ps = new PVector[4];
  ps[0] = new PVector(puntoBola.x, puntoBola.y, puntoBola.z);

  PVector secondPointAux = new PVector(0, 0, 0);
  secondPointAux.x = puntoBola.x - (distanceX / 4);
  secondPointAux.y = puntoBola.y + (distanceY / 4);
  secondPointAux.z = puntoBola.z - (distanceZ / 4);
  ps[1] = new PVector(secondPointAux.x, secondPointAux.y, secondPointAux.z);

  PVector thirdPointAux = new PVector(0, 0, 0);
  thirdPointAux.x = puntoBola.x - ((3*distanceX) / 4);
  thirdPointAux.y = puntoBola.y + ((3*distanceY) / 4);
  thirdPointAux.z = puntoBola.z - ((3*distanceZ) / 4);
  ps[2] = new PVector(thirdPointAux.x, thirdPointAux.y, thirdPointAux.z);

  ps[3] = new PVector(destinationSpike.x, destinationSpike.y, destinationSpike.z);

  spikeCurve.modifyPoints(ps);
}

void calcBlockCurve()
{
   PVector [] ps; 
   
   ps = new PVector[4];
   ps[0] = new PVector(puntoBola.x,puntoBola.y,puntoBola.z);
   
   PVector secondPointAux = new PVector(0,0,0);
   secondPointAux.x = puntoBola.x;
   secondPointAux.y = puntoBola.y - 20;
   secondPointAux.z = puntoBola.z - 200;
   ps[1] = new PVector(secondPointAux.x,secondPointAux.y,secondPointAux.z);
   
   PVector thirdPointAux = new PVector(0,0,0);
   thirdPointAux.x = puntoBola.x;
   thirdPointAux.y = puntoBola.y + 200;
   thirdPointAux.z = puntoBola.z - 400;
   ps[2] = new PVector(thirdPointAux.x,thirdPointAux.y,thirdPointAux.z);
   
   PVector lastPointAux = new PVector(0,0,0);
   lastPointAux.x = puntoBola.x;
   lastPointAux.y = puntoBola.y + 600;
   lastPointAux.z = puntoBola.z - 500;
   ps[3] = new PVector(lastPointAux.x,lastPointAux.y,lastPointAux.z);
   
   spikeCurve.modifyPoints(ps);
}


PVector calculateUnitVector(PVector pos1, PVector pos2) //Calcula un vector unitario entre dos posiciones recibidas como parámetro
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
