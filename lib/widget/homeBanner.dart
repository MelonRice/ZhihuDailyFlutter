import 'package:flutter/material.dart';
import 'package:starter/model/homePageModel.dart';

class HomeBanner extends StatefulWidget {
  final List<TopStoriesModel> bannerList;

  HomeBanner(this.bannerList);

  @override
  State<StatefulWidget> createState() => new HomeBannerState();
}

class HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    return buildBanner();
  }

  Widget buildBanner() {
    return new Container(
        height: 200.0,
        child: new Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: new Stack(
            children: <Widget>[
              buildPagerView(),
            ],
          ),
        ));
  }

  Widget buildPagerView() {
    return new PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return buildItem(context, index);
      },
      itemCount: widget.bannerList.length,
    );
  }

  Widget buildItem(BuildContext context, int index) {
    TopStoriesModel banner = widget.bannerList[index];

    return new GestureDetector(
      onTap: () {},
      child: new Image.network(
        banner.image,
        fit: BoxFit.fitWidth,
        height: 200.0,
      ),
    );
  }
}
