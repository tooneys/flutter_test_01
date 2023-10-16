import 'package:flutter/material.dart';
import 'package:flutter_test_01/widgets/custom_button_widget.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/article_not_found.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 260,
            left: 100,
            child: Text(
              'Data Not Found',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Positioned(
            bottom: 190,
            left: 50,
            child: Text(
              'Oops! 데이터가 없네요.',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 120,
            left: 130,
            right: 130,
            child: ReusablePrimaryButton(
              childText: 'Retry',
              buttonColor: Colors.green,
              childTextColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
