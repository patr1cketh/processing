class ImpactMarker {
  float latitude, longitude;
  float x, y;
  float mass;
  String location;
  String date;
  int year;
  String discovered;
  color markerColour;
  float markerSize;

  public ImpactMarker(float latitude, float longitude, float mass, String location, String date, String discovered) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.x = map(longitude, -180, 180, 0, width);
    this.y = map(latitude, 90, -90, 0, height);
    this.mass = mass;
    this.location = location;
    this.date = date;
    this.year = this.date.length() > 0 ? int(this.date.substring(6, 10)) : 1000;
    this.discovered = discovered;

    // use the Hue, Saturation, Brightness colour model
    // which gives a better range of colours when picking randomly
    colorMode(HSB);
    this.markerColour = color(random(0, 255), random(100, 250), random(200, 255), 140);
    this.markerSize = log(7.0 + mass);
  }

  // to draw an ImpactMarker draw a circle, proportional to the mass of the meteorite
  // at the x,y (cartesian) position of the marker
  public void draw() {
    pushStyle();
    stroke(255);
    fill(markerColour);
    ellipse(x, y, this.markerSize, this.markerSize);
    popStyle();
  }


  public String getInfo() {
    String info = "";
    float distance = dist(mouseX, mouseY, x, y);
    if (distance < 4) {
      info = String.format("Mass: %2.2f kg in %s %s in the year %d", this.mass / 1000.0, this.location, this.discovered, this.year);
    }

    return info;
  }

  boolean inRange(int s, int e) {
    return true;
  }
}
