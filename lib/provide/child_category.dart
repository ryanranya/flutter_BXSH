import 'package:flutter/material.dart';
import 'package:baixingshenghuo_shop/model/category_model.dart';

//混入
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List list){

    childCategoryList = list;

    notifyListeners();

  }

}