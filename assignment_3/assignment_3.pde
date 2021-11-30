import uibooster.*; //<>//
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import rita.*;

Table movie_lines, movie_list; // declare tables
ArrayList<String> movie_names, characters_array, lines; // declare ArrayLists
StringList characters, characters_duplicates; // declare StringLists

void setup() {
  size(960, 540);
  
  // load csv files into tables
  movie_list = loadTable("movie_titles_metadata_header.csv", "header");
  movie_lines = loadTable("movie_lines_header.csv", "header");  
  
  // add all the movie names to an ArrayList
  movie_names = new ArrayList<>();
  for (TableRow movie_row : movie_list.rows()) movie_names.add(movie_row.getString("MovieName"));    
  
  // get the user selection for movie name from a UiBooster selection dialog
  String movie_name = new UiBooster().showSelectionDialog("Choose a movie", "Choose a movie", movie_names); 
  // get the id for the movie
  String movie_id = movie_list.findRow(movie_name, "MovieName").getString("MovieID"); 
  
  // StringList type is necessary for hasValue() method of finding duplicates
  characters = new StringList();
  characters_duplicates = new StringList(); 
  for (TableRow row : movie_lines.findRows(movie_id, "MovieID")) characters_duplicates.append(row.getString("CharacterName")); // get all the characters from rows that match the movie_id
  for (String character : characters_duplicates) if (!characters.hasValue(character)) characters.append(character); // add characters to a new list excluding duplicates
  
  // transfer StringList elements to ArrayList. ArrayList is necessary for selection dialog
  characters_array = new ArrayList<>();
  for (String character : characters) characters_array.add(character); 
  
  // get the user selection for character
  String character_name = new UiBooster().showSelectionDialog("Choose a character", "Choose a character", characters_array); 
  
  lines = new ArrayList<>();
  // add all the lines that match the character name and movieID
  for (TableRow row : movie_lines.findRows(character_name, "CharacterName")) if (row.getString("MovieID").equals(movie_id)) lines.add(row.getString("MovieLine")); 
 
  // declare ints for counting words
  int total_lines = lines.size();;
  int total_words = 0;
  int lines_with_prp = 0;
  int total_prp = 0;
  
  // loop through all the lines
  for (String line : lines) { 
    // create a string array of word codes
    String[] parts_of_speech = RiTa.pos(line); 
    
    // add all codes to a StringList for hasValue() method
    StringList pos_list = new StringList();
    for (String pos : parts_of_speech) pos_list.append(pos);
    
    // count lines that contain a personal pronoun code
    if (pos_list.hasValue("prp")) {
     lines_with_prp += 1; 
     for (String pos : pos_list) if (pos.equals("prp")) total_prp += 1; // count individual personal pronoun codes
     for (String pos : pos_list) total_words += 1; // count all words
    }    
  }
 // use of ternary expressions to avoid dividing by 0
 float lines_percentage = lines_with_prp > 0 ? float(lines_with_prp)/float(total_lines) * 100.0 : 0.0;
 float words_percentage = total_prp > 0 ? float(total_prp)/float(total_words) * 100.0 : 0.0;
 
 // Build a string for displaying the results
 String info_string = "";
 info_string = String.format("Movie name: %s\nCharacter name: %s\nTotal character lines: %d\nLines with personal pronouns: %d  (%2.2f%%)\nTotal number of words: %d\nTotal number of personal pronouns: %d  (%2.2f%%)", movie_name, character_name, total_lines, lines_with_prp, lines_percentage, total_words, total_prp, words_percentage);
 
 // Display result in UiBooster info dialog
 UiBooster result = new UiBooster();
 result.showInfoDialog(info_string);
}
  
