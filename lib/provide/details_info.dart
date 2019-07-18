import 'package:flutter/material.dart';

//数据model
import 'package:baixingshenghuo_shop/model/details_model.dart';

//后台获取数据
import 'package:baixingshenghuo_shop/service/service_method.dart';

//Json Data
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  bool isLeft = true;
  bool isRight = false;

  //TabBar切换方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }

  //后台获取商品数据
  getGoodsInfo(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((value) {
      var responseData = json.decode(value.toString());
      if (responseData != null) {
        goodsInfo = DetailsModel.fromJson(responseData);
        notifyListeners();
      }
    });
  }
}
