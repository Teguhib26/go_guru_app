import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;

  ApiException(this.message, {this.statusCode, this.code});

  @override
  String toString() => message;
}

class ApiService {
  static const String baseUrl = 'https://proxy.reimedia.my.id/api';
  static const Duration timeout = Duration(seconds: 30);

  String? _accessToken;

  void setAccessToken(String? token) {
    _accessToken = token;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    return headers;
  }

  Map<String, String> get _headersMultipart {
    final headers = <String, String>{};
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    return headers;
  }

  Map<String, dynamic>? _parseResponseBody(String bodyString) {
    if (bodyString.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(bodyString) as Map<String, dynamic>;
    } catch (e) {
      // If JSON parsing fails, return null
      return null;
    }
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    Map<String, dynamic>? body;
    try {
      body = _parseResponseBody(response.body);
    } catch (e) {
      // If parsing fails, use empty map
      body = {};
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body ?? {'success': true};
    }

    String errorMessage;
    if (body != null && body.containsKey('error')) {
      errorMessage = body['error'].toString();
    } else if (body != null && body.containsKey('message')) {
      errorMessage = body['message'].toString();
    } else if (response.statusCode == 400) {
      errorMessage = 'Data tidak valid. Silakan periksa input Anda.';
    } else if (response.statusCode == 401) {
      errorMessage = 'Sesi telah berakhir. Silakan login kembali.';
    } else if (response.statusCode == 403) {
      errorMessage = 'Akses ditolak.';
    } else if (response.statusCode == 404) {
      errorMessage = 'Data tidak ditemukan.';
    } else if (response.statusCode == 409) {
      errorMessage = 'Email sudah terdaftar. Gunakan email lain.';
    } else if (response.statusCode >= 500) {
      errorMessage = 'Server error. Silakan coba lagi nanti.';
    } else {
      errorMessage = 'Terjadi kesalahan (${response.statusCode}).';
    }

    final errorCode = body?['code']?.toString();

    switch (response.statusCode) {
      case 400:
        throw ApiException(errorMessage, statusCode: 400, code: errorCode);
      case 401:
        throw ApiException(errorMessage, statusCode: 401, code: errorCode);
      case 403:
        throw ApiException(errorMessage, statusCode: 403, code: errorCode);
      case 404:
        throw ApiException(errorMessage, statusCode: 404, code: errorCode);
      case 409:
        throw ApiException(errorMessage, statusCode: 409, code: errorCode);
      case 500:
        throw ApiException(errorMessage, statusCode: 500, code: errorCode);
      default:
        throw ApiException(errorMessage, statusCode: response.statusCode, code: errorCode);
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print('API GET: $uri');

      final response = await http.get(
        uri,
        headers: _headers,
      ).timeout(timeout);

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      return _handleResponse(response);
    } on SocketException {
      print('API Error: SocketException - No internet connection');
      throw ApiException('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException catch (e) {
      print('API Error: ClientException - $e');
      throw ApiException('Tidak dapat terhubung ke server. Coba beberapa saat lagi.');
    } on FormatException catch (e) {
      print('API Error: FormatException - $e');
      throw ApiException('Format response tidak valid.');
    } catch (e) {
      print('API Error: $e');
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print('API POST: $uri');
      print('API Body: $body');

      final response = await http.post(
        uri,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(timeout);

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      return _handleResponse(response);
    } on SocketException {
      print('API Error: SocketException - No internet connection');
      throw ApiException('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException catch (e) {
      print('API Error: ClientException - $e');
      throw ApiException('Tidak dapat terhubung ke server. Coba beberapa saat lagi.');
    } on FormatException catch (e) {
      print('API Error: FormatException - $e');
      throw ApiException('Format response tidak valid.');
    } catch (e) {
      print('API Error: $e');
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    File? file,
    String? fileField,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endpoint'),
      );

      request.headers.addAll(_headersMultipart);

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (file != null && fileField != null) {
        request.files.add(await http.MultipartFile.fromPath(fileField, file.path));
      }

      final streamedResponse = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException {
      throw ApiException('Tidak dapat terhubung ke server. Coba beberapa saat lagi.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> postMultipartMultipleFiles(
    String endpoint, {
    required Map<String, String> fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endpoint'),
      );

      request.headers.addAll(_headersMultipart);
      request.fields.addAll(fields);

      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException {
      throw ApiException('Tidak dapat terhubung ke server. Coba beberapa saat lagi.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan: ${e.toString()}');
    }
  }
}
