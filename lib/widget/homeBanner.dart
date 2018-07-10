import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zhihudaily/model/homePageModel.dart';
import 'package:zhihudaily/utils/RouterUtils.dart';

class HomeBanner extends StatefulWidget {
  final List<TopStoriesModel> bannerList;

  HomeBanner(this.bannerList);

  @override
  State<StatefulWidget> createState() => new HomeBannerState();
}

class HomeBannerState extends State<HomeBanner> {
  List<Widget> _indicators = [];

  int _curIndicatorsIndex = 0;

  Timer timer;

  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(new Duration(seconds: 3), (timer) {
      pageController.animateToPage(_curIndicatorsIndex == _indicators.length - 1 ? 0 : _curIndicatorsIndex + 1,
          duration: new Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return buildBanner();
  }

  Widget buildBanner() {
    return new Container(
      height: 220.0,
      child: new Stack(
        children: <Widget>[
          buildPagerView(),
          buildIndicators(),
        ],
      ),
    );
  }

  Widget buildPagerView() {
    return new PageView.builder(
      controller: pageController,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(context, index);
      },
      itemCount: widget.bannerList.length,
      onPageChanged: (index) {
        _changePage(index);
      },
    );
  }

  Widget buildItem(BuildContext context, int index) {
    TopStoriesModel banner = widget.bannerList[index];

    return new GestureDetector(
      onTap: () {
        RouterUtils.startWebView(context, banner.id);
      },
      child: new Image.network(
        banner.image,
        fit: BoxFit.fitWidth,
        height: 200.0,
      ),
    );
  }

  Widget buildIndicators() {
    _initIndicators();
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Container(
        color: Colors.black38,
        height: 60.0,
        width: double.infinity,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: new Text(widget.bannerList[_curIndicatorsIndex].title,
                  maxLines: 1,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: new SizedBox(
                width: widget.bannerList.length * 12.0,
                height: 6.0,
                child: new Row(
                  children: _indicators,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _initIndicators() {
    _indicators.clear();
    for (int i = 0; i < widget.bannerList.length; i++) {
      _indicators.add(new CircleAvatar(
        radius: 6.0,
        backgroundColor: i == _curIndicatorsIndex ? Colors.white : Colors.grey,
      ));
    }
  }

  _changePage(int index) {
    _curIndicatorsIndex = index;
    setState(() {});
  }
}
