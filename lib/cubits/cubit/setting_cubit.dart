import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_list/core/data/global_data.dart';
import 'package:task_list/core/utils/utils.dart';
import 'package:task_list/cubits/cubit/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  Box box = Hive.box("settings");

  Future<void> setTheme(String theme) async {
    themeMode = getTheme(theme);
    await box.put('theme', theme);
    emit(ThemeChange());
  }

  

  Future<void> changeLanguage(String language) async {
    lang = language;
    await box.put('language', lang);
    emit(ChangeLanguage()); // This triggers the rebuild for all listeners
  }
}
