import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../data/model/error/error_model.dart';
import 'failures/http/http_failure.dart';

class AppInterceptors extends Interceptor {

  AppInterceptors();

  @override
  FutureOr<dynamic> onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    options.sendTimeout = const Duration(milliseconds: 60000);
    options.connectTimeout = const Duration(milliseconds: 60000);
    options.receiveTimeout = const Duration(milliseconds: 60000);

    handler.next(options);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    {
      HttpFailure failure;
      if (err.type == DioExceptionType.unknown) {
        if (err.response?.statusCode == HttpStatus.unauthorized) {
          failure = const UnauthorizedFailure();
        } else if (err.response?.statusCode == HttpStatus.forbidden) {
          failure = CustomFailure(
              message: err.response?.data['error']["message"] ?? "");
        } else if (err.response?.statusCode == 404) {
          failure = CustomFailure(
              message: err.response?.data['error']["message"] ?? "");
        } else if (err.response!.statusCode! >= 500) {
          failure = const ServerFailure();
        }
      } else if (err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.cancel) {
        throw const NoInternetFailure();
      } else if (err.type == DioExceptionType.badResponse) {
        int statusCode = err.response?.statusCode ?? -1;
        if ((statusCode == HttpStatus.unauthorized) &&
            (!err.requestOptions.uri
                .toString()
                .contains("/api/app/Auth/RefreshToken"))) {} else
        if (err.type == DioExceptionType.badResponse) {
          String errorMessage = 'Unknown Error!';
          errorMessage = err.response?.data['error'] != null
              ? ErrorModel
              .fromJson(err.response?.data['error'])
              .message
              : 'Unknown Error!';
          if (err.response?.data['error']?['validationErrors'] != null &&
              err.response?.data['error']['validationErrors'].length > 0) {
            errorMessage =
            err.response?.data['error']['validationErrors'][0]['message'];
          }
          failure = CustomFailure(message: errorMessage);

          throw failure;
        } else if (err.response?.statusCode == HttpStatus.forbidden) {
          failure = CustomFailure(
              message: err.response?.data['error']["message"] ?? "");

          throw failure;
        } else {
          failure = const UnauthorizedFailure();
          throw failure;
        }
      } else {
        String errorMessage = 'Unknown Error!';
        try {
          errorMessage = err.response?.data['error'] != null
              ? ErrorModel
              .fromJson(err.response?.data['error'])
              .message
              : 'Unknown Error!';
          if (err.response?.data['error']?['validationErrors'] != null &&
              err.response?.data['error']['validationErrors'].length > 0) {
            errorMessage =
            err.response?.data['error']['validationErrors'][0]['message'];
          }
        } finally {
          failure = CustomFailure(message: errorMessage);
        }
        throw failure;
      }
    }
  }

}
