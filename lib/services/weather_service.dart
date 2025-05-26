import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:world_time/main.dart';
import 'package:world_time/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{

  final String location;
  final String apiKey;
  late double temp;
  late String mainCondition;


  WeatherService(
      this.apiKey,
      this.location
  );

  Future<void> getWeather() async{
    try{
      final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric'));
      if(response.statusCode == 200){
        Map<String, dynamic> weatherData = jsonDecode(response.body);
        temp = weatherData['main']['temp'].toDouble();
        mainCondition = weatherData['weather'][0]['main'];
      }else{
        throw Exception('Failed to load weather data');
      }
    }catch(e){
      throw Exception("Error fetching weather data: $e");
    }
  }

  static Future<String> getCurrentCity() async{
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //fetch current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
        )
    );

    //convert location into list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract city name from first placemark
    String? city = placemarks[0].locality;

    print("City: ${city}");

    return city ?? "";//empty string if null
  }

}