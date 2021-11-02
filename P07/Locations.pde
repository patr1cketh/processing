// Location information from GeoDB
// For a demo of the API see
// http://geodb-cities-api.wirefreethought.com/demo

void showLocation() {
  String information = formatInformationFromGeoDB();
  gui.showInfoDialog(information);
}

String formatInformationFromGeoDB() {
  JSONObject geoInformation = getExternalDataFromGeoDB();
  String result = "No place found within 100 km";
  
  if (geoInformation.getJSONArray("data").size() > 0) {
    JSONObject place = geoInformation.getJSONArray("data").getJSONObject(0);
    result = String.format("The nearest (%2.1f km) location is %s, %s, %s", 
                           place.getFloat("distance"),
                           place.getString("city"),
                           place.getString("region"),
                           place.getString("country"));
  }
  println(geoInformation);
  return result;
}


JSONObject getExternalDataFromGeoDB() {
  final String ENDPOINT = "http://geodb-free-service.wirefreethought.com/v1/geo/cities?";
  final String OPTIONS = "&hateoasMode=false&limit=1&offset=0&radius=61";
  
  String location = "location=" + form.getByIndex(LATITUDE_INDEX).asString()
                                + getFormattedLongitude(form.getByIndex(LONGITUDE_INDEX).asInt());

  return loadJSONObject(ENDPOINT + location + OPTIONS);
}

String getFormattedLongitude(int longitude) {
  String formattedLongitude = str(longitude);
  
  if (longitude >= 0) {
    formattedLongitude = encodeValue("+" + longitude);
  }
  
  return formattedLongitude;
}
