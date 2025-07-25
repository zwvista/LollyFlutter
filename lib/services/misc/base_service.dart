import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseService<T> {
  final urlAPI = "https://zwvista.com/lolly/api.php/records/";
  final urlSP = "https://zwvista.com/lolly/sp.php/";

  // https://stackoverflow.com/questions/51368663/flutter-fetched-japanese-character-from-server-decoded-wrong
  Future<Map<String, dynamic>> getDataByUrl(String url) async {
    final uri = "$urlAPI$url";
    final response = await http.get(Uri.parse(uri));
    debugPrint("[RestApi]GET:$uri");
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<int> createByUrl(String url, T item) async {
    final body = json.encode(item);
    final uri = "$urlAPI$url";
    debugPrint("[RestApi]POST:$uri BODY:$body");
    final response = await http.post(Uri.parse(uri), body: body);
    return int.parse(response.body);
  }

  Future<int> updateByUrl(String url, T item) async =>
      await updateByUrlString(url, json.encode(item));

  Future<int> updateByUrlString(String url, String body) async {
    final uri = "$urlAPI$url";
    debugPrint("[RestApi]PUT:$uri BODY:$body");
    final response = await http.put(Uri.parse(uri), body: body);
    return int.parse(response.body);
  }

  Future<int> deleteByUrl(String url) async {
    final uri = "$urlAPI$url";
    debugPrint("[RestApi]DELETE:$uri");
    final response = await http.delete(Uri.parse(uri));
    return int.parse(response.body);
  }

  Future<MSPResult> callSPByUrl(String url, T item) async {
    final body = (json.decode(json.encode(item)) as Map<String, dynamic>)
        .map((k, v) => MapEntry("P_$k", v.toString()));
    final uri = "$urlSP$url";
    debugPrint("[RestApi]SP:$uri");
    final response = await http.post(Uri.parse(uri), body: body);
    return MSPResult.fromJson(json.decode(response.body)[0][0]);
  }

  static Future<String> getHtmlByUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.body;
  }
}

const cssFolder = "https://zwvista.com/lolly/css/";

extension StringExtensions on String {
  String replaceWithMap(Map<String, String> replacements) {
    var s = this;
    replacements.forEach((key, value) => s = s.replaceAll(key, value));
    return s;
  }

  void copyToClipboard() async =>
      await Clipboard.setData(ClipboardData(text: this));

  void google() async {
    final url = "https://www.google.com/search?q=${Uri.encodeFull(this)}";
    await launchUrl(Uri.parse(url));
  }
}

extension ApiExtensions on Future<int> {
  Future<int> logCreate() async {
    final result = await this;
    developer.log("✅ Created new item: result=$result");
    return result;
  }

  Future<int> logUpdate(int id) async {
    final result = await this;
    developer.log("📝 Updated item ID=$id, result=$result");
    return result;
  }

  Future<int> logDelete() async {
    final result = await this;
    developer.log("❌ Deleted item result=$result");
    return result;
  }
}
