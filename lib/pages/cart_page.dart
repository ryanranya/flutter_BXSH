import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/cart.dart';
import 'package:baixingshenghuo_shop/pages/cart_page/cart_item.dart';
import 'package:baixingshenghuo_shop/pages/cart_page/cart_bottom.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provider.of<CartProvider>(context).cartList;
            final childCatgory = Provider.of<CartProvider>(context);
            cartList = Provider.of<CartProvider>(context).cartList;
            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (context, index) {
                    return CartItem(cartList[index]);
                  },
                  itemCount: cartList.length,
                ),
                Positioned(
                  child: CartBottom(),
                  bottom: 0,
                  left: 0,
                )
              ],
            );
          } else {
            return Text('正在加载。。。');
          }
        },
        future: _getCartInfo(context),
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context).getCartInfo();
    return 'end';
  }
}
