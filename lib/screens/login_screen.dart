import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/main.dart';
import 'package:flutter_test_01/models/user.dart';
import 'package:flutter_test_01/screens/home_screen.dart';
import 'package:flutter_test_01/screens/noti_screen.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:flutter_test_01/utils/notification.dart';
import 'package:flutter_test_01/utils/token.dart';
import 'package:flutter_test_01/utils/validator.dart';
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
  late User _user;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool isAutoLogin = false;

  Future<void> login() async {
    try {
      if (_formkey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('사용자 정보를 확인중 입니다'),
            backgroundColor: Colors.green,
          ),
        );

        try {
          _user = await _apiClient.login(
            _idController.text,
            _pwController.text,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('사용자 정보가 없습니다.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (_user.empName.isNotEmpty) {
          if (isAutoLogin) {
            AuthToken.setAutoLogin(
                _user.empName, _idController.text, _pwController.text);
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
              builder: (context) => HomeScreen(user: _user),
            ),
            (route) => false,
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
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
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data == 'HELLOWORLD') {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const NotiTestScreen();
                      }),
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
                        horizontal: 20, vertical: 20),
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
                            child: Image(
                              image: AssetImage('assets/images/logo.gif'),
                              semanticLabel: 'Test',
                            ),
                          ),
                          Gap(size.height * 0.03),
                          TextFormField(
                            validator: (value) =>
                                Validator.validateId(value ?? ""),
                            controller: _idController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('ID'),
                              hintText: 'ID를 입력해 주세요',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Gap(size.height * 0.02),
                          TextFormField(
                            validator: (value) =>
                                Validator.validatePassword(value ?? ""),
                            controller: _pwController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text('Password'),
                              hintText: 'Password를 입력해 주세요',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Gap(size.height * 0.02),
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: isAutoLogin,
                                onChanged: (value) {
                                  setState(() {
                                    isAutoLogin = value ?? false;
                                  });
                                },
                              ),
                              const Gap(10),
                              const Text(
                                '자동로그인',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () =>
                                  LocalNotification.showNotification(),
                              child: Text("알람보내기"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
