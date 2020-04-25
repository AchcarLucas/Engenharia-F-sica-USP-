public boolean DebugMode = true;
public boolean DebugDistance = true;
public boolean DebugArrow = true;
public boolean DebugText = true;

public classForce forces = new classForce();
classParticle object;

void setupMain() {
  PVector particle_position = new PVector(0, (height / 2));
 
  float mass_object = 10.0f;
  float force_x =  1000.0f;
  float force_y = -1000.0f;
  float impulse_time = 0.5f;
  
  object = new classParticle(particle_position, new PVector(0.0f, 0.0), mass_object, "Object");
  
  // Impulse
  forces.addForceObject(new typeForceObject(enumForce.IMPULSE_OBJECT, new PVector(force_x, force_y), impulse_time, "IMPULSE"));
  // Gravity
  forces.addForceObject(new typeForceObject(enumForce.PERMANENT_OBJECT, new PVector(0.0f, 9.8f*mass_object), "Gravity"));
  
  forces.addClassObject(object);
}

void drawMain() {
  fill(255, 255, 255);
  
  if(!object.hasDestroyed())
    circle(object.getPosition().x, object.getPosition().y, 5.0f);

  forces.updatePhysic();
}
