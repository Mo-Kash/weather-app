import 'package:flutter/material.dart';
import 'package:world_time/themes/clear_night.dart';
import 'package:world_time/themes/clear_day.dart';
import 'package:world_time/themes/cloudy_day.dart';
import 'package:world_time/themes/cloudy_night.dart';
import 'package:world_time/themes/rainy.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = clearDay; //initially

  ThemeData get themeData => _themeData;
  set themeData(ThemeData themedata){
    _themeData = themedata;
    notifyListeners();
  }
  void changeThemeTo(String condition){
    if(condition=="clear day"){
      _themeData = clearDay;
    }else if(condition=="clear night"){
      _themeData = clearNight;
    }else if(condition=="rainy"){
      _themeData = rainy;
    }else if(condition=="cloudy day"){
      _themeData = cloudyDay;
    }else if(condition=="cloudy night"){
      _themeData = cloudyNight;
    }
    notifyListeners();
  }
}