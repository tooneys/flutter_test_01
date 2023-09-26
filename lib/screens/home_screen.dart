import 'package:flutter/material.dart';
import 'package:flutter_test_01/models/user.dart';
import 'package:flutter_test_01/screens/orderanalysis_screen.dart';
import 'package:flutter_test_01/screens/userinfo_screen.dart';
import 'package:flutter_test_01/utils/constants.dart';
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
        title: const Text(
          'HOME',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            height: 80,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurple.withOpacity(.3),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.deepPurple.withOpacity(.1),
                            offset: const Offset(5, 8),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      iconSize: 30,
                      onPressed: userInfoOnTap,
                    ),
                  ],
                ),
                const Gap(10),
                Text(
                  '${user.empName} 님 환영합니다.',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    physics: const BouncingScrollPhysics(),
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
