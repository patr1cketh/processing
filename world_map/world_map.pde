import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();

final String BACKGROUND_IMAGE_FILE = "1200x600-earth.png";
PImage backgroundImage;

final int DEFAULT_LATITUDE = 1;
final int DEFAULT_LONGITUDE = 1;

float markerX, markerY;
final int MARKER_SIZE = 10;

final int LATITUDE_INDEX = 0;
final int LONGITUDE_INDEX = 1;


void setup() {
  size(1200,600);
  backgroundImage = loadImage(BACKGROUND_IMAGE_FILE);
  fill(#FAE123);
  
  markerX = map(DEFAULT_LONGITUDE, -180, 180, 0, width);
  markerY = map(DEFAULT_LATITUDE, -90, 90, height, 0);
  
  gui.createForm("Global Tracker")
     .addSlider("Latitude", -90, 90, DEFAULT_LATITUDE, 30, 15)
     .addSlider("Longitude", -180, 180, DEFAULT_LONGITUDE, 60, 30)
     .setChangeListener((e, v, f) -> setPosition(e))
     .addButton("Where is this?", () -> showLocation())
     .run();   
      
}

void draw() {
  background(backgroundImage);
  ellipse(markerX, markerY, MARKER_SIZE, MARKER_SIZE);
}


void setPosition(FormElement e) {
  if (e.getIndex() == LATITUDE_INDEX) {
    markerY = map(e.asInt(), -90, 90, height, 0);
  }
  else if (e.getIndex() == LONGITUDE_INDEX) {
    markerX = map(e.asInt(), -180, 180, 0, width);
  }

}

void showLocation() {

}
