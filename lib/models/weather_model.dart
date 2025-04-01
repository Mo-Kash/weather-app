class Weather{
  final String location;
  final double temp;
  final String mainCondition;

  Weather({
    required this.location,
    required this.temp,
    required this.mainCondition
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      location: json["name"],
      temp: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}