import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:baixingshenghuo_shop/pages/home_page.dart';
import 'package:baixingshenghuo_shop/pages/cart_page.dart';
import 'package:baixingshenghuo_shop/pages/category_page.dart';
import 'package:baixingshenghuo_shop/pages/member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:baixingshenghuo_shop/provide/currentIndex.dart';


class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    //设置底部导航栏 Tabbar
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    )
  ];

  //类的数组
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context); //设置屏幕适配
    final val = Provider.of<CurrentIndexProvide>(context);
    int currenIndex = Provider.of<CurrentIndexProvide>(context).currentIndex;
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currenIndex,
        items: bottomTabs,
        onTap: (index) {
          Provider.of<CurrentIndexProvide>(context).changeIndex(index);
        },
      ),
      //保持页面的状态
      body: IndexedStack(
        index: currenIndex,
        children: tabBodies
      ),
    );
  }
}