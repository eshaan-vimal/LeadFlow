import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeCubit extends Cubit<ThemeMode> 
{
  ThemeCubit() : super(ThemeMode.system) 
  {
    _loadTheme();
  }

  static const _key = 'is_dark_mode';


  void toggleTheme() async 
  {
    final prefs = await SharedPreferences.getInstance();
    if (state == ThemeMode.dark) 
    {
      await prefs.setBool(_key, false);
      emit(ThemeMode.light);
    } 
    else 
    {
      await prefs.setBool(_key, true);
      emit(ThemeMode.dark);
    }
  }


  void _loadTheme() async 
  {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key);
    if (isDark != null) 
    {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    }
  }
}