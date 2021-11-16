List<ImpactMarker> createImpactList(String source) {
  Table data = loadTable(source, "header");  

  List<ImpactMarker> impacts = new ArrayList<ImpactMarker>();

 for (TableRow row : data.rows()) {
   float latitude = row.getFloat("reclat");
   float longitude = row.getFloat("reclong");
   float mass = row.getFloat("mass (g)");
   String location = row.getString("name");
   String date = row.getString("year");
   String discovered = row.getString("fall").toLowerCase();
   
   if (isValidLocation(latitude, longitude)) {
     impacts.add(new ImpactMarker(latitude, longitude, mass, location, date, discovered));
   }
 }

  return impacts;
}

boolean isValidLocation(float latitude, float longitude) {
  return !(Float.isNaN(latitude) || Float.isNaN(longitude));
}
