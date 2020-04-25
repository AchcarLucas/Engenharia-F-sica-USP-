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
    
    for(typeForceObject p : fn_object) {
      fn_result.add(p.force);
    }
    
    for(typeForceField p : fn_field) {
      float dist = PVector.dist(r_position, p.position);
     
      if(dist < (1.0f / resolution)) {
        destroyed = true;
        return;
      }

      if((p.type == enumForce.ATTRACT_FIELD || p.type == enumForce.REPULSE_FIELD)) {
        // Cria um vetor auxiliar com direção do objeto para o centro do campo de força, 
        // normaliza e multiplica pela constante gravitacional * m1 * m2 e divide pela distância ao quadrado
        PVector PF = PVector.sub(r_position, p.position);
        PF.normalize();
        PF.mult(p.type == enumForce.ATTRACT_FIELD ? -1 : 1);
        float intensity = G * (r_mass * p.mass) / pow(dist, 2);
        PF.mult(intensity);
        
        // A força que é aplicada no objeto é aplicada ao Campo com sentido contrário
        PVector tfn_result = new PVector(PF.x, PF.y);
        tfn_result.mult(-1);
        tfn_result.div(p.mass);
        p.velocity.add(tfn_result);
        p.position.add(p.velocity);
        
        // Debug Mode (Line)
        if(DebugMode && DebugText)
          drawText(p.mass, "kg", p.position.x * resolution, p.position.y * resolution - 10.0f);
        
        if(DebugMode && DebugDistance) {
          drawLine(r_position, p.position);
          drawText(dist / 1000.0f, "km", new PVector(p.position.x + r_position.x, p.position.y + r_position.y));
        }
        
        if(DebugMode && DebugArrow) {
          drawArrow("N", tfn_result, p.position);
          drawArrow("m/s", p.velocity, p.position, color(255, 0, 0));
          drawArrow("N", tfn_result.mult(-1), r_position);
        }
        
        // Add força resultante
        fn_result.add(PF);
      }
    }
    
    if(DebugMode && DebugText)
      drawText(r_mass, "kg", r_position.x * resolution, r_position.y * resolution - 10.0f);
    
    if(DebugMode && DebugArrow) {
      // Draw Arrow, Text and Vector Velocity
      if(r_velocity.mag() != 0)
        drawArrow("m/s", r_velocity, r_position, color(255,0,0));
    }
    
    if(DebugText && DebugMode)
      drawTextString(r_name, r_position.x * resolution, (r_position.y * resolution) + 10.0f);

    // Divide pela massa do objeto para achar a aceleração
    fn_result.div(r_mass);
    
    // Angle da fn_result
    if(r_velocity.mag() != 0) angle_velocity = atan2(r_velocity.y, r_velocity.x);
    if(fn_result.mag() != 0) angle_result_force = atan2(fn_result.y, fn_result.x);
     
    // v0 + a*t (vector)
    r_velocity.add(fn_result);
    
    // Incrementa a velocidade na posição
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
    this.r_position = r0_position.mult(1 / resolution);
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
