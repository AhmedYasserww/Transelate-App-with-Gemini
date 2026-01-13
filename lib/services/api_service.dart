import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  final String baseUrl = "https://transelatebygemeni.runasp.net/api/";

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        "$baseUrl$endPoint",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) return e.response?.data;
      throw Exception("Network error: ${e.message}");
    }
  }

  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        "$baseUrl$endPoint",
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) return e.response?.data;
      throw Exception("Network error: ${e.message}");
    }
  }
}
