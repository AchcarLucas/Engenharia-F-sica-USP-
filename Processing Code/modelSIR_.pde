float N = 1;
// Curados por dia
float k = 0.07142857142f;
// Dias de analise
float days = 100;
// Taxa de Contato
float b = 0.5f;

// Infectados
float I = pow(10, -6);
// Recuperados
float R = 0;
// Suscetiveis TOTAL - (INFECTADOS + RECUPERADOS)
float S = N - (I + R);

class Sample {
   public float I, R, S, t;
   
   Sample(float S, float R, float I, float t) {
     this.I = I;
     this.R = R;
     this.S = S;
     this.t = t;
   }
}

ArrayList<Sample> samples = new ArrayList<Sample>();

void setup() {
  size(800, 600);
  
  noSmooth();
  strokeWeight(2);
  
  println("Initial Value: ");
  println("S: " + S);
  println("R: " + R);
  println("I: " + I);
  
  addSample(0);
  
  for(int i = 0; i < days; ++i)
    deriv(i + 1);
}

void draw() {
  background(0);
  
  stroke(255);

  for(int i = 0; i < samples.size() - 1; ++i) {
    stroke(0, 0, 255);
    point(samples.get(i).t*5 + 100, samples.get(i).S * 100 + 300);
    line(samples.get(i).t*5 + 100, samples.get(i).S * 100 + 300, samples.get(i + 1).t*5 + 100, samples.get(i + 1).S * 100 + 300);
    
    stroke(255, 0, 0);
    point(samples.get(i).t*5 + 100, samples.get(i).I * 100 + 300);
    line(samples.get(i).t*5 + 100, samples.get(i).I * 100 + 300, samples.get(i + 1).t*5 + 100, samples.get(i + 1).I * 100 + 300);
    
    stroke(0, 255, 0);
    point(samples.get(i).t*5 + 100, samples.get(i).R * 100 + 300);
    line(samples.get(i).t*5 + 100, samples.get(i).R * 100 + 300, samples.get(i + 1).t*5 + 100, samples.get(i + 1).R * 100 + 300);
  }
}

void deriv(float t) {
  float dSdt = -b*S*I/N;
  float dIdt = b*S*I/N - k*I;
  float dRdt = k*I;
  
  S += dSdt;
  I += dIdt;
  R += dRdt;
  
  addSample(t);  
}

void addSample(float t) {
  samples.add(new Sample(1.0f - (S / N), 1.0f - (R / N), 1.0f - (I / N), t));
}
