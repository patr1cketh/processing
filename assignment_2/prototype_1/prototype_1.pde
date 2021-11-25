import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();

PImage background_image;
ArrayList<Line> lines;
float start_x, start_y, end_x, end_y;
boolean is_solid;

Line line;

void setup() {
  
  size(1200, 860);
  background_image = loadImage("crystal_ball.jpg");
  
  // initialise start and end coordinates for first line
  start_x = width/2 + 300;
  start_y = height/2 - 50;
  end_x = width/2 + 400;
  end_y = height/2 - 50;
  lines = new ArrayList<Line>();
  chooseWord();
  
}

void draw() {}

void chooseWord() {
  
  //background(background_image);
  
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
   .setChangeListener((element, value, form) -> wordChosen(element, form))
   .run();
}

void wordChosen(FormElement element, Form form) {
  if (form.getById("noun_1") == element) {
       is_solid = false;
     }
  if (form.getById("noun_2") == element) {
       is_solid = true;
     }
  line = new Line(start_x, start_y, end_x, end_y, is_solid);
  lines.add(line);
  updateCoordinates();
     
     chooseWord();
}

void updateCoordinates() {
  start_y -= 20;
  end_y -= 20;
}
