class City {
  final int id;
  final String name;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
