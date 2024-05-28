import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/forecast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = '6f113c0b8ac8d863206b6cf6cb7c3e8b'; // OpenWeatherMap API key
  Forecast? forecast;
  String backgroundImage = 'clear_sky.jpg';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getWeather(position.latitude, position.longitude);
  }

  Future<void> getWeather(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          forecast = Forecast.fromJson(data);
          backgroundImage =
              getBackgroundImage(forecast!.items[0].weather.description);
        });
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }

  String getBackgroundImage(String weatherDescription) {
    switch (weatherDescription.toLowerCase()) {
      case 'clear sky':
        return 'clear_sky.jpg';
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return 'cloudy.jpg';
      case 'shower rain':
      case 'rain':
        return 'rainy.jpg';
      case 'thunderstorm':
        return 'stormy.jpg';
      case 'snow':
        return 'snowy.jpg';
      case 'mist':
        return 'cloudy.jpg';
      default:
        return 'default.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$backgroundImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: forecast == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Location: ${forecast!.city.name}, ${forecast!.city.country}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Weather: ${forecast!.items[0].weather.description}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Temperature: ${forecast!.items[0].temperature.temp} °C',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
