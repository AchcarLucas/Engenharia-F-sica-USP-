import java.util.*; 

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

public float distanceResolution = 0.01f;
public float G = 6.67408*pow(10, -11);
public float meterPixel = 2.5 / 72.5;

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
  
  private void _typeForceObject(enumForce type, PVector force, float t_m_impulse, String name) {
    this.type = type;
    this.force = force;
    this.t_m_impulse = t_m_impulse;
    this.name = name;
    if(name.isEmpty())
      this.name = "none_" + second()+millis() + "_" + (int)random(Integer.MAX_VALUE);
  }
  
  typeForceObject(enumForce type, PVector force, float t_m_impulse, String name) {
    this._typeForceObject(type, force, t_m_impulse, name);
  }
  
  typeForceObject(enumForce type, PVector force, String name) {
    this._typeForceObject(type, force, type == enumForce.IMPULSE_OBJECT ? 1.0f : 0.0f, name);
  }
  
  typeForceObject(enumForce type, PVector force) {
    this._typeForceObject(type, force, type == enumForce.IMPULSE_OBJECT ? 1.0f : 0.0f, new String());
  }
}

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

class typeForceField {
  public enumForce type;
  
  public PVector position;
  public PVector velocity;
  
  public float mass;
  public String name;
  
  private void _typeForceField(enumForce type, PVector position, PVector velocity, float mass, String name) {
    this.type = type;
    this.position = position;
    this.velocity = velocity;
    this.mass = mass;
    this.name = name;
    if(name.isEmpty())
      this.name = "none_" + second()+millis() + "_" + (int)random(Integer.MAX_VALUE);
  }
  
  typeForceField(enumForce type, PVector position, PVector velocity, float mass, String name) {
    this._typeForceField(type, position, velocity, mass, name);
  }
  
  typeForceField(enumForce type, PVector position, float mass, String name) {
    this._typeForceField(type, position, new PVector(0, 0, 0), mass, name);
  }
  
  typeForceField(enumForce type, PVector position, String name) {
    this._typeForceField(type, position, new PVector(0, 0, 0), 1.0f, name);
  }
  
  typeForceField(enumForce type, PVector position) {
    this._typeForceField(type, position, new PVector(0, 0, 0), 1.0f, new String());
  }
  
  PVector getPosition() {
    return PVector.mult(position, distanceResolution);
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
  
  // Calcula a força resultante das forças atuando no objeto
  ArrayList<typeForceObject> getResultObjectForce() {
    return fn_object;
  }
  
  ArrayList<typeForceField> getResultFieldForce() {
    return fn_field;
  }
  
  void addClassObject(classObject object) {
    on_class.add(object);
  }
  
  void addForceObject(typeForceObject f) {
    fn_object.add(f);
  }
  
  void addForceField(typeForceField f) {
    f.position.mult(1/distanceResolution);
    fn_field.add(f);
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
  
  // Aqui é onde toda a física é atualizada
  void updatePhysic() {
    // UpdatePhysic todas as classObject
    for(classObject p : on_class)
      p.updatePhysic(fn_object, fn_field);
    
    Iterator<typeForceObject> it = fn_object.iterator();
    
    // Lei de Newton aplicado aos ForceField
    if(fn_field.size() > 1) {
      Iterator<typeForceField> itr = fn_field.iterator();
      typeForceField p = itr.next();
      
      // Aplica força entre os ForceField
      while(itr.hasNext()) {
        typeForceField p_next = itr.next();
        
        float dist = PVector.dist(p_next.position, p.position) * meterPixel;
        PVector PF = PVector.sub(p.position, p_next.position);
        float intensity = forceNewton(p.mass, p_next.mass, dist, G);
        
        PF.normalize();
        PF.mult(p.type == enumForce.ATTRACT_FIELD ? -1 : 1);
        PF.mult(intensity);
       
        PVector tfn_result = new PVector(PF.x, PF.y);
        tfn_result.div(p.mass);
        // Se passaram apenas frameRate (Padrão 60 fps) de segundos
        tfn_result.div(30);
        
        p.velocity.add(tfn_result);
        p.position.add(p.velocity);
        
        PF.mult(-1);
        PF.div(p_next.mass);
        
        // Divide a aceleração por 30 partes (1/30 segundos)
        PF.div(30);
        
        p_next.velocity.add(PF);
        p_next.position.add(p_next.velocity);

        if(DebugMode && DebugDistance) {
          drawLine(p_next.position, p.position);
          drawText(dist / 1000.0f, "(km)", new PVector(p.position.x + p_next.position.x, p.position.y + p_next.position.y));
        }
        
        if(DebugMode && DebugArrow) {
          drawArrow("N", tfn_result.mult(p.mass), p.position);
          drawArrow("N", PF.mult(p_next.mass), p_next.position);
          
          drawArrow("m/s", p.velocity, p.position, color(255, 0, 0));
          drawArrow("m/s", p_next.velocity, p_next.position, color(255, 0, 0));
        }
        
        if(DebugMode && DebugText) {
          drawText(p.mass, "kg", p.position.x * distanceResolution, p.position.y * distanceResolution - 10.0f);
          drawText(p_next.mass, "kg", p_next.position.x * distanceResolution, p_next.position.y * distanceResolution - 10.0f);  
        }
        
        if(DebugText && DebugMode) {
          drawTextString(p_next.name, p_next.position.x * distanceResolution, p_next.position.y * distanceResolution + 10.0f);
          drawTextString(p.name, p.position.x * distanceResolution, p.position.y * distanceResolution + 10.0f);
        }
        
        p = p_next;
      }
    } else {
      Iterator<typeForceField> itr = fn_field.iterator();
      
      if(itr.hasNext() && DebugText && DebugMode) {
        typeForceField p = itr.next();
        drawTextString(p.name, p.position.x * distanceResolution, p.position.y * distanceResolution + 10.0f);
        drawText(p.mass, "kg", p.position.x * distanceResolution, p.position.y * distanceResolution - 10.0f);
      }
    }
    
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
