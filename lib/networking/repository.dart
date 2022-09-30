import 'package:dio/dio.dart';
import 'package:dio_demo_app/model/user_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'error_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

// TODO: Add methods
  Future<UserResponse?> getUser({required String id}) async {
    UserResponse? user;
    try {
      Response response = await _dio.get('/users/$id');
      if (kDebugMode) {
        print('User Info: ${response.statusCode}');
      }
      // Parsing the raw JSON data to the User class
      user = UserResponse.fromJson(response.data);
    } catch (e) {
      var errorMsg = ErrorHelper.handleError(e);
      debugPrint('error helper $errorMsg');
    }
    return user;
  }
}
