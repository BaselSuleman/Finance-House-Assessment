import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../utils/failures/base_failure.dart';
import '../../utils/failures/http/http_failure.dart';
import '../model/base_response_model.dart';

abstract class BaseRemoteDataSource {
  @protected
  Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic) decoder,
    bool requiredToken = true,
  });

  @protected
  Future<BaseResponse<T>> get<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic) decoder,
    bool requiredToken = true,
  });

  @protected
  Future<BaseResponse<T>> delete<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic) decoder,
    bool requiredToken = true,
  });

  @protected
  Future<BaseResponse<T>> put<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  });
}

@lazySingleton
class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  Dio dio;

  BaseRemoteDataSourceImpl({required this.dio});

  @override
  Future<BaseResponse<T>> delete<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  }) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      final response = await dio.delete(url, queryParameters: params);
      try {
        return BaseResponse<T>.fromJson(data: response.data, decoder: decoder);
      } catch (e) {
        throw const UnexpectedResponseFailure();
      }
    } on DioException catch (de) {
      if (de.error is Failure) {
        throw de.error!;
      } else {
        throw const UnknownFailure();
      }
    }
  }

  @override
  Future<BaseResponse<T>> get<T>({
    required String url,
    Map<String, dynamic>? params,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  }) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      final response = await dio.get(url, queryParameters: params);

      try {
        return BaseResponse<T>.fromJson(data: response.data, decoder: decoder);
      } catch (e) {
        rethrow;
      }
    } on DioException catch (de) {
      if (de.error is Failure) {
        throw de.error!;
      } else {
        throw const UnknownFailure();
      }
    }
  }

  @override
  Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  }) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }
      if (headers != null) {
        dio.options.headers = headers;
      }

      final response = await dio.post(url, queryParameters: params, data: body);

      try {
        return BaseResponse<T>.fromJson(data: response.data, decoder: decoder);
      } catch (e) {
        throw const UnexpectedResponseFailure();
      }
    } on DioException catch (de) {
      if (de.error is Failure) {
        throw de.error!;
      } else {
        throw const UnknownFailure();
      }
    }
  }

  @override
  Future<BaseResponse<T>> put<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    required T Function(dynamic p1) decoder,
    bool requiredToken = true,
  }) async {
    try {
      if (requiredToken) {
        dio.options.headers.addAll({"withToken": true});
      }

      final response = await dio.put(url, queryParameters: params, data: body);

      try {
        return BaseResponse<T>.fromJson(data: response.data, decoder: decoder);
      } catch (e) {
        throw const UnexpectedResponseFailure();
      }
    } on DioException catch (de) {
      if (de.error is Failure) {
        throw de.error!;
      } else {
        throw const UnknownFailure();
      }
    }
  }
}
