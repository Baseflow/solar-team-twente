import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core.dart';

/// Theme cubit to manage the theme state.
class ThemeCubit extends Cubit<AppThemeMode> {
  /// Creates a new theme cubit.
  ThemeCubit(this._themeService) : super(AppThemeMode.system);

  /// Theme repository to manage the theme state.
  final ThemeService _themeService;

  /// Load the theme from the repository.
  void loadTheme() {
    final AppThemeMode mode = _themeService.getSavedThemeMode();
    emit(mode);
  }

  /// Update the current theme.
  Future<void> updateTheme(AppThemeMode? themeMode) async {
    if (themeMode == null) return;
    await _themeService.saveThemeMode(themeMode);
    emit(themeMode);
  }
}
