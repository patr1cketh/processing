import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();
Form form;

final int DEFAULT_LATITUDE = 0;
final int DEFAULT_LONGITUDE = 0;

final int LATITUDE_INDEX = 0;
final int LONGITUDE_INDEX = 1;

final String BACKGROUND_IMAGE_FILE = "1200x600-earth.png";
PImage backgroundImage;

final int MARKER_SIZE = 10;
float positionX, positionY;

void setup() {
  size(1200,600);
  backgroundImage = loadImage(BACKGROUND_IMAGE_FILE);
  fill(#FAE123);
  
  positionX = map(DEFAULT_LONGITUDE, -180, 180, 0, width);
  positionY = map(DEFAULT_LATITUDE, -90, 90, height, 0);
  
  form = gui.createForm("Global Tracker")
     .addSlider("Latitude", -90, 90, DEFAULT_LATITUDE, 30, 15)
     .addSlider("Longitude", -180, 180, DEFAULT_LONGITUDE, 60, 30)
     .setChangeListener((e, v, f) -> setPosition(e))
     .addButton("Where is this?", () -> showLocation())
     .run();
}

void draw() {
  background(backgroundImage);
  ellipse(positionX, positionY, MARKER_SIZE, MARKER_SIZE);
}

void setPosition(FormElement e) {
  if (e.getIndex() == LATITUDE_INDEX) {
    positionY = map(e.asInt(), -90, 90, height, 0);
  }
  else if (e.getIndex() == LONGITUDE_INDEX) {
    positionX = map(e.asInt(), -180, 180, 0, width);
  }
}
