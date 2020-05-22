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



// Rotate a vector in 3D
void rotate3D(PVector v, float magnitud, float theta) {

  // What's the angle?
  float a = v.heading();

  // Change the angle
  a += theta;

  // Polar to cartesian for the new xy components
  v.x = magnitud * cos(a);
  v.y = magnitud * sin(a);
  v.z = magnitud * (1- cos(a));
}
