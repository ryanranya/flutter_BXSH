import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.5,
            color: Colors.black12,
          )
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return _leftInkWell(index);
        },
      )
    );
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(100),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(30)),
        ),
      ),
    );
  }

  //内部方法调试接口
  void _getCategory() async {
    request("getCategory").then((value) {
      var data = json.decode(value.toString());
      CategoryModel categorylist = CategoryModel.fromJson(data);
      setState(() {
        list = categorylist.data;
      });

//      List.data.forEach((item) => print(item.mallCategoryName));
    });

  }
}
