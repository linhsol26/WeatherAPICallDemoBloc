import 'package:weather_api_bloc_demo/model/forecast.dart';
import 'package:weather_api_bloc_demo/model/weather.dart';
import 'package:weather_api_bloc_demo/persistance/api_provider.dart';

class Repository {
  ApiProvider api = ApiProvider();

  Future<WeatherData> fetchWeatherFromCityName(String cityName) =>
      api.fetchWeatherFromCityName(cityName);

  Future<ForecastData> fetchForecastFromCityName(String cityName) =>
      api.fetchForecastFromCityName(cityName);
}
