import 'dart:convert';

import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/services/misc/base_service.dart';
import 'package:lolly_flutter/viewmodels/misc/search_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';

class OnlineDict {
  var dictStatus = DictWebBrowserStatus.Ready;
  WebViewController controller;
  IOnlineDict iOnlineDict;

  OnlineDict(this.iOnlineDict);

  void searchDict() async {
    final item = vmSettings.selectedDictReference;
    final url = iOnlineDict.getUrl;
    if (item.dicttypename == "OFFLINE") {
      final html = await BaseService.getHtmlByUrl(url);
      final str = item.htmlString(html, iOnlineDict.getWord, true);
      // https://stackoverflow.com/questions/53831312/how-to-render-a-local-html-file-with-flutter-dart-webview
      controller.loadUrl(Uri.dataFromString(str,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
    } else {
      controller.loadUrl(url);
      if (item.automation.isNotEmpty)
        dictStatus = DictWebBrowserStatus.Automating;
      else if (item.dicttypename == "OFFLINE-ONLINE")
        dictStatus = DictWebBrowserStatus.Navigating;
    }
  }

  void onPageFinished() async {
    if (dictStatus == DictWebBrowserStatus.Ready) return;
    final item = vmSettings.selectedDictReference;
    if (dictStatus == DictWebBrowserStatus.Automating) {
      final s = item.automation.replaceAll("{0}", iOnlineDict.getWord);
      await controller.evaluateJavascript(s);
      dictStatus = DictWebBrowserStatus.Ready;
      if (item.dicttypename == "OFFLINE-ONLINE")
        dictStatus = DictWebBrowserStatus.Navigating;
    } else if (dictStatus == DictWebBrowserStatus.Navigating) {
      final html = await controller
          .evaluateJavascript("document.documentElement.outerHTML.toString()");
      final str = item.htmlString(html, iOnlineDict.getWord, true);
      controller.loadUrl(Uri.dataFromString(str,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
      dictStatus = DictWebBrowserStatus.Ready;
    }
  }

  void loadUrl() => controller.loadUrl(iOnlineDict.getUrl);
}
