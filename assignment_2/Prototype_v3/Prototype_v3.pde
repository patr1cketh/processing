import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster(); // construct UiBooster object

String binary_string = ""; // string to hold the binary code for the hexagram
JSONArray data; // json array to hold the entire data file
JSONObject binary_to_hexnumber = new JSONObject(); // simple json object that will hold the binary strings and the corresponding hexagram number

int counter = 0; // variable to count how many times the form is displayed

PFont khiara_script; // font variables
PFont hexagram_font; 

PImage background_image; // background image variable


void setup() {
  // set the window size and load background image
  size(1350, 902);
  background_image = loadImage("background.jpg");
  background(background_image);
  
  /* the iching data is stored as a json array in an external file
    first we want to load this into an internal json array
    iChing.json taken from https://github.com/dkloke */
  data = loadJSONArray("iChing.json");

  /* then we want to get the binary strings for each hexagram and save this
    to a json object matching them to the hexagram number
    this will make retrieving the message easier */ 
  for (int i = 0; i < data.size(); i++) { // loop through the object
    String binary_string = data.getJSONObject(i).getString("binStr"); // get the binary string
    int hexnumber = data.getJSONObject(i).getInt("kingWen"); // get the hexagram number
    binary_to_hexnumber.setInt(binary_string, hexnumber); // add them to the new object
  }
  
  khiara_script = createFont("khiara_script.otf", 46); // load the external font file into the font variable
  hexagram_font = createFont("iching_font.ttf", 80); // load the iching font for displaying the hexagrams
  
  noLoop(); // stops draw() from running on a loop
  
  displayForm();
   
}   

void draw() {
 
 fill(0); // black text
 
 textFont(khiara_script); // set the font
 text(getIchingMessage(binary_string), width/2, 40); // display the iching message
 
 textSize(60); // increase font size
 String hex_number_string = "HEXAGRAM NUMBER: " + getHexagramNumber(binary_string); // string for the hex number
 float number_width = textWidth(hex_number_string); // width of the string, useful for centering
 
 String hex_name_string = ("\"" + getHexagramName(binary_string) + "\"").toUpperCase(); // string for the hex name
 float name_width = textWidth(hex_name_string);
 text(hex_number_string, (width/2 - number_width)/2, height/2 - 175);
 text(hex_name_string, ((width/2) - name_width)/2, height/2 + 125, width/2 - 10, height);
 
 
 textFont(hexagram_font); // change to hexagram font
 text(getHexagramCharachter(getHexagramNumber(binary_string)), width/4 - 35, height/2); // display the hexagram
 
}
