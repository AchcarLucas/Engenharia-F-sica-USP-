float []position;
float time;
boolean initialize;

float init_x = 400;
float init_y = 300;

float r = 100.0f;

void setup() {
  size(800, 600);
  position = new float[2];
  position[0] = 0.0f;
  position[1] = 0.0f;
  time = 0.0f;
  initialize = false;
}

void draw() {
  background(127);
  
  noSmooth();
  strokeWeight(4);
  point(init_x, init_y);
  strokeWeight(1);
  
  if(initialize)
    time += 0.05f;
  
  fill(0, 255, 0);
  ellipse(pos_x(time) + init_x, pos_y(time) + init_y, 5, 5);
  
  drawArrow(pos_x(time) + init_x, pos_y(time) + init_y, vec_x(time) + pos_x(time) + init_x, vec_y(time) + pos_y(time) +init_y);
  drawArrow(pos_x(time) + init_x, pos_y(time) + init_y, accel_x(time) + pos_x(time) + init_x, accel_y(time) + pos_y(time) + init_y);
  
  textSize(10);
  fill(0);
  
  text(sqrt(pow(vec_x(time), 2) + pow(vec_y(time), 2)) + "m*s^-1", vec_x(time) + pos_x(time) + init_x, vec_y(time) + pos_y(time) + init_y);
  text(sqrt(pow(accel_x(time), 2) + pow(accel_y(time), 2)) + "m*s^-2", accel_x(time) + pos_x(time) + init_x, accel_y(time) + pos_y(time) + init_y);

  text("Position (" + pos_x(time) + ")i + " + "(" +  pos_y(time) + ")j\n", 10, 70);
  text("Velocity (" + vec_x(time) + ")i + " + "(" +  vec_y(time) + ")j\n", 10, 90);
  text("Acceleration (" + accel_x(time) + ")i + " + "(" +  accel_y(time) + ")j\n", 10, 110);

  fill(255, 0, 0);
  textSize(15);
  text("Time: " + time, 10, 20);
  
  textSize(20);
  if(!initialize) {
    fill(255, 0, 0);
    text("Press Enter to Initialize Time", 10, 40);
  } else {
    fill(0, 255, 0);
    text("Press Enter to Stop Time", 10, 40);
  }
}

void drawArrow(float x1, float y1, float x2, float y2) {
  fill(255, 0, 0);
  line(x1, y1, x2, y2);
  pushMatrix();
    translate(x2, y2);
    rotate(atan2(y2 - y1, x2 - x1));
    triangle(0, 0, -5.f, 2.5f, -5.f, -2.f);
  popMatrix();
}

void keyPressed() {
  if(keyCode == ENTER) {
    initialize = !initialize;
  }
}

float pos_x(float time) {
  return cos(time)*r;
}

// Inverte os sinais, (y cresce de cima para baixo)
float pos_y(float time) {
  return sin(time)*r;
}

float vec_x(float time) {
  return -r*sin(time);
}

// Inverte os sinais, (y cresce de cima para baixo)
float vec_y(float time) {
  return r*cos(time);
}

float accel_x(float time) {
  return -r*cos(time);
}

// Inverte os sinais, (y cresce de cima para baixo)
float accel_y(float time) {
  return -sin(time)*r;
}
