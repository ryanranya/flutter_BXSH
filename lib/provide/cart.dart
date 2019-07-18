import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:baixingshenghuo_shop/model/cardinfo_model.dart';

class CartProvider with ChangeNotifier {
  String cartString = '[]';

  List<CartInfoMdel> cartList = [];

  save(goodsId, goodsName, count, price, images) async {
    //初始化
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //转成 List
    List<Map> tempList = (temp as List).cast();
    //数量增加，商品不增加
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;

        cartList[ival].count++;

        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoMdel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    print('model ===========${cartList}');
    //添加通知，改变界面
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空完成===================');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        cartList.add(CartInfoMdel.fromJson(item));
      });
    }
    notifyListeners();
  }
}
