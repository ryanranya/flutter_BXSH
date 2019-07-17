import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:baixingshenghuo_shop/provide/details_info.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopAread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value =
        Provider.of<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    if (value != null) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _goodsImage(value.image1),
            _goodsName(value.goodsName),
            _goodsNum(value.goodsSerialNumber),
            _goodsPirce(value.presentPrice, value.oriPrice),
          ],
        ),
      );
    } else {
      return Text('正在加载中...');
    }
  }

  //顶部商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  //商品名称

  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(34)),
        maxLines: 1,
      ),
    );
  }

  //商品编号

  Widget _goodsNum(String num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 5),
      child: Text(
        '编号:${num}',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
          color: Colors.black26,
        ),
        maxLines: 1,
      ),
    );
  }

  //商品价格
  Widget _goodsPirce(double nowPrice, double oldPirce) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: _nowPriceLabel(nowPrice),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: Text('市场价:'),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: _oldPriceLabel(oldPirce),
          )
        ],
      ),
    );
  }

  Text _nowPriceLabel(double nowPrice) {
    return Text(
      '￥${nowPrice}',
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.red),
    );
  }

  Text _oldPriceLabel(double oldPrice) {
    return Text(
      '￥${oldPrice}',
      style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          color: Colors.black26,
          decoration: TextDecoration.lineThrough),
    );
  }
}
