class HomePageModel {
  static const int itemTypeNormal = 0;
  static const int itemTypeBanner = 1;

  final List images;
  final int type;
  final int id;
  final String title;

  int itemType = itemTypeNormal;

  HomePageModel({this.images, this.type, this.id, this.title});

  setItemType(int type) {
    itemType = type;
  }

  HomePageModel.fromJson(Map<String, dynamic> json)
      : images = json['images'],
        type = json['type'],
        id = json['id'],
        title = json['title'];
}

class TopStoriesModel {
  final String image;
  final int type;
  final int id;
  final String title;

  const TopStoriesModel({this.image, this.type, this.id, this.title});

  TopStoriesModel.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        type = json['type'],
        id = json['id'],
        title = json['title'];
}
