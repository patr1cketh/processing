Table nouns_table; // table to hold the nouns

String getRandomNoun() {
  nouns_table = loadTable("nouns.csv"); //loads the external csv file into the table
  int random_index_1;
  String noun;
  final int NOUNS_TABLE_LENGTH = nouns_table.getRowCount();
  
  random_index_1 = int(random(NOUNS_TABLE_LENGTH)); // gets a random integer between 0 and the length of the table
   
  noun = nouns_table.getRow(random_index_1) // gets a random noun from the table
                    .getString(0);
  return noun;
}
