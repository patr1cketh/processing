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

List<ImpactMarker> originalList, workingList;

String dataSource = "Meteorite-Landings.csv";

void setup() {
  size (1200, 600);

  mapOfTheWorld = loadImage("1200x600-earth.png");
  originalList = createImpactList(dataSource);
  workingList = new ArrayList<>(originalList);
  
  createFilteringGUI();
}


void draw() {
  background(mapOfTheWorld);

  for  (ImpactMarker meteorite : workingList) {
    meteorite.draw();
  }
}

void mouseClicked() {
  String info = "";
  boolean notFound = true;
  ListIterator<ImpactMarker> impacts = workingList.listIterator();
  
  while (impacts.hasNext() && notFound == true) {
    info = impacts.next().getInfo();
    notFound = info.length() == 0;
  }
 
  if (notFound == false) {
    gui.showInfoDialog(info);
  }
}
