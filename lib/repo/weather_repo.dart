import 'package:weather_app/models/wether_model.dart';
import 'package:weather_app/service/weather_service.dart';

abstract class WeatherRepo {
  static Future<WeatherModel?> getWhetherInfo() async {
    try {
      Map<String, dynamic>? data = await WeatherService.getWeatherData();
      if (data != null) {
        WeatherModel weather = WeatherModel.fromJson(data);
        return weather;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
