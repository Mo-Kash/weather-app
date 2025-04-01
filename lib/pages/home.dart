import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  String getWeatherAnimation(String? mainCondition, bool isDayTime){
    if(mainCondition==null) return "assets/animations/sunny_animation.json";

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        if(isDayTime) return "assets/animations/cloudy_day_animation.json";
        else return "assets/animations/cloudy_night_animation.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return "assets/animations/rainy_animation.json";
      case 'clear':
        if(isDayTime) return "assets/animations/sunny_animation.json";
        else return "assets/animations/clear_night_animation.json";
      default:
        return "assets/animations/sunny_animation.json";
    }
  }

  @override
  Widget build(BuildContext context) {

    try {
      data = data.isNotEmpty? data: ModalRoute.of(context)!.settings.arguments as Map;
    }
    catch(e){
      data=data;
    }
    print(data);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: [
                    TextButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time':result['time'],
                            'location':result['location'],
                            'isDayTime':result['isDayTime'],
                            'flag':result['flag'],
                            'temperature':result['temperature'],
                            'weatherCondition':result['weatherCondition']
                          };
                        });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      label: Text(
                          "Change Location",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['location'],
                          style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 2,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 36,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ),
                    SizedBox(height: 20),
                    Text(
                        '${data['temperature'].toString()}°C',
                        style: TextStyle(
                          fontSize: 66,
                          color: Theme.of(context).colorScheme.primary,
                        )
                    ),
                    SizedBox(height: 10),
                    Lottie.asset(getWeatherAnimation(data['weatherCondition'], data['isDayTime'])),
                    Text(
                        data['weatherCondition'],
                        style: TextStyle(
                          fontSize: 56,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
