import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baixingshenghuo_shop/model/cardinfo_model.dart';
import 'package:baixingshenghuo_shop/pages/cart_page/cat_count.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoMdel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Colors.black12,
            width: 0.5,
          ))),
      child: Row(
        children: <Widget>[
          _cartCheckButton(context, item),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context, item)
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartProvider>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  //商品名字
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  //商品图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  //复选按钮
  Widget _cartCheckButton(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        onChanged: (bool val) {
          item.isCheck = val;
          Provider.of<CartProvider>(context).changeCheckState(item);
        },
        activeColor: Colors.pink,
      ),
    );
  }
}
