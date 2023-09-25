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
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: userInfoOnTap,
            icon: Icon(Icons.person_3_sharp),
          ),
          IconButton(
            onPressed: logout,
            icon: Icon(
              Icons.logout_sharp,
            ),
          ),
        ],
        elevation: 0,
        leading: Icon(Icons.menu_sharp),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            height: 80,
            padding: EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange,
                      ),
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red.withOpacity(0.2),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.person),
                      iconSize: 20,
                      onPressed: () {},
                    ),
                  ],
                ),
                Gap(20),
                Text(
                  '${user.empName} 님 환영합니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    physics: BouncingScrollPhysics(),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 3,
                    children: [
                      MenuIconWidget(
                        color: Colors.red.withOpacity(0.4),
                        menuName: '주문분석',
                        icon: Icons.auto_graph,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrderAnalysisScreen(),
                            ),
                          );
                        },
                      ),
                      MenuIconWidget(
                        color: Colors.orange.shade200,
                        menuName: '일별주문금액',
                        icon: Icons.view_compact,
                        onTap: () {},
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
