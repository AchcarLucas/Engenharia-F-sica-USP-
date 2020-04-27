void drawText(float value, String symbol, PVector position) {
  fill(255, 255, 255);
  text(value + "(" + symbol + ")", (position.x * distanceResolution) / 2, (position.y * distanceResolution) / 2);
}

void drawText(float value, String symbol, float x, float y) {
  fill(255, 255, 255);
  text(value + "(" + symbol + ")", x, y);
}

void drawTextValue(float value, float x, float y) {
  fill(255, 255, 255);
  text(value, x, y);
}

void drawTextString(String str, float x, float y) {
  fill(255, 255, 0);
  text(str, x, y);
}

void drawLine(PVector a, PVector b) {
  stroke(255, 255, 255);
  line(a.x * distanceResolution, a.y * distanceResolution, b.x * distanceResolution, b.y * distanceResolution);
}

float forceNewton(float m1, float m2, float dist, float const_g) {
  return const_g * (m1 * m2) / pow(dist, 2);
}
