List<EarthquakeMarker> createEarthquakeList(String source) {
  JSONObject data = loadJSONObject(source);

  List<EarthquakeMarker> earthquakes = new ArrayList<>();

  JSONArray features = data.getJSONArray("features");

  for (int i = 0; i < features.size(); i += 1) {
    
    JSONObject feature = features.getJSONObject(i);
    JSONObject properties = feature.getJSONObject("properties");
    JSONObject geometry = feature.getJSONObject("geometry");
    
    String location = properties.getString("place");
    long date = properties.getLong("time");
    
    float latitude = geometry.getJSONArray("coordinates").getFloat(1);
    float longitude = geometry.getJSONArray("coordinates").getFloat(0);
    float magnitude = properties.isNull("mag") ? Float.NaN : properties.getFloat("mag");

    if (isValidLocation(latitude, longitude) && isValidMagnitude(magnitude)) {
      earthquakes.add(new EarthquakeMarker(latitude, longitude, magnitude, location, date));
    }
  }

  return earthquakes;
}

boolean isValidLocation(float latitude, float longitude) {
  return !(Float.isNaN(latitude) || Float.isNaN(longitude));
}

boolean isValidMagnitude(float magnitude) {
  return !Float.isNaN(magnitude);
}
