/*
Transformada Discreta de Fourier
Desenvolvido por Lucas Campos Achcar
Base: https://pt.qwe.wiki/wiki/Discrete_Fourier_transform
*/

static final int N_SAMPLE = 1000;

int divScreenToTime = 100;
float FS = 1.0 / divScreenToTime;

int pos_y_f = 0;

int SAMPLE_DFT = 1000;

float generate_freq[] = {2, 3, 4, 5, 12, 20};

class COMPLEX {
  float real;
  float imaginary;
  float mag;
  float phase;
};

float sample_data[];
COMPLEX dft_data[];

void setup() {
  size(800, 600);
  textAlign(CENTER);
  
  pos_y_f = height / 2;
  
  sample_data = new float[N_SAMPLE];
  
  calcReload();
  dft_data = DFT(sample_data, SAMPLE_DFT);
}

void draw() {
  background(0);
  drawGrid();
  stroke(255, 0, 0);
  line(0, pos_y_f, width, pos_y_f);
  stroke(0, 0, 255);
  strokeWeight(1);
  {
    // f(t) - (Time Domain)
    for(int i = 0; i < N_SAMPLE - 1; ++i) {
      line(i, sample_data[i] + pos_y_f, i + 1, sample_data[i + 1] + pos_y_f);
    }
  }
  
  stroke(255,0,0);
  strokeWeight(1);
  { 
    float m = 3;
    int offset = 200;
    for(int i = 0; i < SAMPLE_DFT - 1; ++i) {
       line(i*m, pos_y_f+offset, i*m, (-1)*dft_data[i].mag*0.01 + pos_y_f+offset);
        
       textSize(8);
       if(dft_data[i].mag > 1.0f) {
         // FS*SAMPLE_SIZE = 10
         text((float)(i) / 10 + "Hz", i*m, pos_y_f + offset + 20);
       } 
    }
   
  }
  
  strokeWeight(1.0);
  textSize(12);
  for(int i = 0; i < width / divScreenToTime; ++i) {
    text(str((float)i) + "(s)", i*divScreenToTime, pos_y_f);
  }
}

void drawGrid() {
  stroke(0,255,0);
  strokeWeight(0.1);
  for(int i = 0; i < width / divScreenToTime; ++i) {
    line(i*divScreenToTime, 0, i*divScreenToTime, height);
  }
  
  for(int i = 0; i < height / 100; ++i) {
    line(0, i*100, width, i*100);
  }
}

void mouseWheel(MouseEvent event) {  
  divScreenToTime += event.getCount();
  FS = 1.0 / divScreenToTime;
  
  println("idvScreenToTime: " + divScreenToTime);
  
  calcReload();
}

void calcReload() {
  for(int i = 0; i < N_SAMPLE; ++i) {
    sample_data[i] = 0;
    for(int f = 0; f < generate_freq.length; ++f)
      sample_data[i] += ((50/(f + 1))*sin(generate_freq[f]*2*PI*i*FS));
  }
}

COMPLEX []DFT(float[]in_sample, int N) {
  COMPLEX []out_sample = new COMPLEX[N];
  for(int i = 0; i < N; ++i)
    out_sample[i] = new COMPLEX();
    
  out_sample[0].real = 0.0;
  for(int k = 0; k < N; ++k) {
    float result_re = 0;
    float result_im = 0;
    for(int n = 0; n < N_SAMPLE; n++) {
      result_re += in_sample[n]*cos((2*PI*k*n)/N_SAMPLE);
      result_im += (-1)*in_sample[n]*sin((2*PI*k*n)/N_SAMPLE);
    }
    
    out_sample[k].mag = sqrt(pow(result_re, 2) + pow(result_im, 2));
    out_sample[k].phase = atan2(result_re, result_im);
    out_sample[k].real = result_re;
    out_sample[k].imaginary = result_im;
  }
  return out_sample;
}
