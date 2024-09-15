import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesNovle {
  static late SharedPreferences prefs;
  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
