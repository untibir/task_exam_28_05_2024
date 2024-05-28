class Forecast {
  final City city;
  final List<WeatherItem> items;

  Forecast({required this.city, required this.items});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      city: City.fromJson(json),
      items: [WeatherItem.fromJson(json)],
    );
  }
}

class City {
  final String name;
  final String country;

  City({required this.name, required this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      country: json['sys']['country'],
    );
  }
}

class WeatherItem {
  final Temperature temperature;
  final Weather weather;

  WeatherItem({required this.temperature, required this.weather});

  factory WeatherItem.fromJson(Map<String, dynamic> json) {
    return WeatherItem(
      temperature: Temperature.fromJson(json['main']),
      weather: Weather.fromJson(json['weather'][0]),
    );
  }
}

class Temperature {
  final double temp;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;

  Temperature(
      {required this.temp,
      required this.feelsLike,
      required this.minTemp,
      required this.maxTemp});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      minTemp: json['temp_min'].toDouble(),
      maxTemp: json['temp_max'].toDouble(),
    );
  }
}

class Weather {
  final String description;
  final String icon;

  Weather({required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
      icon: json['icon'],
    );
  }
}
