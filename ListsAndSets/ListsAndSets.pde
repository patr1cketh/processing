import java.util.List;
import java.util.Set;
import java.util.HashSet;


final int NUMBER_TO_REPORT = 100;

// Wikipedia keeps track of who has edited which page
// Here we grab the 100 most recent edits
// the only information we need is the title of the page that was edited

final String DATA_SOURCE = "https://en.wikipedia.org/w/api.php" +
                           "?action=query&list=recentchanges&rcprop=title&rclimit=" +
                           NUMBER_TO_REPORT +
                           "&format=json";
      
                           
List<String> titles;

void setup() {
  size(800, 200);
  frameRate(1);
  textAlign(CENTER);
  textFont(createFont("Helvetica", 24));
  
  titles = listOfEditedPages(DATA_SOURCE);
  println("Unique titles edited " + titles.size() + " out of a possible " + NUMBER_TO_REPORT);
  
}

void draw() {
  background(0);
  
  fill(255);
  text(titles.get(int(random(0, titles.size()))), width/2, height/2);
}
