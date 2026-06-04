import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final autoDarkModeOption = prefs.getString('autoDarkModeOption') ?? 'Off';

    emit(
      ThemeChanged(
        isDarkMode: isDarkMode,
        autoDarkModeOption: autoDarkModeOption,
      ),
    );
  }

  Future<void> toggleTheme() async {
    if (state.autoDarkModeOption == 'System Setting') return;

    final isDark = !state.isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    emit(
      ThemeChanged(
        isDarkMode: isDark,
        autoDarkModeOption: state.autoDarkModeOption,
      ),
    );
  }

  Future<void> setDarkMode() async {
    if (state.autoDarkModeOption == 'System Setting') return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', true);
    emit(
      ThemeChanged(
        isDarkMode: true,
        autoDarkModeOption: state.autoDarkModeOption,
      ),
    );
  }

  Future<void> setLightMode() async {
    if (state.autoDarkModeOption == 'System Setting') return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', false);
    emit(
      ThemeChanged(
        isDarkMode: false,
        autoDarkModeOption: state.autoDarkModeOption,
      ),
    );
  }

  Future<void> updateAutoDarkModeOption(String option) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('autoDarkModeOption', option);
    emit(
      ThemeChanged(isDarkMode: state.isDarkMode, autoDarkModeOption: option),
    );
  }
}
