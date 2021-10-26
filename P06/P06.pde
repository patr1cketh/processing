import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();

final String BACKGROUND_IMAGE_FILE = "1200x600-earth.png";
PImage backgroundImage;


void setup() {
  size(1200,600);
  backgroundImage = loadImage(BACKGROUND_IMAGE_FILE);
  fill(#FAE123);
  
}

void draw() {
  background(backgroundImage);
}


void setPosition(FormElement e) {

}

void showLocation() {

}
