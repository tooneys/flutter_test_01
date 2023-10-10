import 'package:flutter/material.dart';
import 'package:flutter_test_01/utils/validator.dart';

// ignore: must_be_immutable
class TextEditWidget extends StatelessWidget {
  final String label;
  TextEditingController? controller;
  bool? isPassword;

  TextEditWidget({
    super.key,
    required this.label,
    this.controller,
    this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => Validator.validateId(value ?? ""),
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(label),
        hintText: '$label를 입력해 주세요',
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: isPassword ?? false,
    );
  }
}
