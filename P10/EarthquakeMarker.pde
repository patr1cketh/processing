import java.util.Date;

class EarthquakeMarker {
  float latitude, longitude;
  float x, y;
  float magnitude;
  String location;
  long date;
  color markerColour;
  float markerSize;

  public EarthquakeMarker(float latitude, float longitude, float magnitude, String location, long date) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.x = map(longitude, -180, 180, 0, width);
    this.y = map(latitude, 90, -90, 0, height);
    this.magnitude = magnitude;
    this.location = location;
    this.date = date;

    colorMode(HSB);
    this.markerColour = color(random(0, 255), random(100, 250), random(200, 255), 140);
    this.markerSize = 4.0 * magnitude;
  }

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
      info = String.format("Magnitude: %2.2f near %s on %s", this.magnitude, this.location, new Date(this.date).toString());
    }
    return info;
  }

  boolean inDateRange(long s, long e) {  
    return s <= this.date && this.date <= e;
  }

  boolean inMagnitudeRange(float s, float e) {
    return s <= this.magnitude && this.magnitude <= e;
  }
}