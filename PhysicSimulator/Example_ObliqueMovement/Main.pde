public boolean DebugMode = true;
public boolean DebugDistance = true;
public boolean DebugArrow = true;
public boolean DebugText = true;

public classForce forces = new classForce();
classParticle object;

PVector particle_position;

float mass_object = 10.0f;
float force_x =  1000.0f;
float force_y = -1000.0f;
float impulse_time = 0.5f;

void setupMain() {
  particle_position = new PVector(100, (height / 2));
  
  object = new classParticle(new PVector(particle_position.x + 100, particle_position.y), new PVector(0.0f, 0.0), mass_object, "Object");
  
  // Impulse
  forces.addForceObject(new typeForceObject(enumForce.IMPULSE_OBJECT, new PVector(force_x, force_y), impulse_time, "IMPULSE"));
  // Gravity
  forces.addForceObject(new typeForceObject(enumForce.PERMANENT_OBJECT, new PVector(0.0f, 9.8f*mass_object), "Gravity"));
  
  forces.addClassObject(object);
  
  resolution = 0.01f;
}

void drawMain() {
  fill(255, 255, 255);
  
  if(!object.hasDestroyed())
    circle(object.getPosition().x, object.getPosition().y, 8.0f);

  stroke(0, 255, 0);
  line(0, particle_position.y, width, particle_position.y);

  if(object.getPosition().y > particle_position.y) {
    object.setPosition(new PVector(particle_position.x, particle_position.y));
    object.setVelocity(new PVector(0, 0));
    forces.addForceObject(new typeForceObject(enumForce.IMPULSE_OBJECT, new PVector(force_x, force_y), impulse_time, "IMPULSE"));
  }

  forces.updatePhysic();
}
