import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/cart.dart';
import 'package:baixingshenghuo_shop/pages/cart_page/cart_item.dart';

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
            return ListView.builder(
              itemBuilder: (context, index) {
               return CartItem(cartList[index]);
              },
              itemCount: cartList.length,
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
