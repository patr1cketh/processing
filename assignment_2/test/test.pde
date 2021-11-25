import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();

float start_x, start_y, end_x, end_y;
boolean is_solid;
HexagramLine hexagram_line;
ArrayList<HexagramLine> lines_array;

Table nouns_table;

String noun_1, noun_2, chosen_noun;

int counter;

String binary_string;


void setup() {
  
  size(1200, 860);
  
  nouns_table = loadTable("nouns.csv");
  
  start_x = width/2 + 300;
  start_y = height/2 - 50;
  end_x = width/2 + 400;
  end_y = height/2 - 50;
  
  lines_array = new ArrayList<>();
  
  counter = 0;
  //displayForm();
 
}

void draw() {}

void keyPressed() {
  for (int i = 0; i < 6; i++) {
    float j = random(2);
    if (j < 1) {
      is_solid = false;
    }
    else {
      is_solid = true;
    }
    hexagram_line = new HexagramLine(start_x, start_y, end_x, end_y, is_solid);
    lines_array.add(hexagram_line);
    updateCoordinates();
  }
  for (HexagramLine hexagram_line : lines_array) {
    hexagram_line.drawLine();
  }
  getBinaryString(lines_array);
}

//void displayForm() {
  
//  noun_1 = getRandomNoun();
//  noun_2 = getRandomNoun();
  
//  gui.createForm("Choose a word")
//   .addButton(noun_1, () -> {is_solid = false;}).setID("noun_1")
//   .addButton(noun_2, () -> {is_solid = true;}).setID("noun_2")
//   .setChangeListener((element, value, form) -> buttonClicked())
//   .andWindow().setSize(200, 200).save()
//   .run();

//}

//void buttonClicked() {
//  counter++;
  
//  hexagram_line = new HexagramLine(start_x, start_y, end_x, end_y, is_solid);
//  lines_array.add(hexagram_line);
//  hexagram_line.drawLine();
//  updateCoordinates();
  
  
//  if (counter < 6) {
//    displayForm();
//  }
//  else {
//    rect(0,0,1200,860);
//    displayResult();
//  }
//}

//void displayResult() {
//  background(255);
//  for (HexagramLine hexagram_line : lines_array) {
//    hexagram_line.drawLine();
//  }
//  //getBinaryString(lines_array);
//}

String getBinaryString(ArrayList<HexagramLine> lines_array) {
  String bin_str = "";
  for (HexagramLine hexagram_line : lines_array) {
    bin_str = hexagram_line.is_solid ? bin_str + "1" : bin_str + "0";
  }
  return bin_str;
}

void updateCoordinates() {
  start_y += 20;
  end_y += 20;
}

//String getRandomNoun() {
//  int random_index_1;
//  String noun;
//  final int NOUNS_TABLE_LENGTH = nouns_table.getRowCount();
  
//  random_index_1 = int(random(NOUNS_TABLE_LENGTH));
   
//  noun = nouns_table.getRow(random_index_1)
//                    .getString(0);
//  return noun;
//}
