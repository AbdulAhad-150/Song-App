import 'package:flutter/material.dart';
import 'package:songweb/themes/dark_mode.dart';
import 'package:songweb/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initially , light mode 
  ThemeData _themeData = LightMode;

  //get theme 
  ThemeData get themeData =>_themeData;
  
  // is dark mode
  bool get isDarkMode =>_themeData ==DarkMode;

  // set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;

    //update UI
    notifyListeners();
  }


  // toggle theme
  void toggleTheme (){
    if (_themeData == LightMode) {
      themeData = DarkMode;
    }else{
      themeData = LightMode;
    }
  }
}