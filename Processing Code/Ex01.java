PVector vector_space;

PVector initial_velocity;
PVector initial_space;

float gravity = 5.98f;

float time = 0.0f;

float velocity_x;
float velocity_y;

void setup() {
  size(800, 600);
  
  vector_space = new PVector(0.0f, 0.0f, 0.0f);
  
  initial_velocity = new PVector(30.0f, -30.0f, 0.0f);
  initial_space = new PVector(100.0f, 100.0f, 0.0f);
}

void draw() {
    //background(0);
    
    float[] position = vector_space.array();
    float[] velocity = initial_velocity.array();
    
    print("X ", position[0], "\n");
    print("Y ", position[1], "\n");
    
    print("Angle ", -1*degrees(atan(velocity[1]/velocity[0])), "\n");
    
    fill(0, 255, 0);
    ellipse(position[0], position[1], 20.0f, 20.0f);
    
    f_velocity(time);
    time += 0.1f;
}

void f_velocity(float t) {
  // s(x) = s0 + v*t
  // s(y) = s0 + v0*t + (1/2)at^2
  
  float[] f_initial_space = initial_space.array();
  float[] f_initial_velocity = initial_velocity.array();
  
  // vx(t) = v0 + g*t
    
  velocity_x = f_initial_velocity[0];
  velocity_y = f_initial_velocity[1] + gravity*t;
  
  print("Velocity y ", velocity_x, " Velocity y ",velocity_y,"\n");
  
  float pos_x = f_initial_space[0] + f_initial_velocity[0]*t;
  float pos_y = f_initial_space[1] + f_initial_velocity[1]*t + gravity*pow(t, 2)/2;
  
  vector_space.set(pos_x, pos_y);
}
