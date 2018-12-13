// Step 7 (Final): Change the app's theme

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MaterialApp widget本身是一个 widget 的 StatelessWidget 类
    //在 Flutter 中，大多数时候一切都可以看作 widget , 包括 alignment，padding 和 layout
    return new MaterialApp(
      //这个不是标题栏title
      title: 'Startup Name Generator',
      //主题颜色
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      //StatelessWidget嵌套了一个StatefulWidget
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  //只需要实现一个方法，返回一个State
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  //保存建议的单词对
  //final关键字让变量不能被再次赋值
  //在Dart语言中使用下划线前缀标识符，会强制其变成私有的
  final _suggestions = <WordPair>[];

  //存储用户收藏的单词对
  final _saved = new Set<WordPair>();

  //自定义字体大小
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    //重写initState，以完成仅需要执行一次的工作
  }

  //将 Widget build(BuildContext context)方法放在State上而不是StatefulWidget上是为了在继承StatefulWidget时能更加灵活
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator111111111'),
        //右上角事件，进行页面跳转
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //构建显示建议单词对的ListView，当不知道要返回的组件属于什么类型，都可以定义为Widget
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      //不指定itemCount时，是一个无限长度的列表
      itemBuilder: (context, i) {
        // 在奇数行，该行添加一个分割线widget，来分隔相邻的词对。
        if (i.isOdd) return new Divider();
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.album : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      //在 _buildRow中让心形❤图标变得可以点击。如果单词条目已经添加到收藏夹中，
      // 再次点击它将其从收藏夹中删除。当心形❤图标被点击时，函数调用setState()通知框架状态已经改变。
      //只要添加了onTap属性，在MD主题下会有水波纹点击效果
      onTap: () {
        setState(
          () {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          },
        );
      },
    );
  }

  void _pushSaved() {
    //当用户点击导航栏中的列表图标时，建立一个路由并将其推入到导航管理器栈中。此操作会切换页面以显示新路由。
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
