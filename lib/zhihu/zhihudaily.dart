import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:starter/zhihu/storyItem.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String selectedUrl = "https://www.baidu.com";

class ZhihuDailyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '知乎日报',
      color: Colors.grey,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("知乎日报"),
      ),
      body: new ListView.builder(
          itemCount: widgets.length,
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          itemBuilder: (BuildContext context, int position) {
            return getItem(context, position);
          }),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new ListTile(
              title: new Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getItem(BuildContext context, int i) {
    return new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new StoryItem(
          detail: widgets[i],
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
              return new WebviewScaffold(
                url: selectedUrl,
                appBar: new AppBar(
                  title: new Text("Widget webview"),
                ),
                withZoom: true,
                withLocalStorage: true,
              );
            }));
          },
        ));
  }

  loadData() async {
    String dataURL = "https://news-at.zhihu.com/api/4/news/latest";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body)["stories"];
    });
  }
}
