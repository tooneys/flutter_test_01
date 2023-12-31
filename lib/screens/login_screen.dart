import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/main.dart';
import 'package:flutter_test_01/models/user.dart';
import 'package:flutter_test_01/screens/error/something_wrong.dart';
import 'package:flutter_test_01/screens/home_screen.dart';
import 'package:flutter_test_01/screens/noti_screen.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:flutter_test_01/utils/notification.dart';
import 'package:flutter_test_01/utils/token.dart';
import 'package:flutter_test_01/widgets/textedit_widget.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    LocalNotification.init();

    Future.delayed(
      const Duration(seconds: 3),
      LocalNotification.requestNotificationPermission(),
    );

    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final _apiClient = ApiClient();
  late Future<User> _user;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool isAutoLogin = false;

  login() {
    if (_formkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사용자 정보를 확인중 입니다'),
          backgroundColor: Colors.green,
        ),
      );

      _user = _apiClient.login(
        _idController.text,
        _pwController.text,
      );

      _user.then(
        (userValue) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          if (userValue.empName.isNotEmpty) {
            if (isAutoLogin) {
              AuthToken.setAutoLogin(
                  userValue.empName, _idController.text, _pwController.text);
            } else {
              AuthToken.delAutoLogin();
            }

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('로그인 되었습니다.'),
                backgroundColor: Colors.blue,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(user: userValue),
              ),
              (route) => false,
            );
          }
        },
      ).catchError(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('사용자 정보가 없습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: StreamBuilder<String>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SomethingWrong();
          }

          if (snapshot.hasData) {
            if (snapshot.data == 'HELLOWORLD') {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const NotiTestScreen();
                      },
                    ),
                  );
                },
              );
            }
          }

          return Form(
            key: _formkey,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Image(
                            image: AssetImage('assets/images/logo.gif'),
                          ),
                        ),
                        Gap(size.height * 0.03),
                        TextEditWidget(
                          label: 'ID',
                          controller: _idController,
                        ),
                        Gap(size.height * 0.02),
                        TextEditWidget(
                          label: 'Password',
                          controller: _pwController,
                          isPassword: true,
                        ),
                        Gap(size.height * 0.02),
                        Row(
                          children: [
                            Switch(
                              value: isAutoLogin,
                              onChanged: (value) {
                                setState(
                                  () {
                                    isAutoLogin = value;
                                  },
                                );
                              },
                            ),
                            const Gap(10),
                            const Text(
                              '자동로그인',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Gap(size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CupertinoButton.filled(
                                onPressed: login,
                                borderRadius: BorderRadius.circular(10),
                                disabledColor: Colors.grey,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () =>
                                LocalNotification.showNotification(),
                            child: const Text("알람보내기"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
