import uibooster.*; //<>//
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import rita.*;

Table movie_lines, movie_list; // declare tables
UiBooster gui = new UiBooster(); // declare UiBooster

JSONArray movie_data;

ArrayList<String> movie_titles; // declare ArrayList


void setup() {
  size(960, 540);

  movie_list = loadTable("movie_titles_metadata_header.csv", "header");
  movie_lines = loadTable("movie_lines_header.csv", "header");
  movie_data = new JSONArray();
  movie_titles = new ArrayList<>();
  JSONObject movie = new JSONObject();
  JSONObject character;
  JSONArray characters = new JSONArray();
  JSONArray lines_array;
  StringList movie_ids = new StringList();
  for (TableRow row : movie_list.rows()) movie_ids.append(row.getString("MovieID"));
  StringList character_ids = new StringList();
  StringList unique_ids = new StringList();
  for (TableRow row : movie_lines.findRows(movie_ids.get(0), "MovieID")) character_ids.append(row.getString("CharacterID"));
  for (String id : character_ids) if (!unique_ids.hasValue(id)) unique_ids.append(id);
 movie.setString("movieID", movie_ids.get(0));
 TableRow row = movie_list.findRow(movie_ids.get(0), "MovieID");
 movie.setString("movieName", row.getString("MovieName"));
 for (String id : unique_ids) {
   character = new JSONObject();
   character.setString("charcterID", id);
   character.setString("characterName", movie_lines.findRow(id, "CharacterID").getString("CharacterName"));
   lines_array = new JSONArray();
   for (TableRow r : movie_lines.findRows(id, "CharacterID")) lines_array.append(r.getString("MovieLine"));
   character.setJSONArray("lines", lines_array);
   characters.append(character);
 }
 movie.setJSONArray("characters", characters);
 movie_data.append(movie);
 saveJSONArray(movie_data, "movie_data.json");
  
  
  //for (TableRow row : movie_list.rows()) {
  //  JSONObject movie = new JSONObject();
  //  StringList unique_character_ids = new StringList();
  //  movie.setString("movieID", row.getString("MovieID")); // get MovieID from table row and add it to movie object
  //  movie.setString("movieName", row.getString("MovieName")); // add MovieName
  //  String[] character_ids = {};
  //  JSONObject character = new JSONObject();
  //  JSONArray lines = new JSONArray();
  //  for (TableRow row_2 : movie_lines.findRows(row.getString("MovieID"), "MovieID")) { // loop through all rows that have a matching movieID
  //     character_ids = append(character_ids, row_2.getString("CharacterID")); // append all the character ids
  //     for (final String id : character_ids) if (!unique_character_ids.hasValue(id)) unique_character_ids.append(id); // extract all the unique values          
  //     for (String id : unique_character_ids) {        
  //       character.setString("characterID", id);
  //       character.setString("characterName", movie_lines.findRow(id, "CharacterID").getString("CharacterName"));         
  //       for (TableRow row_3 : movie_lines.findRows((id), "CharacterID")) {           
  //         lines.append(row_3.getString("MovieLine"));           
  //       }
  //       character.setJSONArray("lines", lines);
  //       movie.setJSONObject("characters", character);
  //     }     
  //  }
  // movie_data.append(movie); // add the movie object to the array
  // break;
  //}
  
  
  //saveJSONArray(movie_data, "movie_data.json");
    
}
  
  
 // int random_line = int(random(0, movie_lines.getRowCount()));
 // String the_line = movie_lines.getRow(random_line).getString("MovieLine");
  
  //String [] parts of_speech = RiTa.pos(the_line); 

  //println("Movie Line:");
  //println(the_line);
  //println(parts_of_speech);
    
 // gui.createForm("Movie Dialogue Browser")
 //   .addSelection("Movie Title", movie_titles)
 //   .show();
