import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baixingshenghuo_shop/provide/cart.dart';
import 'package:provider/provider.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          selectAllButton(context),
          allPriceArea(context),
          goButton(context),
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(context) {
    int allGoodsCount = Provider.of<CartProvider>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  //合计区
  Widget allPriceArea(context) {
    double allPrice = Provider.of<CartProvider>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免运费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  //全选按钮
  Widget selectAllButton(context) {
    bool isAllCheck = Provider.of<CartProvider>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            onChanged: (bool val) {
              Provider.of<CartProvider>(context).changeAllCheckBtnState(val);

            },
            checkColor: Colors.white,
            activeColor: Colors.red,
          ),
          Text('全选'),
        ],
      ),
    );
  }
}
