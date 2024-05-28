import 'weather.dart';

class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int groundLevel;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int cloudsAll;
  final int visibility;
  final double pop;
  final double? rainVolume;
  final Weather weather;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.cloudsAll,
    required this.visibility,
    required this.pop,
    this.rainVolume,
    required this.weather,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      seaLevel: json['main']['sea_level'],
      groundLevel: json['main']['grnd_level'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      windDeg: json['wind']['deg'],
      windGust: json['wind']['gust'],
      cloudsAll: json['clouds']['all'],
      visibility: json['visibility'],
      pop: json['pop'],
      rainVolume: json['rain'] != null ? json['rain']['3h'] : null,
      weather: Weather.fromJson(json['weather'][0]),
    );
  }
}
