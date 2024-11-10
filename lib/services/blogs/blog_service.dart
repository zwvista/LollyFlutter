import '../../viewmodels/misc/settings_viewmodel.dart';

class BlogService {
  String _html1With(String s) =>
      '<strong><span style="color:#0000ff;">$s</span></strong>';
  String _htmlWordWith(String s) => _html1With("$s：");
  String _htmlBWith(String s) => _html1With(s);
  String _htmlE1With(String s) => '<span style="color:#006600;">$s</span>';
  String _html2With(String s) => '<span style="color:#cc00cc;">$s</span>';
  String _htmlE2With(String s) => _html2With(s);
  String _htmlIWith(String s) => "<strong>${_html2With(s)}</strong>";
  final _htmlEmptyLine = "<div><br></div>";
  final _regMarkedEntry = RegExp(r"(\*\*?)\s*(.*?)：(.*?)：(.*)");
  final _regMarkedB = RegExp("<B>(.+?)</B>");
  final _regMarkedI = RegExp("<I>(.+?)</I>");
  String markedToHtml(String text) {
    final lst = text.split("\n");
    for (var i = 0; i < lst.length; i++) {
      var s = lst[i];
      final m = _regMarkedEntry.firstMatch(s);
      if (m != null) {
        final s1 = m.group(1)!;
        final s2 = m.group(2)!;
        final s3 = m.group(3)!;
        final s4 = m.group(4)!;
        s = _htmlWordWith(s2) +
            (s3.isEmpty ? "" : _htmlE1With(s3)) +
            (s4.isEmpty ? "" : _htmlE2With(s4));
        lst[i] = (s1 == "*" ? "<li>" : "<br>") + s;
        if (i == 0 || lst[i - 1].startsWith("<div>")) {
          lst.insert(i++, "<ul>");
        }
        final isLast = i == lst.length - 1;
        final m2 = isLast ? null : _regMarkedEntry.firstMatch(lst[i + 1]);
        if (isLast || m2 == null || m2.group(1) != "**") {
          lst[i] += "</li>";
        }
        if (isLast || m2 == null) {
          lst.insert(++i, "</ul>");
        }
      } else if (s.isEmpty) {
        lst[i] = _htmlEmptyLine;
      } else {
        s = s
            .replaceAllMapped(_regMarkedB, (m2) => _htmlBWith(m2.group(1)!))
            .replaceAllMapped(_regMarkedI, (m2) => _htmlIWith(m2.group(1)!));
        lst[i] = "<div>$s</div>";
      }
    }
    return lst.join("\n");
  }

  final _regLine = RegExp("<div>(.*?)</div>");
  RegExp get _regHtmlB => RegExp(_htmlBWith("(.+?)"));
  RegExp get _regHtmlI => RegExp(_htmlIWith("(.+?)"));
  RegExp get _regHtmlEntry => RegExp(
      "(<li>|<br>)${_htmlWordWith("(.*?)")}(?:${_htmlE1With("(.*?)")})?(?:${_htmlE2With("(.*?)")})?(?:</li>)?");
  String htmlToMarked(String text) {
    final lst = text.split("\n");
    for (var i = 0; i < lst.length; i++) {
      var s = lst[i];
      if (s == "<!-- wp:html -->" ||
          s == "<!-- /wp:html -->" ||
          s == "<ul>" ||
          s == "</ul>") {
        lst.removeAt(i--);
      } else if (s == _htmlEmptyLine) {
        lst[i] = "";
      } else {
        var m = _regLine.firstMatch(s);
        if (m != null) {
          s = m.group(1)!;
          s = s
              .replaceAllMapped(_regHtmlB, (m2) => "<B>${m2.group(1)}</B>")
              .replaceAllMapped(_regHtmlI, (m2) => "<I>${m2.group(1)}</I>");
          lst[i] = s;
        } else {
          m = _regHtmlEntry.firstMatch(s);
          if (m != null) {
            final s1 = m.group(1)!;
            final s2 = m.group(2)!;
            final s3 = m.group(3)!;
            final s4 = m.group(4)!;
            s = "${s1 == "<li>" ? "*" : "**"} $s2：$s3：$s4";
            lst[i] = s;
          }
        }
      }
    }
    return lst.join("\n");
  }

  String addTagB(String text) => "<B>$text</B>";
  String addTagI(String text) => "<I>$text</I>";
  String removeTagBI(String text) =>
      text.replaceAllMapped(RegExp("</?[BI]>"), (m) => "");
  String exchangeTagBI(String text) {
    var text2 = text
        .replaceAllMapped(RegExp("<(/)?B>"), (m) => "<${m.group(1)!}Temp>")
        .replaceAllMapped(RegExp("<(/)?I>"), (m) => "<${m.group(1)!}B>")
        .replaceAllMapped(RegExp("<(/)?Temp>"), (m) => "<${m.group(1)!}I>");
    return text2;
  }

  String getExplanation(String text) => "* $text：：\n";
  String getPatternUrl(String patternNo) =>
      "http://viethuong.web.fc2.com/MONDAI/$patternNo.html";
  String getPatternMarkDown(String patternText) =>
      "* [$patternText　文法](https://www.google.com/search?q=$patternText　文法)\n* [$patternText　句型](https://www.google.com/search?q=$patternText　句型)";
  final String _bigDigits = "０１２３４５６７８９";
  void addNotes(SettingsViewModel vmSettings, String text,
      void Function(String) allComplete) async {
    String f(String s) {
      var s2 = s;
      for (var i = 0; i < 10; i++) {
        s2 = s2.replaceAll(String.fromCharCode(48 + i), _bigDigits[i]);
      }
      return s2;
    }

    final items = text.split("\n");
    await vmSettings.getNotes(items.length, (i) {
      final m = _regMarkedEntry.firstMatch(items[i]);
      if (m == null) return false;
      final word = m.group(2)!;
      return word.split('').every((s) => s != '（' && !_bigDigits.contains(s));
    }, (i) async {
      final m = _regMarkedEntry.firstMatch(items[i])!;
      final s1 = m.group(1)!;
      final word = m.group(2)!;
      final s3 = m.group(3)!;
      final s4 = m.group(4)!;
      final note = await vmSettings.getNote(word);
      final j = note.split('').indexWhere((s) => int.tryParse(s) != null);
      final s21 = j == -1 ? note : note.substring(0, j);
      final s22 = j == -1 ? "" : f(note.substring(j));
      final s2 = word + (s21 == word || s21.isEmpty ? "" : "（$s21）") + s22;
      items[i] = "$s1 $s2：$s3：$s4";
    });
    allComplete(items.join("\n"));
  }
}
