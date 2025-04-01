import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeChosen> {
  ThemeBloc() : super(ThemeChosen(theme: ThemeMode.system)) {
    _loadTheme();
    on<ThemeChanged>((event, emit) async {
      emit(ThemeChosen(theme: event.theme));
      await _saveTheme(event.theme);
    });
  }

  Future<void> _loadTheme() async {
    final SharedPrefs = await SharedPreferences.getInstance();
    final SavedMode = SharedPrefs.getString("themeMode") ?? 'system';

    final ThemeMode ChosenTheme;
    switch (SavedMode) {
      case 'system':
        ChosenTheme = ThemeMode.system;
        break;
      case 'dark':
        ChosenTheme = ThemeMode.dark;
        break;
      case 'light':
        ChosenTheme = ThemeMode.light;
        break;
      default:
        ChosenTheme = ThemeMode.system;
        break;
    }

    add(ThemeChanged(theme: ChosenTheme));
  }

  Future<void> _saveTheme(ThemeMode theme) async {
    final String SaveModeString;
    switch (theme) {
      case ThemeMode.system:
        SaveModeString = "system";
        break;
      case ThemeMode.dark:
        SaveModeString = "dark";
        break;
      case ThemeMode.light:
        SaveModeString = "light";
        break;
    }

    final SharedPrefs = await SharedPreferences.getInstance();
    SharedPrefs.setString("themeMode", SaveModeString);
  }
}
