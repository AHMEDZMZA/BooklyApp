import 'package:dio/dio.dart';
import 'app_endpoints.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  get({required String endPoint, Map<String, dynamic>? query}) async {
    var response = await dio.get(
      "${AppEndpoints.baseUrl}$endPoint",
      queryParameters: query,
    );
    return response.data;
  }
}
