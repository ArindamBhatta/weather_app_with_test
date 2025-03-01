// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:weather_app/constant/api_end_points.dart';
import 'package:weather_app/models/geo_data.dart';

class WeatherRepo {
  static Future<void> getGeoData(String city) async {
    final Uri uri = Uri.parse(
      '$baseUri/geo/1.0/direct?q=$city&limit=1&appid=$apiKey',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<DataModelProperty> geoDataList = geoData(response.body);

        for (var geoData in geoDataList) {
          print(
              'City: ${geoData.name}, Country: ${geoData.country}, Lat: ${geoData.lat}, Lon: ${geoData.lon}');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  static Future<void> getWeatherData() async {
    final Uri uri = Uri.parse(
      '$baseUri/data/2.5/weather?lat=44.34&lon=10.99&appid=$apiKey',
    );
    print(uri);
  }
}
