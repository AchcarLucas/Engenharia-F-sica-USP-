import java.util.*; 

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

protected float resolution = 0.01f;
protected float G = 6.67408*pow(10, -11);

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

public enum enumForce {
       IMPULSE_OBJECT, ATTRACT_FIELD, REPULSE_FIELD, PERMANENT_OBJECT;
} 

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

class typeForceObject {
  public enumForce type;
  public float t_m_impulse;
  public PVector force;
  public String name;
  
  typeForceObject(enumForce type, PVector force, float t_m_impulse, String name) {
    this.type = type;
    this.force = force;
    this.t_m_impulse = t_m_impulse;
    this.name = name;
  }
  
  typeForceObject(enumForce type, PVector force, String name) {
    this.type = type;
    this.force = force;
    this.t_m_impulse = 0.0f;
    this.name = name;
  }
  
  typeForceObject(enumForce type, PVector force) {
    this.type = type;
    this.force = force;
    this.t_m_impulse = 0.0f;
    this.name = "none_" + second()+millis() + "_" + (int)random(Integer.MAX_VALUE);
  }
}

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

class typeForceField {
  public enumForce type;
  public PVector position;
  public float mass;
  public String name;
  
  typeForceField(enumForce type, PVector position, float mass, String name) {
    this.type = type;
    this.position = position;
    this.mass = mass;
    this.name = name;
  }
  
  typeForceField(enumForce type, PVector position, String name) {
    this.type = type;
    this.position = position;
    this.mass = 1.0f;
    this.name = name;
  }
  
  typeForceField(enumForce type, PVector position) {
    this.type = type;
    this.position = position;
    this.mass = 1.0f;
    this.name = "none_" + second()+millis() + "_" + (int)random(Integer.MAX_VALUE);
  }
  
  PVector getPosition() {
    return PVector.mult(position, resolution);
  }
  
  void setPosition(PVector position) {
    this.position = position;
  }
}

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

class classForce {
  ArrayList<classObject> on_class;
  ArrayList<typeForceObject> fn_object;
  ArrayList<typeForceField> fn_field;
  
  classForce() {
    on_class = new ArrayList<classObject>();
    fn_object = new ArrayList<typeForceObject>();
    fn_field = new ArrayList<typeForceField>();
  }
  
  ArrayList<typeForceObject> getForcesObject() {
    return fn_object;
  }
  
  ArrayList<typeForceField> getForcesField() {
    return fn_field;
  }
  
  void addClassObject(classObject object) {
    on_class.add(object);
  }
  
  void addForceObject(typeForceObject f) {
    fn_object.add(f);
  }
  
  void removeAllClassObject() {
    on_class.removeAll(on_class);
  }
  
  void removeAllForcesObject() {
    fn_object.removeAll(fn_object);
  }
  
  void removeAllForcesField() {
    fn_field.removeAll(fn_field);
  }
  
  void addForceField(typeForceField f) {
    f.position.mult(1/resolution);
    fn_field.add(f);
  }
  
  // Calcula a força resultante das forças atuando no objeto
  ArrayList<typeForceObject> getResultObjectForce() {
    return fn_object;
  }
  
  ArrayList<typeForceField> getResultFieldForce() {
    return fn_field;
  }
  
  void updatePhysic() {
    // UpdatePhysic todas as classObject
    for(classObject p : on_class)
      p.updatePhysic(fn_object, fn_field);
    
    Iterator<typeForceObject> it = fn_object.iterator();
    
    // Verifica o impulso e remove aqueles que já estão zerados
    while(it.hasNext()) {
      typeForceObject obj = it.next();

      if(obj.type == enumForce.IMPULSE_OBJECT) {
        obj.t_m_impulse -= 0.1f;
        if(obj.t_m_impulse <= 0.0f) {
          it.remove();
          continue;  
        }
      }     
    }
  }
}

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

void setup() {
  size(1024, 600);
  noSmooth();
  textAlign(CENTER);
  setupMain();
}

void draw() {
  background(0, 0, 0);
  drawMain();
}
