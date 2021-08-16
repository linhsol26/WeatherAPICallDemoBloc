import 'package:equatable/equatable.dart';
import 'package:weather_api_bloc_demo/model/forecast.dart';
import 'package:weather_api_bloc_demo/model/weather.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_api_bloc_demo/persistance/api_provider.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchWeather extends WeatherEvent {
  final _cityName;

  FetchWeather(this._cityName);

  @override
  // TODO: implement props
  List<Object?> get props => [_cityName];
}

class ResetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;
  final _forecast;

  WeatherIsLoaded(this._weather, this._forecast);

  WeatherData get getWeather => _weather;
  ForecastData get getForecast => _forecast;

  @override
  // TODO: implement props
  List<Object?> get props => [_weather, _forecast];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  ApiProvider api = ApiProvider();

  WeatherBloc() : super(WeatherIsNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherIsLoading();
      try {
        print('did it get');
        WeatherData _weatherData =
            await api.fetchWeatherFromCityName(event._cityName);
        ForecastData _forecastData =
            await api.fetchForecastFromCityName(event._cityName);
        yield WeatherIsLoaded(_weatherData, _forecastData);
      } catch (e) {
        print(e);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
