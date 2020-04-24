public boolean DebugMode = true;
public boolean DebugDistance = false;
public boolean DebugArrow = false;
public boolean DebugText = true;

public classForce forces = new classForce();
  
typeForceField sun;
ArrayList<classParticle> planet;
ArrayList<typeForceObject> typeForce;

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

// F = (G*m*M) / (R^2)
// Fcp = (m*v)^2 / R
// v = sqrt((2*M*G) / R)

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

float calcVelocity(float sun_mass, float r) {
  return sqrt((sun_mass * G) / r);
}

void setupMain() {
  
  /////////////////////////////////////////////////////
  planet = new ArrayList<classParticle>();
  typeForce = new ArrayList<typeForceObject>();
 
  // Massa do sol e das particulas
  float sun_mass = pow(10, 20);
  float mercury_mass = pow(10, 5);
  float venus_mass = pow(10, 6);
  float earth_mass = pow(10, 7);
  float mars_mass = pow(10, 8);
  float jupiter_mass = pow(10, 9);
  float saturn_mass = pow(10, 10);
  float uranus_mass = pow(10, 11);
  float netune_mass = pow(10, 12);
  
  PVector sunPosition = new PVector((width / 2), height / 2);
  PVector mercuryPosition = new PVector((width / 2), (height / 2) + 50);
  PVector VenusPosition = new PVector((width / 2), (height / 2) + 90);
  PVector earthPosition = new PVector((width / 2), (height / 2) + 150);
  PVector marsPosition = new PVector((width / 2), (height / 2) + 200);
  PVector jupiterPosition = new PVector((width / 2), (height / 2) + 230);
  PVector saturnPosition = new PVector((width / 2), (height / 2) + 280);
  PVector uranusPosition = new PVector((width / 2), (height / 2) + 320);
  PVector netunePosition = new PVector((width / 2), (height / 2) + 360);
  
  float sun_mercury = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(mercuryPosition, resolution));
  float sun_venus = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(VenusPosition, resolution));
  float sun_earth = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(earthPosition, resolution));
  float sun_mars = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(marsPosition, resolution));
  float sun_jupiter = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(jupiterPosition, resolution));
  float sun_saturn = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(saturnPosition, resolution));
  float sun_uranus = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(uranusPosition, resolution));
  float sun_netune = PVector.dist(PVector.div(sunPosition, resolution), PVector.div(netunePosition, resolution));
  
  /////////////////////////////////////////////////////
 
  sun = new typeForceField(enumForce.ATTRACT_FIELD, sunPosition, sun_mass, "Sun_1");
  planet.add(new classParticle(mercuryPosition, new PVector(calcVelocity(sun_mass, sun_mercury), 0.0f), mercury_mass, "Mercury"));
  planet.add(new classParticle(VenusPosition, new PVector(calcVelocity(sun_mass, sun_venus), 0.0f), venus_mass, "Venus"));
  planet.add(new classParticle(earthPosition, new PVector(calcVelocity(sun_mass, sun_earth), 0.0f), earth_mass, "Earth"));
  planet.add(new classParticle(marsPosition, new PVector(calcVelocity(sun_mass, sun_mars), 0.0f), mars_mass, "Mars"));
  planet.add(new classParticle(jupiterPosition, new PVector(calcVelocity(sun_mass, sun_jupiter), 0.0f), jupiter_mass, "Jupiter"));
  planet.add(new classParticle(saturnPosition, new PVector(calcVelocity(sun_mass, sun_saturn), 0.0f), saturn_mass, "Saturn"));
  planet.add(new classParticle(uranusPosition, new PVector(calcVelocity(sun_mass, sun_uranus), 0.0f), uranus_mass, "Uranus"));
  planet.add(new classParticle(netunePosition, new PVector(calcVelocity(sun_mass, sun_netune), 0.0f), netune_mass, "Netune"));
 
  forces.addForceField(sun);
  
  for(classParticle p: planet)
    forces.addClassObject(p);
}

void drawMain() {
  fill(255, 255, 255);
  
  float size_planet = 5.0f;
  for(classParticle p: planet) {
    if(!p.hasDestroyed())
      circle(p.getPosition().x, p.getPosition().y, size_planet);
      size_planet +=2.0f;
  }
  
  fill(255, 255, 0);
  stroke(255, 255, 0);
  circle(sun.getPosition().x, sun.getPosition().y, 10.0f);
  
  forces.updatePhysic();
}
