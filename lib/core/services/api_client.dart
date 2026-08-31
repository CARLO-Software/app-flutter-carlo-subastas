import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.apiBaseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 120),
  ));
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
  return dio;
});

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<String> uploadPhoto({
    required String filePath,
    required String category,
    String? positionId,
    void Function(int, int)? onProgress,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'category': category,
      if (positionId != null) 'positionId': positionId,
    });
    final response = await _dio.post(
      '/photos',
      data: formData,
      onSendProgress: onProgress,
    );
    return response.data['id'] as String;
  }

  Future<String> submitRegistration(Map<String, dynamic> payload) async {
    final response = await _dio.post('/registrations', data: payload);
    return response.data['id'] as String;
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});
