import 'package:flutter/material.dart';
import 'package:flutter_test_01/widgets/custom_button_widget.dart';

class SomethingWrong extends StatelessWidget {
  const SomethingWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/something_wrong.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 230,
            left: 160,
            child: Text(
              'Oops!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Positioned(
            bottom: 170,
            left: 100,
            child: Text(
              'Something went wrong,\nplease try again.',
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
            bottom: 100,
            left: 130,
            right: 130,
            child: ReusablePrimaryButton(
              childText: 'Try Again',
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
