import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lolly_flutter/models/misc/mcommon.dart';

class BaseService<T> {
  final urlAPI = "https://zwvista.tk/lolly/api.php/records/";
  final urlSP = "https://zwvista.tk/lolly/sp.php/";
  final cssFolder = "https://zwvista.tk/lolly/css/";

  Future<Map<String, dynamic>> getDataByUrl(String url) async {
    final response = await http.get("${urlAPI}url");
    return json.decode(response.body);
  }

  Future<int> createByUrl(String url, T item) async {
    final body = json.encode(item).replaceAll('"ID":0,', '');
    final response = await http.post("${urlAPI}url", body: body);
    return response.body as int;
  }

  Future<int> updateByUrl(String url, T item) async =>
      await updateByUrlString(url, json.encode(item));

  Future<int> updateByUrlString(String url, String body) async {
    final response = await http.put("${urlAPI}url", body: body);
    return response.body as int;
  }

  Future<int> deleteByUrl(String url) async {
    final response = await http.delete("${urlAPI}url");
    return response.body as int;
  }

  Future<MSPResult> callSPByUrl(String url, T item) async {
    final body = json
        .encode(item)
        .replaceAllMapped(RegExp('"(\w+)":'), (m) => '"P_{m.group(1)}":');
    final response = await http.post("${urlSP}url", body: body);
    return MSPResult.fromJson(json.decode(response.body));
  }
}
