static boolean debugText = true;
// Constant Gravity pixel*s^-2
static float accelGravity = 0.981f;

// Altura e Largura da Rampa
int rampWidth = 50; // Largura
int rampHeight = 200; // Altura

// Tan = cateto oposto (altura) / cateto adjacente (largura)
float angleRamp = atan2(rampHeight, rampWidth);

PVector rampPosition;
PVector widthRamp, heightRamp, initialRamp;

boolean contactRamp = true;
boolean stopGame = true;

class Ball {
  // Backup Reseting ...
  PVector b_velocity;
  PVector b_acceleration;
  PVector b_position;
  
  PVector velocity;    // Velocidade em cada eixo
  PVector acceleration; // Aceleração em cada eixo
  PVector position;      // Posição Atual da particula
  
  float size;            // Tamanho da bola
  
  Ball(PVector acceleration, PVector position, float size) {
    this.acceleration = acceleration;
    this.b_acceleration = new PVector(acceleration.x , acceleration.y);
    this.position = position;
    this.b_position = new PVector(position.x, position.y);
    this.velocity = new PVector();
    this.b_velocity = new PVector(velocity.x, velocity.y);
    this.size = size;
  }
  
  void setAcceleration(PVector acceleration) {
    this.acceleration = acceleration;
  }
  
  PVector getPosition() {
    return position;
  }
  
  void reset() {
    this.acceleration = new PVector(b_acceleration.x, b_acceleration.y);
    this.position = new PVector(b_position.x, b_position.y);
    this.velocity = new PVector(b_velocity.x, b_velocity.y);
    println("Reseting ...");
    println(this.acceleration);
    println(this.position);
    println(this.velocity);
  }
  
  void updateLogic() {
    velocity.add(acceleration);
    position.add(velocity);
  }
  
  void drawLogic() {
    circle(position.x + (size / 2), position.y - (size / 2), size);
  }
  
}

Ball ball;

void setup() {
  size(800, 600);
  noSmooth();
  settingText(CENTER, 10);
  reconfigureRamp();
}

void reconfigureRamp() {
  rampPosition = new PVector(100, height - 100);
  heightRamp = new PVector(rampPosition.x, rampPosition.y - rampHeight);
  widthRamp = new PVector(rampPosition.x + rampWidth, rampPosition.y);
  
  angleRamp = atan2(rampHeight, rampWidth);
  
  ball = new Ball(new PVector(accelGravity * cos(angleRamp), accelGravity * sin(angleRamp)), new PVector(heightRamp.x, heightRamp.y), 10);
}

void keyPressed() {
  if(keyCode == ENTER) stopGame = !stopGame;
}

void settingText(int align, int size) {
  textAlign(align);
  textSize(size);
}

void draw() {
  background(0);
  
  {
    textAlign(LEFT);
    textSize(25);
    
    settingText(LEFT, 25);
    
    fill(lerpColor(color(255, 0, 0), color(255, 255, 255), abs(cos((millis()*PI/180)*0.15f))));
    
    if(stopGame)
      text("Press ENTER to Start", 10, 30);
    else
      text("Press ENTER to Stop", 10, 30);
      
    fill(255, 255, 255);
      
    settingText(CENTER, 10);
  }

  // Line Height
  {
    stroke(0, 255, 0);
    line(rampPosition.x,  rampPosition.y, heightRamp.x, heightRamp.y);
  }
  
  // Line Width
  {
    stroke(0, 255, 0);
    line(rampPosition.x,  rampPosition.y, widthRamp.x, widthRamp.y);
  }
  
  // Line End to Top
  {
    stroke(0, 255, 0);
    line(heightRamp.x,  heightRamp.y, widthRamp.x, widthRamp.y);
  }
  
  if(debugText) {
    stroke(255, 255, 255);
    text(distance(heightRamp, widthRamp), ((heightRamp.x + widthRamp.x) / 2) + 30.0f, ((heightRamp.y + widthRamp.y) / 2));
    text(distance(rampPosition, widthRamp), (rampPosition.x + widthRamp.x) / 2, ((rampPosition.y + widthRamp.y) / 2) + 20.0f);
    text(distance(rampPosition, heightRamp), ((rampPosition.x + heightRamp.x) / 2) - 20.0f, (rampPosition.y + heightRamp.y) / 2);
  }
  
  if(contactRamp && ball.getPosition().x > widthRamp.x) {
    ball.setAcceleration(new PVector(0, accelGravity));
    contactRamp = false;  
  }
  
  if(ball.getPosition().y > width) {
    ball.reset();
    rampWidth = (int)random(50, 500); // Random Largura
    rampHeight = (int)random(50, 500); // Random Altura
    reconfigureRamp();
    contactRamp = true;
  }
  
  if(!stopGame)
    ball.updateLogic();
  
  ball.drawLogic();
  
}

float distance(PVector a, PVector b) {
  return a.dist(b);
}
