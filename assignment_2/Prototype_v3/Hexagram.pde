// this function takes the binary input from the form and returns the text from the data json object
String getIchingMessage(String binary_string) {
  String return_string = ""; // initialise an empty return string
  int hex_number = binary_to_hexnumber.getInt(binary_string); // get the hexagram number associated with the binary string
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
// funtion to get the hexgram number and return it as a string
String getHexagramNumber(String binary_string) {
 String hexagram_number = str(binary_to_hexnumber.getInt(binary_string)); 
 return hexagram_number; 
}

// this function uses another external json object to get the charachter needed to render the hexagram using the hexagram font
String getHexagramCharachter(String hexagram_number) {
  JSONObject font_mapping = loadJSONObject("hexagram_font_mapping.json");
  String hexagram_charachter = font_mapping.getString(hexagram_number);
  return hexagram_charachter; 
}

// function to get the hexagram name
String getHexagramName(String binary_string) {
  int hex_number = binary_to_hexnumber.getInt(binary_string); 
  int hex_index = hex_number - 1; 
  String hexagram_name = data.getJSONObject(hex_index).getString("title");
  return hexagram_name;
   
}
