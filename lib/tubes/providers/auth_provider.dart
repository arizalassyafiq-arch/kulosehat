import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  // Ganti IP ini sesuai IP laptop saat server Laravel berjalan.
  static const String _baseUrl = 'http://10.213.114.129:8000/api';
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  bool isLoading = false;
  String? errorMessage;
  String? token;
  Map<String, dynamic>? user;

  AuthProvider() {
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_tokenKey);
    final rawUser = prefs.getString(_userKey);
    if (rawUser != null && rawUser.isNotEmpty) {
      try {
        user = jsonDecode(rawUser) as Map<String, dynamic>;
      } catch (_) {
        user = null;
      }
    }
    notifyListeners();
  }

  Future<bool> registerWithEmail(
    String name,
    String email,
    String password,
    String confirm,
  ) async {
    return _runAuthRequest(
      () async => http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirm,
        }),
      ),
      successMessage: 'Registrasi berhasil',
      storeToken: true,
    );
  }

  Future<bool> loginWithEmail(String email, String password) async {
    return _runAuthRequest(
      () async => http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ),
      successMessage: 'Login berhasil',
      storeToken: true,
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    if (token != null && token!.isNotEmpty) {
      try {
        await http
            .post(
              Uri.parse('$_baseUrl/logout'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
            )
            .timeout(const Duration(seconds: 10));
      } catch (_) {}
    }

    token = null;
    user = null;
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    notifyListeners();
  }

  Future<bool> _runAuthRequest(
    Future<http.Response> Function() request, {
    required String successMessage,
    required bool storeToken,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final res = await request().timeout(const Duration(seconds: 10));

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = _safeJson(res.body);
        if (storeToken && data != null) {
          await _persistAuth(data);
        }
        errorMessage = null;
        return true;
      }

      errorMessage = _extractError(res.body, res.statusCode);
      return false;
    } catch (_) {
      errorMessage = 'Tidak bisa terhubung ke server.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _persistAuth(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    if (data['token'] is String) {
      token = data['token'] as String;
      await prefs.setString(_tokenKey, token!);
    }

    if (data['user'] is Map<String, dynamic>) {
      user = Map<String, dynamic>.from(data['user'] as Map);
      await prefs.setString(_userKey, jsonEncode(user));
    }
  }

  Map<String, dynamic>? _safeJson(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {}
    return null;
  }

  String _extractError(String body, int statusCode) {
    final data = _safeJson(body);
    if (data == null) {
      return statusCode == 422
          ? 'Data tidak valid.'
          : 'Terjadi kesalahan.';
    }

    if (data['message'] is String && (data['message'] as String).isNotEmpty) {
      return data['message'] as String;
    }

    if (data['errors'] is Map<String, dynamic>) {
      final errors = data['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) {
          return first.first.toString();
        }
      }
    }

    return 'Terjadi kesalahan.';
  }
}
