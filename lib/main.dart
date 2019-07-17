import 'package:flutter/material.dart';
import 'package:baixingshenghuo_shop/pages/index_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/child_category.dart';
import 'package:baixingshenghuo_shop/provide/cartegory_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'package:baixingshenghuo_shop/routers/routers.dart';
import 'package:baixingshenghuo_shop/routers/application.dart';
import 'package:baixingshenghuo_shop/provide/details_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状态管理
    //分类管理
    var childCategory = ChildCategory();
//  //分类详情商品列表
    var catergoyGoodsListProvide = CategoryGoodsListProvide();
    //商品详情
    var detailsInfoProvide = DetailsInfoProvide();

//路由跳转
    final router = Router();
    //注入文件
    Routers.configureRoutes(router);
    Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => childCategory),
        ChangeNotifierProvider(builder: (_) => catergoyGoodsListProvide),
        ChangeNotifierProvider(builder: (_) => detailsInfoProvide),
      ],
      child: Container(
        child: MaterialApp(
          title: '百姓生活+',
          onGenerateRoute: Application.router.generator,
          //去掉DEBUG字样
          debugShowCheckedModeBanner: false,
          //设置主题
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    );

//    return
  }
}
