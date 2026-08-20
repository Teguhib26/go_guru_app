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

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final errorMessage = body['error'] ?? 'Terjadi kesalahan';
    final errorCode = body['code'];

    switch (response.statusCode) {
      case 400:
        throw ApiException(errorMessage, statusCode: 400, code: errorCode);
      case 401:
        throw ApiException('Sesi telah berakhir. Silakan login kembali.', statusCode: 401, code: errorCode);
      case 403:
        throw ApiException('Akses ditolak', statusCode: 403, code: errorCode);
      case 404:
        throw ApiException('Data tidak ditemukan', statusCode: 404, code: errorCode);
      case 409:
        throw ApiException(errorMessage, statusCode: 409, code: errorCode);
      case 500:
        throw ApiException('Server error. Silakan coba lagi nanti.', statusCode: 500, code: errorCode);
      default:
        throw ApiException(errorMessage, statusCode: response.statusCode, code: errorCode);
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('Tidak ada koneksi internet');
    } on http.ClientException {
      throw ApiException('Gagal terhubung ke server');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('Tidak ada koneksi internet');
    } on http.ClientException {
      throw ApiException('Gagal terhubung ke server');
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
      throw ApiException('Tidak ada koneksi internet');
    } on http.ClientException {
      throw ApiException('Gagal terhubung ke server');
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
      throw ApiException('Tidak ada koneksi internet');
    } on http.ClientException {
      throw ApiException('Gagal terhubung ke server');
    }
  }
}
