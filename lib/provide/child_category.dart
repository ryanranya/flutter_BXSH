import 'package:flutter/material.dart';
import 'package:baixingshenghuo_shop/model/category_model.dart';

//混入
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //高亮显示
  String categoryId = '4'; //大类默认ID
  String subId = ''; //没有小类传空
  int page = 1; //类表页数
  String noMoreText = ''; //无更多数据
  //大类清零数据

  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    //往数组中添加元素
    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //增加page
  addPage() {
    page += 1;
  }

  changeNoMoreData(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
