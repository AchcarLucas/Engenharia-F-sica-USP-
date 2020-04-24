void drawArrow(float x, float y, float angle, float scale) {
  pushMatrix();
    translate(x, y);
    rotate(-angle);
    triangle(-2.5*scale, 5*scale, 0, 0, 2.5*scale, 5*scale);
  popMatrix();
}

void drawArrow(float x, float y, float angle) {
  pushMatrix();
    translate(x, y);
    rotate(-angle);
    triangle(-2.5, 5, 0, 0, 2.5, 5);
  popMatrix();
}

void drawArrow(String symbol, PVector v, PVector p) {
  stroke(0, 255, 0);
  fill(0, 255, 0);
  
  PVector TMP_V = PVector.mult(v, 1.0f);
  TMP_V.normalize();
  TMP_V.mult(50.0f);
  
  line(p.x * resolution, p.y * resolution, p.x * resolution + TMP_V.x, p.y * resolution + TMP_V.y);
  drawArrow(p.x * resolution + TMP_V.x, p.y * resolution + TMP_V.y, -1 * (atan2(TMP_V.y, TMP_V.x) + PI / 2), 2.0f);
  
  text(v.mag() + "("+symbol+")", p.x * resolution + TMP_V.x, p.y * resolution + TMP_V.y);
}

void drawArrow(String symbol, PVector v, PVector p, color  c) {
  stroke(c);
  fill(c);
  
  PVector TMP_V = PVector.mult(v, 1.0f);
  TMP_V.normalize();
  TMP_V.mult(50.0f);
  
  line(p.x * resolution, p.y * resolution, p.x * resolution + TMP_V.x, p.y * resolution + TMP_V.y);
  drawArrow(p.x * resolution + TMP_V.x, p.y * resolution + TMP_V.y, -1 * (atan2(TMP_V.y, TMP_V.x) + PI / 2), 2.0f);
  
  text(v.mag() + "("+symbol+")", p.x * resolution + TMP_V.x, p.y * resolution + TMP_V.y);
}
