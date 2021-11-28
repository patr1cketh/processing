import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

UiBooster gui = new UiBooster(); // construct UiBooster object

String binary_input; // string to hold the user input
JSONArray data; // json array to hold the entire data file
JSONObject binary_to_hexnumber = new JSONObject(); // simple json object that will hold the binary strongs and the corresponding hexagram number
  

void setup() {
  size(1200, 860);
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

  // create a form for getting input from the user
  gui.createForm("Get oracle")
     .addText("Enter 6-digit binary string").setID("binary")
     .setChangeListener((element, value, form) -> {
       // this function will run when the submit button is clicked
         if (element.getId().equals("submit")) {
             binary_input = form.getById("binary").asString(); // get the input from the text box
             gui.showInfoDialog(getOracleMessage(binary_input)); // show a popup info box that calls the getOracleMessage function
             form.getById("binary").setValue(""); // reset the text box value
          }
          
      })
      .addButton("Submit", () -> {}).setID("submit")
      .show();
  }                

// this function takes the binary input from the form and returns the text from the data json object
String getOracleMessage(String binary_input) {
  String return_string = ""; // initialise an empty return string
  int hex_number = binary_to_hexnumber.getInt(binary_input); // get the hexagram number associated with the binary string
  int hex_index = hex_number - 1; // -1 to use as an index
  JSONObject hexagram_object = data.getJSONObject(hex_index); // get the object associated with the hexagram number
  JSONArray lines = hexagram_object.getJSONArray("lines"); // get the array that contains the text for the hexagram
  // loop through the lines array to get the text for each line
  for (int i = 0; i < 6; i++) {
    JSONObject line_object = lines.getJSONObject(i); // get the object associated with each line
    JSONArray text_array = line_object.getJSONArray("text"); // get the array of text for the line
    // loop through the text array excluding the first line
    for (int j = 1; j < text_array.size(); j++) { 
      // concatenate each line of text to the return string
      // we exclude the first line because it is not part of the original text
      return_string += text_array.getString(j);
      return_string += "\n"; // add a newline charchter in between each line
    }
  }
  return return_string;
}
