part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class ThemeChanged extends ThemeEvent {
  final ThemeMode theme;
  ThemeChanged({required this.theme});
}
