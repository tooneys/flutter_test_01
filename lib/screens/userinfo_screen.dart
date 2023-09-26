import 'package:flutter/material.dart';
import 'package:flutter_test_01/core/api_client.dart';
import 'package:flutter_test_01/screens/login_screen.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:flutter_test_01/utils/token.dart';

class UserInfoScreen extends StatefulWidget {
  final String empCode;
  const UserInfoScreen({
    super.key,
    required this.empCode,
  });

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _apiClient = ApiClient();
  late Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    userData = _apiClient.getUserInfo(widget.empCode);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    void logout() {
      AuthToken.delAutoLogin();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('로그아웃 되었습니다.'),
          backgroundColor: Colors.green,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          '사용자 정보',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: FutureBuilder<Map<String, dynamic>>(
                  future: userData,
                  builder: (context, snapshot) {
                    Map<String, dynamic>? data = snapshot.data;

                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      if (data != null) {
                        return Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data["cD_EMP"]} / ${data["nM_USER"]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                '입사일 : ${data["dT_SDATE"]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                data["nM_DEPT"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                data["nO_TEL"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                data["nO_MOBILE"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                data["tX_EMAIL"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }

                    return const Text(
                      'No Data Found',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
