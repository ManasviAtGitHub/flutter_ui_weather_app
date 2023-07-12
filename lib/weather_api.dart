

import 'package:weather_ui/weather_model.dart';

import 'enums.dart';


class WeatherApi{

  /*
  * list of weather data
  * */
  List<WeatherModel> weatherList = [
    WeatherModel(
      cityName: 'Panvel',
      temperature: 30,
      weatherState: WeatherState.clear,
      humidity: 40,
      windSpeed: 25,
      chanceOfRain: 10,
    ),
    WeatherModel(
      cityName: 'Mumbai',
      temperature: 16,
      weatherState: WeatherState.heavyCloud,
      humidity: 60,
      windSpeed: 10,
      chanceOfRain: 85,
    ),
    WeatherModel(
      cityName: 'Thane',
      temperature: 14,
      weatherState: WeatherState.heavyRain,
      humidity: 10,
      windSpeed: 30,
      chanceOfRain: 98,
    ),
    WeatherModel(
      cityName: 'Vashi',
      temperature: 20,
      weatherState: WeatherState.lightCloud,
      humidity: 40,
      windSpeed: 20,
      chanceOfRain: 60,
    ),
    WeatherModel(
      cityName: 'Virar',
      temperature: 28,
      weatherState: WeatherState.lightRain,
      humidity: 70,
      windSpeed: 12,
      chanceOfRain: 75,
    ),


  ];


  String getCityName(int index){
    return weatherList[index].cityName;
  }

  String getImageUrl(int index){
    WeatherState weatherState = weatherList[index].weatherState;
    if (weatherState == WeatherState.heavyCloud) {
      return 'assets/heavycloud.png';
    } else if (weatherState == WeatherState.lightRain) {
      return 'assets/lightrain.png';
    } else if (weatherState == WeatherState.heavyRain) {
      return 'assets/heavyrain.png';
    } else if (weatherState == WeatherState.clear) {
      return 'assets/clear.png';
    } else if (weatherState == WeatherState.lightCloud) {
      return 'assets/lightcloud.png';
    } else {
      return 'assets/clear.png';
    }
  }

  String getTemperature(int index){
    int temp = weatherList[index].temperature.toInt();
    return '$temp°';
  }


  String weatherType(int index){
    WeatherState weatherState = weatherList[index].weatherState;
    if (weatherState == WeatherState.heavyCloud) {
      return 'Heavy Cloud';
    } else if (weatherState == WeatherState.lightRain) {
      return 'Light Rain';
    } else if (weatherState == WeatherState.heavyRain) {
      return 'Heavy Rain';
    } else if (weatherState == WeatherState.clear) {
      return 'Clear Sky';
    } else if (weatherState == WeatherState.lightCloud) {
      return 'Light Cloud';
    } else {
      return 'Clear';
    }
  }

  String getHumidity(int index){
    int humidity = weatherList[index].humidity;
    return '$humidity%';
  }

  String getWindSpeed(int index){
    int windSpeed = weatherList[index].windSpeed;
    return '$windSpeed km/h';
  }

  String getChanceOfRain(int index){
    int chanceOfRain = weatherList[index].chanceOfRain;
    return '$chanceOfRain%';
  }


  String getMessage(int index) {
    double temp = weatherList[index].temperature;
    if (temp > 28) {
      return 'It\'s 🍦 time';
    } else if (temp > 18) {
      return 'Time for shorts and 👕';
    } else if (temp < 16) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }





}