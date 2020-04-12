float initial_pos_x = 0.0f;
float initial_pos_y = 0.0f;

float pos_x = 0.0f;
float pos_y = 0.0f;
float velocity_x = 1.0f;
float velocity_y = -5.0f;

float gravity = 0.098f;

float radius = 15.0f;

void setup() {
  size(1000, 600);
  initial_pos_x = pos_x = 0.0f;
  initial_pos_y = pos_y = width / 2;
}

void draw() {
  background(0);
  
  pos_x += velocity_x;
  pos_y += velocity_y;
  velocity_y += gravity;
  
  if(pos_y >= initial_pos_y) {
    velocity_y = -1*(velocity_y*0.85f);
    pos_y = initial_pos_y;
  }
  
  ellipse(pos_x, pos_y, radius*2, radius*2);
  
  stroke(255);
  line(0, initial_pos_y + radius, width, initial_pos_y + radius);
}
