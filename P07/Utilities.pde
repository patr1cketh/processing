import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.io.UnsupportedEncodingException;


float milesToKm(float m) {
  final float MILE_PER_KM = 0.6214;
  return  m / MILE_PER_KM;
}


String encodeValue(String value) {
  try {
    return URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
  }
  catch (UnsupportedEncodingException e) {
    return value;
  }
}
