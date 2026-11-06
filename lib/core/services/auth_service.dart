import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

const _tokenKey = 'auth_token';

class AuthUser {
  final int id;
  final String name;
  final String email;

  const AuthUser({required this.id, required this.name, required this.email});

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
      );
}

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthService(this._dio, this._storage);

  Future<AuthUser> login(String email, String password) async {
    final response = await _dio.post(
      '${AppConstants.apiBaseUrl}/auth/login',
      data: {'email': email, 'password': password},
    );
    final token = response.data['token'] as String;
    await _storage.write(key: _tokenKey, value: token);
    return AuthUser.fromJson(response.data['user']);
  }

  Future<AuthUser> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) async {
    final response = await _dio.post(
      '${AppConstants.apiBaseUrl}/auth/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
      },
    );
    final token = response.data['token'] as String;
    await _storage.write(key: _tokenKey, value: token);
    return AuthUser.fromJson(response.data['user']);
  }

  Future<AuthUser?> restoreSession() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null) return null;
    try {
      final response = await _dio.get(
        '${AppConstants.apiBaseUrl}/auth/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AuthUser.fromJson(response.data);
    } on DioException {
      await _storage.delete(key: _tokenKey);
      return null;
    }
  }

  Future<void> logout() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      try {
        await _dio.post(
          '${AppConstants.apiBaseUrl}/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
      } catch (_) {}
    }
    await _storage.delete(key: _tokenKey);
  }

  Future<String?> getToken() => _storage.read(key: _tokenKey);
}

final currentUserProvider = StateProvider<AuthUser?>((_) => null);

final _secureStorageProvider = Provider((_) => const FlutterSecureStorage());

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Accept': 'application/json'},
  ));
  return AuthService(dio, ref.watch(_secureStorageProvider));
});
