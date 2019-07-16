import 'package:flutter/material.dart';
import 'package:baixingshenghuo_shop/model/categoryGoodsList_model.dart';

//混入
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];
  //点击大类更换商品列表数据源

  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();

  }

  getMoreList(List<CategoryListData> list){

    goodsList.addAll(list);

    notifyListeners();
  }

}
