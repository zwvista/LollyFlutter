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
    var lst = groupBy(arr.take(arr.length ~/ 2 * 2).toList().asMap().entries,
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
    s = s.replaceAllMapped(reg, (m) {
      var indexes = RegExp(r"\$\d")
          .allMatches(replacement)
          .map((m2) => m2.start)
          .toList();
      var t = "";
      for (var i = 0; i < indexes.length; i++) {
        var n1 = i == 0 ? 0 : indexes[i - 1];
        var n2 = indexes[i];
        t += replacement.substring(n1, n2);
        t += m.group(int.parse(replacement[n2 + 1]));
      }
      if (indexes.isEmpty)
        t = replacement;
      else
        t += replacement.substring(indexes.last + 2);
      return t;
    });
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
