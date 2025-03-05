// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constant/api_end_points.dart';

class WeatherService {
  static Future<Map<String, dynamic>?> fetchLatLongUsingName(
      String city) async {
    final Uri uri = Uri.parse(
      '$baseUri/geo/1.0/direct?q=$city&limit=1&appid=$apiKey',
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> locationNameData = json.decode(response.body);

        if (locationNameData.isNotEmpty) {
          List<dynamic> geoData = locationNameData;

          var geoLocation = {
            'lat': geoData[0]['lat'],
            'lon': geoData[0]['lon']
          };
          return geoLocation;
        }
      } else {
        print('Failed to fetch location data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getWeatherData(String city) async {
    final coordinates = await fetchLatLongUsingName(city);

    if (coordinates == null) {
      print('No Coordinates are found for $city');
      return null;
    }

    final Uri uri = Uri.parse(
      '$baseUri/data/2.5/weather?lat=${coordinates['lat']}&lon=${coordinates['lon']}&appid=$apiKey&units=metric',
    );
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = jsonDecode(response.body);

        return weatherData;
      } else {
        print('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
    return null;
  }
}
