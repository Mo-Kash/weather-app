import 'package:flutter/material.dart';
import 'package:world_time/models/weather_model.dart';
import 'package:world_time/services/weather_service.dart';
import 'package:world_time/services/world_time.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe%2FLondon', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe%2FBerlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(url: 'Europe%2FAthens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Europe%2FMadrid', location: 'Madrid', flag: 'spain.png'),

    WorldTime(url: 'Australia%2FAdelaide', location: 'Adelaide', flag: 'australia.png'),
    WorldTime(url: 'Australia%2FBrisbane', location: 'Brisbane', flag: 'australia.png'),
    WorldTime(url: 'Australia%2FCanberra', location: 'Canberra', flag: 'australia.png'),
    WorldTime(url: 'Australia%2FMelbourne', location: 'Melbourne', flag: 'australia.png'),
    WorldTime(url: 'Australia%2FPerth', location: 'Perth', flag: 'australia.png'),

    WorldTime(url: 'Africa%2FCairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa%2FNairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'Africa%2FLusaka', location: 'Lusaka', flag: 'zambia.png'),
    WorldTime(url: 'Africa%2FMaseru', location: 'Maseru', flag: 'lesotho.png'),

    WorldTime(url: 'America%2FChicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America%2FDetroit', location: 'Detroit', flag: 'usa.png'),
    WorldTime(url: 'America%2FLos_Angeles', location: 'Los Angeles', flag: 'usa.png'),
    WorldTime(url: 'America%2FNew_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'America%2FPhoenix', location: 'Phoenix', flag: 'usa.png'),
    WorldTime(url: 'America%2FVancouver', location: 'Vancouver', flag: 'usa.png'),

    WorldTime(url: 'Asia%2FBangkok', location: 'Bangkok', flag: 'thailand.png'),
    WorldTime(url: 'Asia%2FDubai', location: 'Dubai', flag: 'united-arab-emirates.png'),
    WorldTime(url: 'Asia%2FHong_Kong', location: 'Hong Kong', flag: 'hong-kong.png'),
    WorldTime(url: 'Asia%2FJakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Indian%2FMaldives', location: 'Maldives', flag: 'maldives.png'),
    WorldTime(url: 'Asia%2FSeoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia%2FSingapore', location: 'Singapore', flag: 'singapore.png'),
    WorldTime(url: 'Asia%2FTokyo', location: 'Tokyo', flag: 'japan.png'),

    WorldTime(location: 'Ahmedabad', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Aurangabad', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Bangalore', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Chandigarh', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Chennai', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Delhi', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Goa', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Jaipur', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Kolkata', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Manali', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Mumbai', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Puducherry', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Pune', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Rajkot', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Thiruvananthapuram', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Vadodara', flag: 'india.png', url: 'Asia%2FKolkata'),
    WorldTime(location: 'Vellore', flag: 'india.png', url: 'Asia%2FKolkata'),
  ];

  void updateTimeAndWeather(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    WeatherService weather = WeatherService("d43e08bc706987759beea6ba55c6c911", instance.location);
    await weather.getWeather();

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
        Provider.of<ThemeProvider>(context, listen: false).changeThemeTo(
            "rainy");
      }
        //navigate to home screen
        Navigator.pop(context, {
          'location': instance.location,
          'flag': instance.flag,
          'time': instance.time,
          'isDayTime': instance.isDayTime,
          'temperature': weather.temp,
          'weatherCondition': weather.mainCondition,
        });
      print(instance.isDayTime);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Choose a location"),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                child: ListTile(
                  onTap: () {
                    updateTimeAndWeather(index);
                  },
                  title: Text(
                      locations[index].location,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/country_flags/${locations[index].flag}"),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
