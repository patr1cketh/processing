import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import java.util.List;
import java.util.ListIterator;

PImage mapOfTheWorld;

UiBooster gui = new UiBooster();

List<EarthquakeMarker> originalList, workingList;

String DATA_SOURCE = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson";

void setup() {
  size (1200, 600);

  mapOfTheWorld = loadImage("1200x600-earth.png");
  originalList = createEarthquakeList(DATA_SOURCE);
  workingList = new ArrayList<>(originalList); 
  createFilteringGUI();
}


void draw() {
  background(mapOfTheWorld);

  for  (EarthquakeMarker earthquake : workingList) {
    earthquake.draw();
  }
}

void mouseClicked() {
  String info = "";
  boolean notFound = true;
  ListIterator<EarthquakeMarker> impacts = workingList.listIterator();
  
  while (impacts.hasNext() && notFound == true) {
    info = impacts.next().getInfo();
    notFound = info.length() == 0;
  }
 
  if (notFound == false) {
    gui.showInfoDialog(info);
  }
}
