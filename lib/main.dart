import 'package:flutter/material.dart';
import 'package:baixingshenghuo_shop/pages/index_page.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        //去掉DEBUG字样
        debugShowCheckedModeBanner: false,
        //设置主题
        theme: ThemeData(
            primaryColor: Colors.pink

        ),
        home: IndexPage(

        ),
      ),

    );
  }
}
