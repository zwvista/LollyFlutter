import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseService<T> {
  final urlAPI = "https://zwvista.tk/lolly/api.php/records/";
  final urlSP = "https://zwvista.tk/lolly/sp.php/";

  // https://stackoverflow.com/questions/51368663/flutter-fetched-japanese-character-from-server-decoded-wrong
  Future<Map<String, dynamic>> getDataByUrl(String url) async {
    final response = await http.get(Uri.parse("$urlAPI$url"));
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<int> createByUrl(String url, T item) async {
    final body = json.encode(item).replaceAll('"ID":0,', '');
    final response = await http.post(Uri.parse("$urlAPI$url"), body: body);
    return int.parse(response.body);
  }

  Future<int> updateByUrl(String url, T item) async =>
      await updateByUrlString(url, json.encode(item));

  Future<int> updateByUrlString(String url, String body) async {
    final response = await http.put(Uri.parse("$urlAPI$url"), body: body);
    return int.parse(response.body);
  }

  Future<int> deleteByUrl(String url) async {
    final response = await http.delete(Uri.parse("$urlAPI$url"));
    return int.parse(response.body);
  }

  Future<MSPResult> callSPByUrl(String url, T item) async {
    final body = (json.decode(json.encode(item)) as Map<String, dynamic>)
        .map((k, v) => MapEntry("P_" + k, v.toString()));
    final response = await http.post(Uri.parse("$urlSP$url"), body: body);
    return MSPResult.fromJson(json.decode(response.body)[0][0]);
  }

  static Future<String> getHtmlByUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.body;
  }
}

final cssFolder = "https://zwvista.tk/lolly/css/";

extension StringExtensions on String {
  String replaceWithMap(Map<String, String> replacements) {
    var s = this;
    replacements.forEach((key, value) => s = s.replaceAll(key, value));
    return s;
  }

  void copyToClipboard() async =>
      await Clipboard.setData(ClipboardData(text: this));

  void google() async {
    final url = "https://www.google.com/search?q=" + Uri.encodeFull(this);
    await launch(url);
  }
}
