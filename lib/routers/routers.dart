import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';

import './router_handler.dart';

//整体路由配置
class Routers {
  static String root = '/';

  //详情页面
  static String detailsPage = 'detail';

  //方法写理由整体配置静态方法

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        //没有页面自行处理
        print('ERROR===》ROUTE');
      },
    );
    router.define(detailsPage, handler: detailsHandler);
  }
}
