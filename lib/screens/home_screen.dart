import 'package:flutter/material.dart';
import 'package:flutter_test_01/models/user.dart';
import 'package:flutter_test_01/screens/login_screen.dart';
import 'package:flutter_test_01/screens/orderanalysis_screen.dart';
import 'package:flutter_test_01/screens/userinfo_screen.dart';
import 'package:flutter_test_01/utils/constants.dart';
import 'package:flutter_test_01/utils/token.dart';
import 'package:flutter_test_01/widgets/menu_widget.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({
    super.key,
    required this.user,
  });

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

    void userInfoOnTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            empCode: user.empCode,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //alignment: Alignment.centerRight,
                        child: Text(
                          '${user.empName} 님 환영합니다.',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: userInfoOnTap,
                        icon: const Icon(
                          Icons.person_rounded,
                        ),
                        iconSize: 35.0,
                      ),
                      IconButton(
                        onPressed: logout,
                        icon: const Icon(
                          Icons.logout,
                        ),
                        iconSize: 35.0,
                      ),
                    ],
                  ),
                ),
                Gap(size.height * 0.01),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    physics: BouncingScrollPhysics(),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrderAnalysisScreen(),
                            ),
                          );
                        },
                        child: MenuIconWidget(
                          color: Colors.red.withOpacity(0.4),
                          menuName: '주문분석',
                          icon: Icons.auto_graph,
                        ),
                      ),
                      MenuIconWidget(
                        color: Colors.orange.shade200,
                        menuName: '일별주문금액',
                        icon: Icons.view_compact,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
