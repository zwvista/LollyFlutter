import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lolly_flutter/models/misc/mcommon.dart';

class BaseService {
  final urlAPI = "https://zwvista.tk/lolly/api.php/records/";
  final urlSP = "https://zwvista.tk/lolly/sp.php/";
  final cssFolder = "https://zwvista.tk/lolly/css/";

  Future<Map<String, dynamic>> getDataByUrl(String url) async {
    final response = await http.get("${urlAPI}url");
    return json.decode(response.body);
  }

  Future<int> createByUrl(String url, Map<String, dynamic> body) async {
    body.remove("ID");
    final response = await http.post("${urlAPI}url", body: body);
    return response.body as int;
  }

  Future<int> updateByUrl(String url, body) async {
    final response = await http.put("${urlAPI}url", body: body);
    return response.body as int;
  }

  Future<int> deleteByUrl(String url) async {
    final response = await http.delete("${urlAPI}url");
    return response.body as int;
  }

  Future<MSPResult> callSPByUrl(
      String url, Map<String, dynamic> itemMap) async {
    final body = itemMap.map((k, v) => MapEntry("P_" + k, v));
    final response = await http.post("${urlSP}url", body: body);
    return MSPResult.fromJson(json.decode(response.body));
  }
}
