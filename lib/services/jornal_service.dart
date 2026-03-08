import 'dart:convert';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class JornalService {
  static const String baseUrl = "http://192.168.0.13:3000";
  static const String resource = "learnhttp";

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() => "$baseUrl/$resource";

  Future<http.Response> register(String content) async {
    return client.post(
      Uri.parse(getUrl()),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({'content': content}),
    );
  }

  Future<List<dynamic>> getAll() async {
    final response = await client.get(Uri.parse(getUrl()));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    }
  }
}
