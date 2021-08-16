import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_bloc_demo/bloc/weather_bloc.dart';
import 'package:weather_api_bloc_demo/widget/weather.dart';
import 'package:weather_api_bloc_demo/widget/weather_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Weather Call API Demo'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => WeatherBloc(),
        child: MainPage(),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final cityNameController = TextEditingController();

  WeatherBloc? _weatherBloc;

  @override
  Widget build(BuildContext context) {
    this._weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherIsNotSearched) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cityNameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter a city name then push refresh button'),
                  ),
                ),
              ),
              IconButton(
                icon: new Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  _weatherBloc!.add(FetchWeather(cityNameController.text));
                  cityNameController.clear();
                },
                color: Colors.white,
              ),
            ],
          ),
        );
      } else if (state is WeatherIsLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is WeatherIsLoaded) {
        print(state.getWeather);
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cityNameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter a city name then push refresh button'),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Weather(weather: state.getWeather)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: new Icon(Icons.refresh),
                      tooltip: 'Refresh',
                      onPressed: () {
                        _weatherBloc!
                            .add(FetchWeather(cityNameController.text));
                        cityNameController.clear();
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: state.getForecast.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => WeatherItem(
                        weather: state.getForecast.list.elementAt(index),
                      ),
                    )),
              ),
            ),
          ]),
        );
      } else {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Error! Cannot find city. Pleaser try again!!!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cityNameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter a city name then push refresh button'),
                  ),
                ),
              ),
              IconButton(
                icon: new Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  _weatherBloc!.add(FetchWeather(cityNameController.text));
                  cityNameController.clear();
                },
                color: Colors.white,
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityNameController.dispose();
    _weatherBloc!.close();
  }
}
