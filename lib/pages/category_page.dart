import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:baixingshenghuo_shop/provide/child_category.dart';
import 'package:baixingshenghuo_shop/model/categoryGoodsList_model.dart';
import 'package:baixingshenghuo_shop/provide/cartegory_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            Column(
              children: <Widget>[
                RightCategoryNavState(),
                CategorGoodsList(),
              ],
            )
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
  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
    _getGoodsList();
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
        ))),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
        ));
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });

        //把list 存下来
        var chiledList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;

        Provide.value<ChildCategory>(context)
            .getChildCategory(chiledList, categoryId);

        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border: Border(
              bottom: BorderSide(
                  width: 0.5, color: Color.fromRGBO(236, 236, 236, 1.0)),
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

      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var formData = {
      "categoryId": categoryId == null ? '4' : categoryId,
      "CategorySubId": "",
      "page": 1
    };
    request('getMallGoods', formData: formData).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      //状态管理
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsList.data);
    });
  }
}

class RightCategoryNavState extends StatefulWidget {
  @override
  _RightCategoryNavStateState createState() => _RightCategoryNavStateState();
}

class _RightCategoryNavStateState extends State<RightCategoryNavState> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              )),
          child: ListView.builder(
            //滚动方像
            scrollDirection: Axis.horizontal,
            //个数
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInwell(
                  index, childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInwell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
            5.0, ScreenUtil().setHeight(25), 5.0, ScreenUtil().setHeight(25)),
//        alignment: Alignment.center,
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    var formData = {
      "categoryId": Provide.value<ChildCategory>(context).categoryId,
      "categorySubId": categorySubId,
      "page": 1
    };
    request('getMallGoods', formData: formData).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      //状态管理
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表
class CategorGoodsList extends StatefulWidget {
  @override
  _CategorGoodsListState createState() => _CategorGoodsListState();
}

class _CategorGoodsListState extends State<CategorGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  var scrollcontroller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(builder: (context, child, data) {
      try {
        if (Provide.value<ChildCategory>(context).page == 1) {
          //列表位置放放到最上面
          scrollcontroller.jumpTo(0.0);
        }
      } catch (error) {
        print('第一次进入页面初始化：${error}');
      }

      //容错处理
      if (data.goodsList.length > 0) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                moreInfo: '加载中...',
                loadingText: '请稍后',
                loadText: '上拉加载',
                loadReadyText: '释放开始加载',
              ),
              child: ListView.builder(
                controller: scrollcontroller,
                itemBuilder: (context, index) {
                  return _listItemWidget(data.goodsList, index);
                },
                itemCount: data.goodsList.length,
              ),
              loadMore: () async {
                _getMoreList();
              },
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            child: Text(
              "暂未数据",
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
      }
    });
  }

  void _getMoreList() async {
    Provide.value<ChildCategory>(context).addPage();

    var formData = {
      "categoryId": Provide.value<ChildCategory>(context).categoryId,
      "categorySubId": Provide.value<ChildCategory>(context).subId,
      "page": Provide.value<ChildCategory>(context).page,
    };
    request('getMallGoods', formData: formData).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      //状态管理
      if (goodsList.data == null) {
        Fluttertoast.showToast(
          msg: '没有更多了',
          toastLength: Toast.LENGTH_SHORT,
          //显示位置
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
        );
        Provide.value<ChildCategory>(context).changeNoMoreData('没有更多......');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(goodsList.data);
      }
    });
  }

  //组合
  Widget _listItemWidget(List newlist, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Row(
          children: <Widget>[
            _goodsImage(newlist, index),
            Column(
              children: <Widget>[
                _goodsName(newlist, index),
                _goodsPrice(newlist, index),
              ],
            )
          ],
        ),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(List newlist, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0),
            width: ScreenUtil().setWidth(180),
            child: Text(
              "价格:￥${newlist[index].presentPrice}",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(26), color: Colors.pink),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 1.0),
            width: ScreenUtil().setWidth(180),
            child: Text(
              "价格:￥${newlist[index].oriPrice}",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  //商品名字
  Widget _goodsName(List newlist, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newlist[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //图片
  Widget _goodsImage(List newlist, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newlist[index].image),
    );
  }
}
