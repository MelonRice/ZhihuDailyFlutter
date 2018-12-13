import 'package:flutter/material.dart';
import 'package:zhihudaily/exampleDemo/sampleApp2.dart';
import 'package:zhihudaily/exampleDemo/sampleApp1.dart';
import 'package:zhihudaily/exampleDemo/fadeAppTest.dart';
import 'package:zhihudaily/exampleDemo/navigatorTest.dart';
import 'package:zhihudaily/exampleDemo/platformChannel.dart';
import 'package:zhihudaily/zhihu/zhihudaily.dart';
import 'package:zhihudaily/exampleDemo/showLoading.dart';
import 'package:zhihudaily/exampleDemo/isolateApp.dart';
import 'package:zhihudaily/exampleDemo/listItem.dart';
import 'package:zhihudaily/exampleDemo/layoutApp.dart';
import 'package:zhihudaily/exampleDemo/startApp.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

//void main() => runApp(new LayoutApp());

void main() {
  debugPaintSizeEnabled = true;
  runApp(StartApp());
}
