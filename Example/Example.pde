import rita.*; //<>//

Table movieLines, movieList;


void setup() {
  size(960, 540);


  movieList = loadTable("movie_titles_metadata_header.csv", "header");
  movieLines = loadTable("movie_lines_header.csv", "header");
  
  int randomLine = int(random(0, movieLines.getRowCount()));
  String theLine = movieLines.getRow(randomLine).getString("MovieLine");
  
  String [] partsOfSpeech = RiTa.pos(theLine); 

  println("Movie Line:");
  println(theLine);
  println(partsOfSpeech);
}
