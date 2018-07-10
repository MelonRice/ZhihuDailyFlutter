import 'package:flutter/material.dart';
import 'package:zhihudaily/model/ThemeModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zhihudaily/common/common_loading_dialog.dart';
import 'package:zhihudaily/utils/RouterUtils.dart';

class DrawerBody extends StatefulWidget {
  @override
  DrawerState createState() => new DrawerState();
}

class DrawerState extends State<DrawerBody> {
  List<ThemeModel> themes = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (null != themes && themes.isNotEmpty) {
      return new Column(
        children: <Widget>[
          buildDrawer(),
          buildItem(),
          new Divider(height: 1.0),
          buildList()
        ],
      );
    } else {
      return ProgressDialog.buildProgressDialog();
    }
  }

  Widget buildDrawer() {
    return new UserAccountsDrawerHeader(
      onDetailsPressed: () {},
      accountName: new Text('MelonRice'),
      accountEmail: new Text('rice@bmqb.com'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new NetworkImage(
            'https://wx3.sinaimg.cn/mw690/44485fa4gy1ft4q8gk1vmj205k05kjsn.jpg'),
      ),
    );
  }

  Widget buildItem() {
    return new InkWell(
      onTap: () {
        Navigator.of(context).pop();
        RouterUtils.routeToMain(context);
      },
      child: new Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: new Row(
            children: <Widget>[
              new Icon(Icons.home, color: Colors.blue, size: 36.0),
              new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Text('首页',
                      style:
                          new TextStyle(color: Colors.blue, fontSize: 18.0))),
            ],
          )),
    );
  }

  Widget buildList() {
    return new MediaQuery.removePadding(
      context: context,
      // DrawerHeader consumes top MediaQuery padding.
      removeTop: true,
      child: new Expanded(
          child: new ListView(
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: themes.map((ThemeModel model) {
              return buildOtherItem(model);
            }).toList(),
          ),
        ],
      )),
    );
  }

  Widget buildOtherItem(ThemeModel model) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).pop();
        RouterUtils.route2ThemeList(context, '${model.id}');
      },
      child: new ListTile(
        trailing: new Icon(Icons.add, color: Colors.grey[300]),
        title: new Text('${model.name}',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                fontSize: 16.0)),
      ),
    );
  }

  loadData() async {
    String dataURL = "https://news-at.zhihu.com/api/4/themes";
    http.Response response = await http.get(dataURL);
    List others = json.decode(response.body)["others"];
    themes = others.map((model) {
      return new ThemeModel.fromJson(model);
    }).toList();

    setState(() {});
  }
}

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new DrawerBody(),
    );
  }
}
