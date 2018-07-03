import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

class WebUtils {
  static startWebView(BuildContext context, int id) async {
    String dataURL = "https://news-at.zhihu.com/api/4/news/$id";
    http.Response response = await http.get(dataURL);

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new WebviewScaffold(
        url: json.decode(response.body)["share_url"],
        appBar: new AppBar(
          title: new Text(json.decode(response.body)["title"]),
        ),
        withZoom: true,
        withLocalStorage: true,
      );
    }));
  }
}
