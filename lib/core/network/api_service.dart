import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  final String _baseUrl = 'https://www.googleapis.com/books/v1/';

  ApiService({required this.dio});

  get({required String endPoint, Map<String, dynamic>? query}) async {
    var response = await dio.get("$_baseUrl$endPoint", queryParameters: query);
    return response.data;
  }
}
