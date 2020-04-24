public boolean DebugMode = true;
public boolean DebugDistance = true;
public boolean DebugArrow = true;
public boolean DebugText = true;

public classForce forces = new classForce();
  
classParticle p1;

typeForceField sum_1;
typeForceField sum_2;

void setupMain() {
  float sun_mass = 0.5*pow(10, 17); // kg
  float particle_mass = 0.5*pow(10, 7); // kg
  
  PVector sum_1_position = new PVector((width / 2) - 400, (height / 2) - 300);
  PVector sum_2_position = new PVector((width / 2) - 300, (height / 2) - 200);
  PVector particle_position = new PVector((width / 2) - 100, (height / 2) - 100);
  
  p1 = new classParticle(particle_position, new PVector(0.0f, +0.0f), particle_mass, "Earth");
  
  sum_1 = new typeForceField(enumForce.ATTRACT_FIELD, sum_1_position, new PVector(0.0f, 10.0f, 0), sun_mass, "Sun_1");
  forces.addForceField(sum_1);
  
  sum_2 = new typeForceField(enumForce.ATTRACT_FIELD, sum_2_position, new PVector(0.0f, 0.0f, 0), sun_mass, "Sun_2");
  forces.addForceField(sum_2);
  
  forces.addClassObject(p1);
}

void drawMain() {
  fill(255, 255, 255);
  
  if(!p1.hasDestroyed())
    circle(p1.getPosition().x, p1.getPosition().y, 5.0f);
  
  fill(255, 255, 0);
  stroke(255, 255, 0);
  
  circle(sum_1.getPosition().x, sum_1.getPosition().y, 10.0f);
  circle(sum_2.getPosition().x, sum_2.getPosition().y, 10.0f);
  
  forces.updatePhysic();
}
