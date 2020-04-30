public boolean DebugMode = true;
public boolean DebugDistance = true;
public boolean DebugArrow = true;
public boolean DebugText = true;

public classForce forces = new classForce();
classParticle object;

PVector particle_position;

float mass_object = 10.0f;
float force_x =  500.0f;
float force_y = -500.0f;
float impulse_time = 1.0f;

void setupMain() {
  distanceResolution  = 0.1f;

  particle_position = new PVector(100, (height / 2));
  
  object = new classParticle(new PVector(particle_position.x, particle_position.y), new PVector(0, 0), mass_object, "Object");
  
  // Impulse
  forces.addForceObject(new typeForceObject(enumForce.IMPULSE_OBJECT, new PVector(force_x, force_y), impulse_time, "IMPULSE"));
  // Gravity
  forces.addForceObject(new typeForceObject(enumForce.PERMANENT_OBJECT, new PVector(0.0f, 9.8f*mass_object), "Gravity"));
  
  forces.addClassObject(object);
}

void drawMain() {
  fill(255, 255, 255);
  
  float dist_horizontal = PVector.dist(PVector.div(particle_position, distanceResolution), PVector.div(new PVector(object.getPosition().x, particle_position.y), distanceResolution));
  float dist_vertical = PVector.dist(PVector.div(particle_position, distanceResolution), PVector.div(new PVector(particle_position.x, object.getPosition().y), distanceResolution));
  
  stroke(255);
  text(dist_horizontal*meterPixel + "(m)", (particle_position.x + object.getPosition().x) / 2, particle_position.y + 5);
  line(particle_position.x, particle_position.y + 10, object.getPosition().x, particle_position.y + 10);
  
  text(dist_vertical*meterPixel + "(m)", particle_position.x + 5, (particle_position.y + object.getPosition().y) / 2);
  line(particle_position.x, particle_position.y + 10, particle_position.x, object.getPosition().y + 10);
  
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
