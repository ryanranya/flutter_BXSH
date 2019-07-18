import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/cart.dart';
import 'package:baixingshenghuo_shop/provide/details_info.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsinfo =
        Provider.of<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsinfo.goodsId;
    var goodsName = goodsinfo.goodsName;
    var count = 1;
    var price = goodsinfo.oriPrice;
    var images = goodsinfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(90),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              height: ScreenUtil().setHeight(90),
              alignment: Alignment.center,
              color: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context)
                  .save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(90),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context).remove();
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(90),
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
