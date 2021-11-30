JSONObject movie_data = new JSONObject();;

ArrayList<String> movie_titles; // declare ArrayList

Table movie_lines, movie_list; // declare tables

movie_list = loadTable("movie_titles_metadata_header.csv", "header");
  movie_lines = loadTable("movie_lines_header.csv", "header");

ArrayList<String> movie_names = new ArrayList<>();
  JSONObject movie = new JSONObject();
  JSONObject character;
  JSONObject characters = new JSONObject();
  JSONArray lines_array;
  StringList movie_ids = new StringList();
  
  // create a list of movieIDs
  for (TableRow row : movie_list.rows()) movie_ids.append(row.getString("MovieID"));
  
  // for each movie
  for (String movie_id : movie_ids) {
    
    // create a list of unique character ids
    StringList character_ids = new StringList();
    StringList unique_ids = new StringList();
    for (TableRow row : movie_lines.findRows(movie_id, "MovieID")) character_ids.append(row.getString("CharacterID"));
    for (String id : character_ids) if (!unique_ids.hasValue(id)) unique_ids.append(id);
    
    TableRow row = movie_list.findRow(movie_id, "MovieID");
    movie.setString("movieName", row.getString("MovieName")); // set the name
    
    // for each character id
    for (String id : unique_ids) {
     character = new JSONObject(); // create a new character object
     
     character.setString("characterName", movie_lines.findRow(id, "CharacterID").getString("CharacterName")); //set the name
     lines_array = new JSONArray(); // create a new lines array
     for (TableRow line_row : movie_lines.findRows(id, "CharacterID")) lines_array.append(line_row.getString("MovieLine")); // append the lines
     character.setJSONArray("lines", lines_array); //set the lines array to the character object
     characters.setJSONObject(id, character);
    }
 movie.setJSONObject("characters", characters); // 
 movie_data.setJSONObject(movie_id, movie);
  }
