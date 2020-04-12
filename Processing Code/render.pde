float [][]mvp;
float []vertices = {
    -1.0, -1.0,  1.0,
     1.0, -1.0,  1.0,
     1.0,  1.0,  1.0,
    -1.0,  1.0,  1.0,
    // back
    -1.0, -1.0, -1.0,
     1.0, -1.0, -1.0,
     1.0,  1.0, -1.0,
    -1.0,  1.0, -1.0
};

// AB = [c(i,j)], where c(i,j) = a(i,1)*b(1,j) + a(i,2)*b(2,j) + … + a(i,n)*b(n,j).
float[][] mul(float [][]m1, float[][]m2) {
  float result[][] = new float[4][4];
  for (int i = 0; i < m1.length; ++i) {
    for (int j = 0; j < m2.length; ++j) {
      float sum = 0;
      for (int k = 0; k < m2.length; ++k) {
        sum += m1[i][k]*m2[k][j];
      }
      result[i][j] = sum;
    }
  }
  return result;
}

float [][] identity(int size) {
  float [][]identity = new float[size][size];
  for (int i = 0; i < identity.length; ++i) {
    for (int j = 0; j < identity[i].length; ++j) {
      identity[i][j] = i == j ? 1 : 0;
    }
  }
  return identity;
}

void transform(float [][]matrix) {
  mvp = mul(matrix, mvp);
}

void rotate(float x, float y, float z) {
  float radX = radians(x);
  float radY = radians(y);
  float radZ = radians(z);
  
  float sinX = sin(radX);
  float cosX = cos(radX);
  
  float sinY = sin(radY);
  float cosY = cos(radY);
  
  float sinZ = sin(radZ);
  float cosZ = cos(radZ);
  
  float [][]matrix = new float[4][4];
  
  matrix[0][0] = cosY * cosZ;
  matrix[0][1] = cosX * sinZ + sinX * sinY * cosZ;
  matrix[0][2] = sinX * sinZ - cosX * sinY * cosZ;
  matrix[0][3] = 0;
  
  matrix[1][0] = -cosY * sinZ;
  matrix[1][1] = cosX * cosZ - sinX * sinY * sinZ;
  matrix[1][2] = sinX * cosZ + cosX * sinY * sinZ;
  matrix[1][3] = 0;
  
  matrix[2][0] = sinY;
  matrix[2][1] = cosX * cosY;
  matrix[2][2] = cosX * cosY;
  matrix[2][3] = 0;
  
  matrix[3][0] = 0;
  matrix[3][1] = 0;
  matrix[3][2] = 0;
  matrix[3][3] = 1;
  
  transform(matrix);
  
}

void position(float x, float y, float z) {
  float [][]matrix = identity(4);
  
  matrix[0][3] = -x;
  matrix[1][3] = -y;
  matrix[2][3] = -z;

}

void scale(float x, float y, float z) {
  float [][]matrix = identity(4);
  matrix[0][0] = x;
  matrix[1][1] = y;
  matrix[2][2] = z;
}

void debugMatrix(float [][]result) {
  for (int i = 0; i < result.length; ++i) {
    for (int j = 0; j < result[i].length; ++j) {
      print(result[i][j] + " ");
    }
    print("\n");
  }
  print("\n");
}

void setup() {
  size(800, 600);
  mvp = new float[4][4];
  float [][]m1 = new float[3][3];

  m1[0][0] = 1;
  m1[0][1] = 2;
  m1[0][2] = 3;
  m1[1][0] = 4;
  m1[1][1] = 5;
  m1[1][2] = 6;
  m1[2][0] = 7;
  m1[2][1] = 8;
  m1[2][2] = 9;
  
  debugMatrix(m1);

  float [][]m2 = new float[3][3];

  m2[0][0] = 1;
  m2[0][1] = 2;
  m2[0][2] = 3;
  m2[1][0] = 4;
  m2[1][1] = 5;
  m2[1][2] = 6;
  m2[2][0] = 7;
  m2[2][1] = 8;
  m2[2][2] = 9;

  float [][]result = mul(m1, m2);
  
  debugMatrix(result);
  
  float [][]identity = identity(3);
  debugMatrix(identity);
}

void draw() {
}
