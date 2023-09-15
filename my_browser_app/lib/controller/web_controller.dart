import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class pagecontroller extends ChangeNotifier {
  InAppWebViewController? webViewController;

  bool canback = false;
  bool canforward = false;

  String currenturl = "";
  String browserurl = "";
  String searchdata = "Flutter";

  String Browser = "google";

  Map allurl = {};

  pagecontroller() {
    allurl = {
      "google":
          "https://www.google.co.in/search?q=$searchdata&sca_esv=565555999&sxsrf=AM9HkKn8m1ocgexofA4FQCOyL89Kd15dUQ%3A1694753376762&ei=YOIDZcWGLoiO4-EPmNe8wA0&ved=0ahUKEwjFtoOo6KuBAxUIxzgGHZgrD9gQ4dUDCBA&uact=5&oq=$currenturl&gs_lp=Egxnd3Mtd2l6LXNlcnAiB2ZsdXR0ZXIyBBAAGEcyBBAAGEcyBBAAGEcyBBAAGEcyBBAAGEcyBBAAGEcyBBAAGEcyBBAAGEdI3QRQ4ANY4ANwAXgCkAEAmAEAoAEAqgEAuAEDyAEA-AEBwgIHECMYsAMYJ8ICChAAGEcY1gQYsAPiAwQYACBBiAYBkAYI&sclient=gws-wiz-serp",
      "duckduckgo": "https://duckduckgo.com/?q=$searchdata&ia=web",
      "yahoo":
          "https://in.search.yahoo.com/search;_ylt=Awr1TgqeBARlcq8F.Xi6HAx.;_ylc=X1MDMjExNDcyMzAwMgRfcgMyBGZyAwRmcjIDcDpzLHY6c2ZwLG06c2ItdG9wBGdwcmlkA3FpZGlJRTlVVGZDV2JXaHFFQWFKRkEEbl9yc2x0AzAEbl9zdWdnAzEwBG9yaWdpbgNpbi5zZWFyY2gueWFob28uY29tBHBvcwMwBHBxc3RyAwRwcXN0cmwDMARxc3RybAM3BHF1ZXJ5A2ZsdXR0ZXIEdF9zdG1wAzE2OTQ3NjIxMDU-?p=$searchdata&fr=sfp&fr2=p%3As%2Cv%3Asfp%2Cm%3Asb-top&iscqry=",
    };
    browserurl = allurl[Browser];
    currenturl = browserurl;
    notifyListeners();
  }

  setdata({String data = "flutter"}) {
    searchdata = data;
    notifyListeners();
  }

  changeBrowser({required String browserName}) {
    Browser = browserName;
    notifyListeners();
  }

  search({required String value}) {
    searchdata = value;
    webViewController!.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(allurl[Browser]),
      ),
    );
    notifyListeners();
  }

  checkAvailability() async {
    canback = await webViewController?.canGoBack() ?? false;
    canforward = await webViewController?.canGoForward() ?? false;
    notifyListeners();
  }

  get cangoback {
    checkAvailability();
    return canback;
  }

  get cangoforward {
    checkAvailability();
    return canforward;
  }

  back() {
    webViewController?.goBack();
    notifyListeners();
  }

  forward() {
    webViewController?.goForward();
    notifyListeners();
  }

  Refresh() {
    webViewController?.reload();
    notifyListeners();
  }

  init({required InAppWebViewController webviewController}) {
    this.webViewController = webviewController;
  }
}
