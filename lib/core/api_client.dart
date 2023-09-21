import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test_01/models/user.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<User> login(String id, String password) async {
    try {
      Response response = await _dio.get(
        'http://112.171.126.110:4000/api/login?id=$id&pwd=$password',
        //data: {'id': id, 'password': password},
      );

      if (response.statusCode == 200) {
        var user = jsonDecode(response.data);
        return User.fromJson(user[0]);
      } else {
        throw Exception('Failed to Login');
      }
    } on DioException catch (e) {
      //print('[API Error] ${e.response!.data}');
      throw Exception(e.response!.data);
    }
  }
}
