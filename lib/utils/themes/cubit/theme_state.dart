part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  final bool isDarkMode;
  final String autoDarkModeOption;

  const ThemeState({
    required this.isDarkMode,
    required this.autoDarkModeOption,
  });

  @override
  List<Object> get props => [isDarkMode, autoDarkModeOption];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(isDarkMode: false, autoDarkModeOption: 'Off');
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged({
    required super.isDarkMode,
    required super.autoDarkModeOption,
  });
}
