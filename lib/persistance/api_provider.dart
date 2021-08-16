import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:weather_api_bloc_demo/model/forecast.dart';
import 'package:weather_api_bloc_demo/model/weather.dart';

class ApiProvider {
  Client client = Client();

  Future<WeatherData> fetchWeatherFromCityName(String cityName) async {
    final weatherResponse = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=a02ea4f6aad11d6660d47fd3f2a98d1b'));

    if (weatherResponse.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(weatherResponse.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<ForecastData> fetchForecastFromCityName(String cityName) async {
    final forecastResponse = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=a02ea4f6aad11d6660d47fd3f2a98d1b'));

    if (forecastResponse.statusCode == 200) {
      return ForecastData.fromJson(jsonDecode(forecastResponse.body));
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
