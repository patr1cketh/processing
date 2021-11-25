import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster();

String binary_input;
JSONArray data;
JSONObject binary_to_hexnumber = new JSONObject();
ArrayList<String> oracle = new ArrayList<>();
  

void setup() {
  size(1200, 860);
  /* the iching data is stored as a json array in an external file
    first we want to load this into an internal json array
    iChing.json taken from https://github.com/dkloke */
  data = loadJSONArray("iChing.json");

  /* then we want to get the binary strings for each hexagram and save this
    to a json object matching them to the hexagram number */
  
  for (int i = 0; i < data.size(); i++) {
    String binary_string = data.getJSONObject(i).getString("binStr");
    int hexnumber = data.getJSONObject(i).getInt("kingWen");
    binary_to_hexnumber.setInt(binary_string, hexnumber);
  }

  // create a from for getting input from the user
  gui.createForm("Get oracle")
     .addText("Enter 6-digit binary string").setID("binary")
     .addButton("Submit", () -> gui.showInfoDialog(getOracle())).setID("submit")
     .setChangeListener((element, value, form) -> {
         if (element.getId().equals("submit")) {
             binary_input = form.getById("binary").asString();
             form.getById("binary").setValue("");
          }
      })
      .show();
  }                
                  
String getOracle() {
  String return_string = "";
  int hex_number = binary_to_hexnumber.getInt(binary_input);
  int hex_index = hex_number - 1;
  JSONObject hexagram_object = data.getJSONObject(hex_index);
  JSONArray lines = hexagram_object.getJSONArray("lines");
  // loop through the lines array to get the text for each line
  for (int i = 0; i < 6; i++) {
    JSONObject line_object = lines.getJSONObject(i);
    JSONArray text_array = line_object.getJSONArray("text");
    // loop through the text array excluding the first line
    for (int j = 1; j < text_array.size(); j++) { 
      // concatenate each line of text to the return string
      // we exclude the first line because it is not part of the original text
      return_string += text_array.getString(j);
    }
  }
  return return_string;
}
