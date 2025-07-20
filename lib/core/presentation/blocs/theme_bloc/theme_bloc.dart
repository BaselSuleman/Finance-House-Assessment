import 'package:bloc/bloc.dart';
import 'package:finance_house_assessment/core/presentation/blocs/theme_bloc/theme_event.dart';
import 'package:finance_house_assessment/core/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasource/theme_local_datasource.dart';

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeLocalDataSource themeLocalDataSource;

  bool _isDark = true;

bool get isDark=> _isDark;
  ThemeBloc({
    required this.themeLocalDataSource,

  }) : super(ThemeInitial(
          isDarkMode: themeLocalDataSource.getCurrentAppTheme() ?? true,
        )) {
    _isDark = false;
    on<ChangeThemeEvent>(
      (event, emit) async {
        final result =
            await themeLocalDataSource.changeAppTheme(event.isDarkMode);
        if (result) {
          if (event.isDarkMode) {
            _isDark =  event.isDarkMode;
            emit(DarkThemeState());
          } else {
            _isDark =  event.isDarkMode;
            emit(LightThemeState());
          }
        }
      },
    );
  }
}
