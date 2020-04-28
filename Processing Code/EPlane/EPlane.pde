void setup() {
  size(800, 600, P3D);
  noSmooth();
}

PVector n = new PVector (3, 2, -4);
PVector p = new PVector (0, 0, 0);

void draw() {
  background(0);
  ArrayList<PVector> listPoint = EquationPlane(n, p, 10, 10, 10);
}

ArrayList<PVector> EquationPlane(PVector Normal, PVector Point, int sizeX, int sizeY, int sizeZ) {
  ArrayList<PVector> listPoint = new ArrayList<PVector>(); 
  float d = -Normal.x*Point.x  - -Normal.y*Point.y - -Normal.y*Point.y;
  
  for(int x = 0; x < sizeX; ++x) {
    for(int y = 0; y < sizeY; ++y) {
      for(int z = 0; z < sizeZ; ++z) {
        float c_z = (-1*Normal.x*x + Normal.y*y + d) / Normal.z;
        PVector p = new PVector(x, y, c_z);
        listPoint.add(p);
      }
    }
  }
  
  return listPoint;
}
