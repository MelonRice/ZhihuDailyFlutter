class ThemeModel {
  final String thumbnail;
  final String description;
  final int id;
  final String name;
  final int color;

  const ThemeModel(
      {this.thumbnail, this.description, this.id, this.name, this.color});

  ThemeModel.fromJson(Map<String, dynamic> json)
      : thumbnail = json['thumbnail'],
        description = json['description'],
        id = json['id'],
        color = json['color'],
        name = json['name'];
}
