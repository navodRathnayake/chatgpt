part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ThemeModeChanged extends SettingsEvent {
  final AppThemeMode themeModeStatus;
  const ThemeModeChanged({required this.themeModeStatus});
}

class FontSizeChanged extends SettingsEvent {
  final double sliderValue;
  const FontSizeChanged({required this.sliderValue});
}
