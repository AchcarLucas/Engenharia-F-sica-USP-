class Bezier {
  
  ArrayList<PVector> pointControl;
  
  Bezier() {
    pointControl = new ArrayList<PVector>();
  }
  
  void addPoint(PVector point) {
    pointControl.add(point);
  }
  
  ArrayList<PVector> getPointControl() {
    return pointControl;
  }
  
  PVector getPoint(float time) {
    if(pointControl.size() < 2)
      return new PVector(0, 0, 0);
    
    ArrayList<PVector> result = Interpolate(pointControl, time);
    // Faz a interpolação pelo tempo até chegar em 1 ponto que é a junção de todas as interpolações.
    do {
      result = Interpolate(result, time);
    } while(result.size() != 1);
    return new PVector(result.get(0).x, result.get(0).y, result.get(0).z);

  }
  
  // Faz a interpolação de todos os pontos pelo tempo e retorna os pontos interpolados.
  private ArrayList<PVector> Interpolate(ArrayList<PVector> tmpPoint, float time) {
    ArrayList<PVector> retnPoint = new ArrayList<PVector>();
    for(int i = 0; i < tmpPoint.size() - 1; ++i) {
      
      float x_1 = tmpPoint.get(i).x;
      float y_1 = tmpPoint.get(i).y;
      float z_1 = tmpPoint.get(i).z;
      
      float x_2 = tmpPoint.get(i + 1).x;
      float y_2 = tmpPoint.get(i + 1).y;
      float z_2 = tmpPoint.get(i + 1).z;
      
      retnPoint.add(new PVector( (x_1*(1 - time) + x_2*time), 
                                 (y_1*(1 - time) + y_2*time), 
                                 (z_1*(1 - time) + z_2*time)
                              ));
                              
    }
    return retnPoint;
  }
  
}

Bezier myBazier = new Bezier();

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(800, 600);
  myBazier.addPoint(new PVector(400, 300, 0));
  myBazier.addPoint(new PVector(500, 200, 0));
  myBazier.addPoint(new PVector(600, 300, 0));
  myBazier.addPoint(new PVector(700, 200, 0));
  
  for(float time = 0; time <= 1.0f; time+=0.05) {
    PVector g_point = myBazier.getPoint(time);
    points.add(g_point);
    print("Time: " + time + " Point " + g_point + "\n");
  }
}

void draw() {
  background(0);
  
  // Interpolate (Branco)
  strokeWeight(2);
  stroke(255, 255, 255);
  for(int i = 0; i < points.size(); ++i) {
    point(points.get(i).x, points.get(i).y);
  }
  
  // Line Curve
  stroke(0, 127, 0);
  strokeWeight(2);
  for(int i = 0; i < points.size() - 1; ++i) {
    line(points.get(i).x, points.get(i).y, points.get(i + 1).x, points.get(i + 1).y);
  }
 
  ArrayList<PVector> pointController = myBazier.getPointControl();
  
  // Line Controller
  stroke(255, 255, 255);
  strokeWeight(2);
  for(int i = 0; i < pointController.size() - 1; ++i) {
    line(pointController.get(i).x, pointController.get(i).y, pointController.get(i + 1).x, pointController.get(i + 1).y);
  }
  
  // Controller (Vermelho)
  strokeWeight(5);
  stroke(255, 0, 0);
  for(int i = 0; i < pointController.size(); ++i) {
    point(pointController.get(i).x, pointController.get(i).y);
  }
 
}
