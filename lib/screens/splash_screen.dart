import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/models/user.dart';
import 'package:flutter_test_01/screens/home_screen.dart';
import 'package:flutter_test_01/screens/login_screen.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _apiClient = ApiClient();
  late Future<bool> isToken;
  late User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isToken = _autoLoginCheck();
  }

  Future<bool> _autoLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? id = prefs.getString('id');
    final String? password = prefs.getString('password');

    if (token != null && token.isNotEmpty) {
      _user = await _apiClient.login(id!, password!);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: FutureBuilder<bool>(
        future: isToken,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return HomeScreen(user: _user);
            }
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
