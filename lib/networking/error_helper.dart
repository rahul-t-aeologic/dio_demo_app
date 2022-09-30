import 'dart:io';

import 'package:dio/dio.dart';

class ErrorHelper {
  static String handleError(Object error) {
    try {
      var errorDescription = '';
      if (error is DioError) {
        print('error is DioError');
        switch (error.type) {
          case DioErrorType.cancel:
            errorDescription = 'Request cancelled';
            break;
          case DioErrorType.connectTimeout:
            errorDescription = 'Connection timeout';
            break;
          case DioErrorType.receiveTimeout:
            errorDescription = 'Receive timeout in connection with API server';
            break;
          case DioErrorType.response:
            switch (error.response?.statusCode ?? 0) {
              case 400:
                errorDescription = getErrorFromResponse(error.response);
                break;
              case 401:
                errorDescription = 'Unauthorised request';
                break;
              case 403:
                errorDescription = getErrorFromResponse(error.response);
                break;
              case 404:
                errorDescription = '404 Not Found';
                    //getErrorFromResponse(error.response);
                break;
              case 409:
                errorDescription = 'Error due to a conflict';
                break;
              case 500:
                errorDescription = 'Internal Server Error';
                break;
              case 503:
                errorDescription = 'Service unavailable';
                break;
              default:
                errorDescription =
                '''Received invalid status code: ${error.response?.statusCode ?? ''}''';
            }
            break;
          case DioErrorType.sendTimeout:
            errorDescription = 'Send timeout in connection with API server';
            break;
          case DioErrorType.other:
            errorDescription = 'Unexpected error occurred';
            break;
        }
      } else if (error is SocketException) {
        errorDescription = 'No internet connection ${error.toString()}';
      } else {
        errorDescription = 'Unexpected error occurred';
      }
      return errorDescription;
    } on DioError {
      return 'Unexpected error occurred';
    }
  }

  static String getErrorFromResponse(Response? response) {
    print('response.statusMessage: ${response?.statusMessage ?? ''}');
    print('response.data: ${response?.data}');

    if (response?.data != null && response?.data is Map) {
      final _errorString = '';
      return _errorString;
    } else {
      return '404 ${response?.statusMessage ?? ''}';
    }
  }
}
