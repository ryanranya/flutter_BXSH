import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/details_info.dart';
import 'package:baixingshenghuo_shop/pages/details_page/details_top_area.dart';
import 'package:baixingshenghuo_shop/pages/details_page/details_explain.dart';
import 'package:baixingshenghuo_shop/pages/details_page/details_tabbar.dart';
import 'package:baixingshenghuo_shop/pages/details_page/details_web.dart';
import 'package:baixingshenghuo_shop/pages/details_page/details_bottom.dart';


class DetailsPage extends StatelessWidget {
  final String goodsId;

  //构造函数
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情页面"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FutureBuilder(
          future: _getGoodsInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: <Widget>[
                        DetailsTopAread(),
                        DetailsExplain(),
                        DetailsTabbar(),
                        DetailsWeb()
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailsBottom(),
                  ),
                ],
              );
            } else {
              return Text('加载中。。。');
            }
          }),
    );
  }

  Future _getGoodsInfo(BuildContext context) async {
    await Provider.of<DetailsInfoProvide>(context, listen: false)
        .getGoodsInfo(goodsId);

    return '完成加载';
  }
}
