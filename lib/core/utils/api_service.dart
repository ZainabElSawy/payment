import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  Future<Response> post(
      {required Map<String, dynamic> body,
      required String url,
      required String token,
      String? contentType}) async {
    var response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType ?? 'application/json',
        headers: {
          // 'Content-Type': contentType ?? 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  }
}
