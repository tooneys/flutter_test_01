import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  static void setAutoLogin(String token, String id, String pw) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('id', id);
    await prefs.setString('password', pw);
  }

  static void delAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('id');
    await prefs.remove('password');
  }
}
