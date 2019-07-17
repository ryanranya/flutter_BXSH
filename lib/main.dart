import 'package:flutter/material.dart';
import 'package:baixingshenghuo_shop/pages/index_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/counter.dart';
import 'package:baixingshenghuo_shop/provide/child_category.dart';
import 'package:baixingshenghuo_shop/provide/cartegory_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'package:baixingshenghuo_shop/routers/routers.dart';
import 'package:baixingshenghuo_shop/routers/application.dart';

//void main() {
//  //顶层依赖
//var counter = Counter();
//  var providers = Provider();
//  //分类管理
//  var childCategory = ChildCategory();
//  //分类详情商品列表
//  var catergoyGoodsListProvide = CategoryGoodsListProvide();
//
//
////  //注册依赖(注意：多个状态管理需要把 ..provide(Provider<Counter>.value(counter)) 复制一行并且导入需要管理的类的头文件，然后声明，按照 Counter 这个类操作就好)
////  providers
////    ..(Provider<Counter>.value(counter))
////    ..provide(Provider<ChildCategory>.value(childCategory))
////    ..provide(
////        Provider<CategoryGoodsListProvide>.value(catergoyGoodsListProvide));
////  runApp(ProviderNode(child: MyApp(), providers: providers));
//  runApp(ChangeNotifierProvider<Counter>.value(
//    notifier:
//
//    child: MyApp(),
//  ));
//
//}

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

//路由跳转
    final router = Router();
    //注入文件
    Routers.configureRoutes(router);
    Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => childCategory),
        ChangeNotifierProvider(builder: (_) => catergoyGoodsListProvide),
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
