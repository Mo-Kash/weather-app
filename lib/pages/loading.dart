import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/weather_service.dart';
import 'package:world_time/themes/theme_provider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTimeAndWeather() async{
    try{
      String current = await WeatherService.getCurrentCity();

      WorldTime instance = WorldTime(location: current, flag: '', url:'Asia%2FKolkata');
      await instance.getTime();

      WeatherService weather = WeatherService("d43e08bc706987759beea6ba55c6c911", instance.location);
      await weather.getWeather();

      instance.time = DateFormat.jm().format(DateTime.now());
      instance.isDayTime = (DateTime.now().hour> 6 && DateTime.now().hour < 19);

      Navigator.pushNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
        'temperature': weather.temp,
        'weatherCondition':weather.mainCondition
      });

      switch (weather.mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          if (instance.isDayTime) {
            Provider.of<ThemeProvider>(context, listen: false).changeThemeTo("cloudy day");
          } else {
            Provider.of<ThemeProvider>(context, listen: false).changeThemeTo("cloudy night");
          }
        case 'clear':
          if (instance.isDayTime) {
            Provider.of<ThemeProvider>(context, listen: false).changeThemeTo("clear day");
          } else {
            Provider.of<ThemeProvider>(context, listen: false).changeThemeTo("clear night");
          }
        case 'rain':
        case 'drizzle':
        case 'shower rain':
        case 'thunderstorm':
          Provider.of<ThemeProvider>(context, listen: false).changeThemeTo("rainy");
      }

    }catch(e){
      print('Error in initial setup: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTimeAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[800],
      body: Center(
        child: SpinKitWave(
          color: Colors.yellow,
          size: 80.0,
        ),
      ),
    );
  }
}
