

import 'package:weather_ui/enums.dart';

class WeatherModel{
  String cityName;
  double temperature;
  WeatherState weatherState;
  int humidity;
  int windSpeed;
  int chanceOfRain;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherState,
    required this.humidity,
    required this.windSpeed,
    required this.chanceOfRain,
  });
}