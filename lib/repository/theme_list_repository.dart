import 'dart:async';

import 'package:zhihudaily/model/theme_list_model.dart';
import 'package:zhihudaily/model/base_model.dart';

abstract class ThemeListRepository {

  Future<BaseModel<ThemeListModel>> loadThemeList(String themeId,String lastId);

}
