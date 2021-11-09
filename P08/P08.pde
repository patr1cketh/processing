import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import java.util.List;
import java.util.ListIterator;

final String DATA_SOURCE = "Meteorite-Landings.csv";

List<ImpactMarker> impactList;

UiBooster gui = new UiBooster();

PImage mapOfTheWorld;

void setup() {
  size (1200, 600);

  mapOfTheWorld = loadImage("1200x600-earth.png");
  impactList = createImpactList(DATA_SOURCE);
}


void draw() {
  background(mapOfTheWorld);
  for (ImpactMarker meteorite : impactList) {
    meteorite.draw();
  }
}

void mouseClicked() {
  String info = "";
  boolean notFound = true;
  
  ListIterator<ImpactMarker> impacts = impactList.listIterator();
  
  while (impacts.hasNext() && notFound == true) {
    info = impacts.next().getInfo();
    notFound = info.length() == 0;
  }
  
  if (notFound == false) {
    gui.showInfoDialog(info);
  }
}
