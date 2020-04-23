void drawArrow(float x, float y, float angle) {
  pushMatrix();
    translate(x, y);
    rotate(-angle);
    triangle(-2.5, 5, 0, 0, 2.5, 5);
  popMatrix();
}

class CarController {
  // (Base Polar) fazer as rotações dos vetores (rad)
  private float angle;
  
  private float acceleration_angle;
  
  // Aceleração de Oposição
  private PVector friction;
 
  // Aceleração do Carro (m/s^2)
  private PVector acceleration;
  
  // Velocidade do Carro (m/s)
  private PVector velocity;
  
  // Posição do Carro (R2)
  private PVector position;
  
  // Aceleração Máxima do Carro (m/s^2)
  private PVector MAX_ACCELERATION;
  
  // Imagem do Carro
  PImage car_image = null;
  
  CarController(PVector position, PVector MAX_ACCELERATION, float friction) {
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0.0f, 0.0f);
    this.friction = new PVector(0, friction);
    this.MAX_ACCELERATION = MAX_ACCELERATION;
    this.position = position;
    this.acceleration_angle = 0.0f;
    this.angle = -PI;
  }
  
  // Adiciona aceleração ao carro
  void addAcceleration(PVector accel) {
    this.acceleration.x += accel.x;
    if(this.acceleration.x > MAX_ACCELERATION.x) this.acceleration.x = MAX_ACCELERATION.x;
    
    this.acceleration.y += accel.y;
    if(this.acceleration.y > MAX_ACCELERATION.y) this.acceleration.y = MAX_ACCELERATION.y;
  }
  
  // Faz a rotação do vector com base em um angulo
  PVector rotateVector(PVector w, float angle) {
    return new PVector(cos(angle)*w.x+sin(angle)*w.y, -sin(angle)*w.x+cos(angle)*w.y);
  }
  
  // Aceleração de rotação do carro
  void addAccelerationAngle(float accel_angle) {
    this.acceleration_angle += accel_angle;
  }
  
  boolean hasAcceleration() {
    return acceleration.x != 0.0f || acceleration.y != 0.0f;
  }
  
  boolean hasVelocity() {
    return velocity.x != 0.0f || velocity.y != 0.0f;
  }
  
  void setImage(String image_name) {
    car_image = loadImage(image_name);
  }
  
  // Chame essa Função para Atualizar a Física do Carro
  void updateLogic() {
    acceleration.x += friction.x;
    acceleration.y = (acceleration.y > 0) ? acceleration.y + friction.y : 0;
    
    PVector r_acceleration = rotateVector(acceleration, angle);
    
    velocity.x += r_acceleration.x;
    velocity.y += r_acceleration.y;
    
    velocity.x *= 0.9f;
    velocity.y *= 0.9f;
   
    // A velocidade não muda com o angulo ...
    position.x += velocity.x;
    position.y += velocity.y;
    
    angle -= acceleration_angle;
    acceleration_angle = acceleration_angle*0.8f;
  }
  
  void drawLogic() {
    float r_velocity = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2));
    PVector pA = rotateVector(new PVector(0, -20.f*r_velocity, 0.0f), angle + PI);
    
    if(r_velocity > 1.0f) {
      textSize(20);
      fill(200, 0, 0);
      text(r_velocity + "m/s", position.x + pA.x, position.y + pA.y);
    }
    
    // Debug
    stroke(255, 255, 255);
    line(position.x, position.y, position.x + pA.x, position.y + pA.y);
    
    fill(255, 0, 0);
    stroke(255, 0, 0);
    drawArrow(position.x + pA.x, position.y + pA.y, angle + PI);
    
    // Car
    if(car_image != null) {
      pushMatrix();
        translate(position.x, position.y);
        rotate(-angle + PI);
        image(car_image, -car_image.width/2, -car_image.height/2, car_image.width, car_image.height);
      popMatrix();
    }
  }
}

CarController car1;

// Key Controller
boolean key_right = false;
boolean key_left = false;
boolean key_up = false;

void setup() {
  size(1024,762);
  smooth();
  car1 = new CarController(new PVector(400, 300), new PVector(1.0f, 1.0f), -0.1f);
  //car1.setImage("car.png");
}

void draw() {
  background(0, 0, 0);
 
  fill(lerpColor(color(255, 0, 0), color(255, 255, 255), abs(cos((millis()*PI/180)*0.15f))));
  textSize(25);
  
  text("Tecla (W S D A) ou (← ↑ →) Movimenta o Carro", 10, 30); 
  
  car1.updateLogic();
  car1.drawLogic();
  
  if(key_right && car1.hasAcceleration()) car1.addAccelerationAngle(0.01f);
  if(key_left && car1.hasAcceleration()) car1.addAccelerationAngle(-0.01f);
  if(key_up) car1.addAcceleration(new PVector(0, 0.8f));
}

void keyPressed() {
  if(key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) key_right = true;
  if(key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) key_left = true;
  if(key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) key_up = true;
}

void keyReleased() {
  if(key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) key_right = false;
  if(key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) key_left = false;
  if(key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) key_up = false;
}
