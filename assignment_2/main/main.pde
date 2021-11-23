import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();

PImage background_image;
int[] solid = new int[6];

void setup() {
  
  size(1200, 860);
  background_image = loadImage("crystal_ball.jpg");
  chooseWord();
  
}

void chooseWord() {
  
  background(background_image);
  
  Table nouns_table = loadTable("nouns.csv");
  
  final int NOUNS_TABLE_LENGTH = nouns_table.getRowCount();
  int random_index_1, random_index_2;
  String noun_1, noun_2;
  
  random_index_1 = int(random(NOUNS_TABLE_LENGTH));
  random_index_2 = int(random(NOUNS_TABLE_LENGTH));
  
  noun_1 = nouns_table.getRow(random_index_1)
                      .getString(0);
  noun_2 = nouns_table.getRow(random_index_2)
                      .getString(0);

  gui.createForm("Choose a word")
   .addButton(noun_1, () -> {}).setID("noun_1")
   .addButton(noun_2, () -> {}).setID("noun_2")
   .setChangeListener((element, value, form) -> {
     if (element.getId().equals("noun_1")) {
       append(solid, 0);
     }
     if (element.getId().equals("noun_2")) {
       append(solid, 1);  
     }
     for (int e : solid) {
     print(e);
     }
     chooseWord();
   })
   .run();
}
