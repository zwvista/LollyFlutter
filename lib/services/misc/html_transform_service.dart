import 'package:collection/collection.dart';
import 'package:lolly_flutter/models/misc/mtransformitem.dart';

import 'base_service.dart';

class HtmlTransformService {
  static final escapes = {
    "<delete>": "",
    r"\t": "\t",
    r"\n": "\n",
  };

  static String removeReturns(String html) => html.replaceAll("\r\n", "\n");

  static List<MTransformItem> toTransformItems(String transform) {
    var arr = transform.split("\r\n");
    var lst = groupBy<MapEntry<int, String>, int>(arr.take(arr.length ~/ 2 * 2).toList().asMap().entries,
            (kv) => kv.key ~/ 2)
        .values
        .map((g) => MTransformItem()
          ..index = g[0].key ~/ 2 + 1
          ..extractor = g[0].value
          ..replacement = g[1].value)
        .toList();
    return lst;
  }

  static String doTransform(String text, MTransformItem item) {
    final reg = RegExp(item.extractor);
    var replacement = item.replacement;
    var s = text;
    if (replacement.startsWith("<extract>")) {
      replacement = replacement.substring("<extract>".length);
      s = reg.allMatches(s).map((m) => m.group(0)).join();
    }
    replacement = replacement.replaceWithMap(escapes);
    // replace $1,$2 with m.group(1),m.group(2)
    final reg2 = RegExp(r"\$(\d)");
    s = s.replaceAllMapped(
        reg,
        (m) => replacement.replaceAllMapped(
            reg2, (m2) => m.group(int.parse(m2.group(1)!))!));
    return s;
  }

  static String extractTextFromHtml(String html, String transform,
      String template, String Function(String, String) templateHandler) {
    var text = removeReturns(html);
    do {
      if (transform.isEmpty) break;
      var items = toTransformItems(transform);
      for (var item in items) text = doTransform(text, item);
      if (template.isEmpty) break;
      text = templateHandler(text, template);
    } while (false);
    return text;
  }

  static String toHtml(String text) => '''<!doctype html>
<html>
<head>
<meta charset=""utf-8"">
<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">
</head>
<body>
$text
</body>
</html>''';

  static String applyTemplate(String template, String word, String text) =>
      template
          .replaceAll("{0}", word)
          .replaceAll("{1}", cssFolder)
          .replaceAll("{2}", text);
}
