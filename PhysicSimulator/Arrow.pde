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
