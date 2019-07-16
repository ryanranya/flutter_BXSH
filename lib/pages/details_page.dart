import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  
  final String goodsId;
  //构造函数
  DetailsPage(this.goodsId);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品Id:${goodsId}'),
      ),
      
    );
    
  }

}
