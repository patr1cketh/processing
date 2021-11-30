
List<String> listOfEditedPages(String source) {
  JSONObject data = loadJSONObject(source);

  // create a Set as we only want to add a title once
  Set<String> titles = new HashSet<>();

  JSONArray changes = data.getJSONObject("query").getJSONArray("recentchanges");
  
  for (int i = 0; i < changes.size(); i += 1) {
    JSONObject change = changes.getJSONObject(i);

    String title = change.getString("title");
    
    // a Set is a Collection so we can use it in some of the same ways as a List
    titles.add(title);
  }
  
  // create a List from the Set (titles is a Set<String>) but function returns a List<String>
  return new ArrayList(titles);  
}
