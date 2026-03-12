import 'dart:convert';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class JornalService {
  static const String baseUrl = "http://192.168.0.13:3000";
  static const String resource = "journals/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() => "$baseUrl/$resource";

  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());

    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonJournal,
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<List<Journal>> getAll() async {
    final response = await client.get(Uri.parse(getUrl()));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    }

    List<Journal> list = [];

    List<dynamic> listDynamic = jsonDecode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(Journal.fromMap(jsonMap));
    }
    return list;
  }
}
