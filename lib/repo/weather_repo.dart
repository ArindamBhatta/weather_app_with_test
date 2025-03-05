// ignore_for_file: avoid_print

import 'package:weather_app/models/wether_model.dart';
import 'package:weather_app/service/weather_service.dart';

abstract class WeatherRepo {
  static Future<WeatherModel?> getWhetherInfo(String city) async {
    try {
      Map<String, dynamic>? data = await WeatherService.getWeatherData(city);
      if (data != null) {
        WeatherModel weather = WeatherModel.fromJson(data);
        print(weather.main?.temp);
        return weather;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
