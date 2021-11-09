class ImpactMarker {
  float latitude, longitude;
  float x, y;
  float mass;
  String location;
  String date;
  color markerColour;
  float markerSize;

  public ImpactMarker(float latitude, float longitude, float mass, String location, String date) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.x = map(longitude, -180, 180, 0, width);
    this.y = map(latitude, -90, 90, height, 0);
    this.mass = mass;
    this.location = location;
    this.date = date;

    // use the Hue, Saturation, Brightness colour model
    // which gives a better range of colours when picking randomly
    colorMode(HSB);
    this.markerColour = color(random(0, 255), random(100, 250), random(200, 255), 140);
    this.markerSize = log(8.0 + mass);
  }

  void draw() {
    pushStyle();
    stroke(255);
    fill(markerColour);
    ellipse(x, y, this.markerSize, this.markerSize);
    popStyle();
  }

  String getInfo() {
    String info = "";
    float distance = dist(mouseX, mouseY, x, y);
    if (distance < 4) {
      info = String.format("Mass: %2.2f kg in %s landed on %s", this.mass / 1000.0, this.location, this.date);
    }

    return info;
  }
}
