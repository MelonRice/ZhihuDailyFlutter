import 'package:zhihudaily/model/base_model.dart';
import 'package:zhihudaily/model/theme_list_model.dart';
import 'package:zhihudaily/presenter/mvp.dart';

abstract class ThemeListPresenter implements IPresenter {
  loadThemeList(String themeId, String lastId);
}

abstract class ThemeListView implements IView<ThemeListPresenter> {
  void onLoadThemeListSuc(BaseModel<ThemeListModel> model);
  void onLoadThemeListFail();
}
