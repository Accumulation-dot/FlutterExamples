import 'package:myapp/models/category.dart';

class CategoriesSelection {
  
  /// 所有选项的内容
  List<Category>categories = [];

  /// 默认选中的内容
  int selectedIndex = 0;

  /// 默认方法
  CategoriesSelection({this.categories, this.selectedIndex});
}