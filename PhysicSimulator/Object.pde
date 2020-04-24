public class classObject {
  protected PVector r_position;
  protected PVector r_velocity;
  protected String r_name;
  protected float r_mass;
  protected float angle_velocity;
  protected float angle_result_force;
  protected boolean destroyed;
  
  public void updatePhysic(ArrayList<typeForceObject> fn_object, ArrayList<typeForceField> fn_field) {    
    if(hasDestroyed()) return;
    
    PVector fn_result = new PVector();
    
    // Acha a força resultante
    for(typeForceObject p : fn_object) {
      fn_result.add(p.force);
    }
    
    for(typeForceField p : fn_field) {
      float dist = PVector.dist(r_position, p.position);
     
      if(dist < 1000.0f) {
        destroyed = true;
        return;
      }
      
      if((p.type == enumForce.ATTRACT_FIELD || p.type == enumForce.REPULSE_FIELD)) {
        // Cria um vetor auxiliar com direção do objeto para o centro do campo de força, 
        // normaliza e multiplica pela intensidade da força multiplicado pela distância ao quadrado
        PVector PF = PVector.sub(r_position, p.position);
        PF.normalize();
        PF.mult(p.type == enumForce.ATTRACT_FIELD ? -1 : 1);
        float intensity = G * (r_mass * p.mass) / pow(dist, 2);
        PF.mult(intensity);
        
        // Debug Mode (Line)
        if(DebugMode) {
          stroke(255, 255, 255);
          line(r_position.x * resolution, r_position.y * resolution, p.position.x * resolution, p.position.y * resolution);
          if(DebugName) {
            fill(255, 255, 0);
            text(p.name, p.position.x * resolution, (p.position.y * resolution) + 10.0f);
          }
          fill(255, 255, 255);
          text(dist/1000.0f + "(km)", (p.position.x + r_position.x)* resolution / 2, (p.position.y + r_position.y)* resolution / 2);
          text(p.mass + "(kg)", p.position.x * resolution, p.position.y * resolution - 10.0f);
        }
        
        fn_result.add(PF);
        
      }
    }
    
    if(DebugForce) {
      PVector TMP_V;
      // Draw Arrow, Text and Vector Result Force
      if(fn_result.mag() != 0) {
        stroke(0, 255, 0);
        fill(0, 255, 0);
        TMP_V = PVector.mult(fn_result, 1.0f);
        TMP_V.normalize();
        TMP_V.mult(50.0f);
        line(r_position.x * resolution, r_position.y * resolution, r_position.x * resolution + TMP_V.x, r_position.y * resolution + TMP_V.y);
        drawArrow(r_position.x * resolution + TMP_V.x, r_position.y * resolution + TMP_V.y, -1 * (getAngleToResultForce() + PI / 2), 2.0f);
        text(fn_result.mag() + "(N)", r_position.x * resolution + TMP_V.x, r_position.y * resolution + TMP_V.y);
      }
      
      // Draw Arrow, Text and Vector Velocity
      if(r_velocity.mag() != 0) {
        stroke(255, 0, 0);
        fill(255, 0, 0);
        TMP_V = PVector.mult(r_velocity, 1.0f);
        TMP_V.normalize();
        TMP_V.mult(50.0f);
        line(r_position.x * resolution, r_position.y * resolution, r_position.x * resolution + TMP_V.x, r_position.y * resolution + TMP_V.y);
        drawArrow(r_position.x * resolution + TMP_V.x, r_position.y * resolution + TMP_V.y, -1 * (getAngleToVelocity() + PI / 2), 2.0f);
        text(r_velocity.mag() + "(m/s)", r_position.x * resolution + TMP_V.x, r_position.y * resolution + TMP_V.y);
      }
      
      if(DebugName) {
        fill(255, 255, 0);
        text(r_name, r_position.x * resolution, (r_position.y * resolution) + 10.0f);
      }
    }
    
    // Divide pela massa para achar a velocidade
    fn_result.div(r_mass);
    
    // Angle da fn_result
    if(r_velocity.mag() != 0)
      angle_velocity = atan2(r_velocity.y, r_velocity.x);
    
    if(fn_result.mag() != 0)
      angle_result_force = atan2(fn_result.y, fn_result.x);
     
    // v0 + a*t (vector)
    // Espaço por fator 0.1f
    r_velocity.add(fn_result);
    
    // incrementa a velocidade na posição
    r_position.add(r_velocity);
  }
  
  classObject(PVector r0_position, PVector r0_velocity, float r0_mass, String r0_name) {
    this.r_position = r0_position.mult(1/resolution);
    this.r_velocity = r0_velocity;
    
    this.r_mass = 1.0f;
    if(r0_mass > 0)
      this.r_mass = r0_mass;
      
    this.r_name = r0_name;
    this.destroyed = false;
  }
  
  classObject(PVector r0_position, PVector r0_velocity, float r0_mass) {
    this.r_position = r0_position.mult(1/resolution);
    this.r_velocity = r0_velocity;
    
    this.r_mass = 1.0f;
    if(r0_mass > 0)
      this.r_mass = r0_mass;
      
    this.r_name = "none_" + second()+millis() + "_" + (int)random(Integer.MAX_VALUE);
    this.destroyed = false;
  }
  
  classObject(PVector r0_position, PVector r0_velocity) {
    this.r_position = r0_position.mult(1/resolution);
    this.r_velocity = r0_velocity;
    this.r_mass = 1.0f;
    this.r_name = "none_" + second()+millis() + "_" + (int)random(Integer.MAX_VALUE);
    this.destroyed = false;
  }
  
  PVector getPosition() {
    return PVector.mult(r_position, resolution);
  }
  
  String getName() {
    return r_name;
  }
  
  float getAngleToVelocity() {
    return angle_velocity;
  }
  
  float getAngleToResultForce() {
    return angle_result_force;
  }
  
  boolean hasDestroyed() {
    return destroyed;
  }
  
  void setDestroyed(boolean destroyed) {
    this.destroyed = destroyed;
  }
  
}
