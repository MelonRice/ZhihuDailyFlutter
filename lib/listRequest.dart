import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ListRequestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '知乎日报',
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
          itemBuilder: (BuildContext context, int position) {
            return getRow(context, position);
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

  Widget getRow(BuildContext context, int i) {
//    return new Padding(
//        padding: new EdgeInsets.all(10.0),
//        child: new Text("${widgets[i]["title"]}"));
    return new Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: new TravelDestinationItem(destination: widgets[i]));
  }

  loadData() async {
    String dataURL = "https://news-at.zhihu.com/api/4/news/latest";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = JSON.decode(response.body)["stories"];
    });
  }
}

class TravelDestinationItem extends StatelessWidget {
  TravelDestinationItem({Key key, @required this.destination}) : super(key: key);

  static const double height = 150.0;
  final dynamic destination;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return new SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        padding: const EdgeInsets.all(0.0),
        height: height,
        child: new Card(
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // photo and title
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: new DefaultTextStyle(
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // three line description
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            destination["title"],
                            style: descriptionStyle.copyWith(
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              new SizedBox(
                width: 150.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                        child: new Container(
                      foregroundDecoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new NetworkImage(destination["images"][0]),
                            fit: BoxFit.cover),
                      ),
                    )),
                  ],
                ),
              ),
              // description and share/expore buttons
              // share, explore buttons
            ],
          ),
        ),
      ),
    );
  }
}
