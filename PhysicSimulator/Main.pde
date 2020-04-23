public boolean DebugMode = true;
public boolean DebugForce = true;

public classForce forces = new classForce();
  
classParticle p1;

typeForceField _tff1;
typeForceField _tff2;

void setupMain() {
  
  // Movimento Circular
  
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  
  // F = (G*m*M) / (R^2)
  // Fcp = (m*v)^2 / R
  // v = sqrt((2*M*G) / R)
  
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  // Massa da particula
  float sun_mass = pow(10, 20); // kg
  float particle_mass = pow(10, 10); // kg
  
  println("Mass Sun: " + sun_mass + " kg");
  println("Mass Particle: " + particle_mass + " kg");
  
  PVector sunPosition = new PVector((width / 2) - 100, height / 2);
  PVector particlePosition = new PVector((width / 2), (height / 2) + 200);
  PVector sun2Position = new PVector((width / 2) + 150, (height / 2));
  
  float R = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(particlePosition, resolution));
  
  println("R: " + R / 1000.0f + " km");
  
  // Calculando velocidade tangencial para permanencer em movimento circular
  float v = sqrt((sun_mass * G) / R);
  
  println("Velocity: " + v + " m/s");
  
  /////////////////////////////////////////////////////
  
   p1 = new classParticle(particlePosition, new PVector(v*1.5f, 0.0f), particle_mass);
  
  _tff1 = new typeForceField(enumForce.ATTRACT_FIELD, sunPosition, sun_mass);
  forces.addForceField(_tff1);
  
  _tff2 = new typeForceField(enumForce.ATTRACT_FIELD, sun2Position, pow(10, 20));
  forces.addForceField(_tff2);
  
  forces.addClassObject(p1);
}

void drawMain() {
  fill(255, 255, 255);
  
  if(!p1.hasDestroyed())
    circle(p1.getPosition().x, p1.getPosition().y, 5.0f);
  
  fill(255, 255, 0);
  stroke(255, 255, 0);
  
  circle(_tff1.getPosition().x, _tff1.getPosition().y, 10.0f);
  circle(_tff2.getPosition().x, _tff2.getPosition().y, 10.0f);
  
  forces.updatePhysic();
}
