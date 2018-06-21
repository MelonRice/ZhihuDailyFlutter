import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class StoryItem extends StatelessWidget {
  StoryItem({Key key, @required this.detail}) : super(key: key);

  static const double height = 120.0;
  final dynamic detail;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.title;

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
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            detail["title"],
                            maxLines: 3,
                            style: descriptionStyle.copyWith(
                                fontSize: 16.0, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              new SizedBox(
                width: 115.0,
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: new Stack(
                    children: <Widget>[
                      new Positioned.fill(
                          child: new Container(
                        foregroundDecoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: new NetworkImage(detail["images"][0]),
                              fit: BoxFit.cover),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
