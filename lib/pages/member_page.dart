import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList(),
          ],
        ),
      ),
    );
  }

//头部试图
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pink,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setWidth(300),
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 30),
            child: Container(
              child: ClipOval(
                child: Image.network(
                  'https://upload.jianshu.io/users/upload_avatars/2791865/1f6d570c-69b1-44b4-9cd2-d0042a0da1fb.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'ZFW',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  //我的订单
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          itemIcon(Icons.party_mode, '待付款'),
          itemIcon(Icons.query_builder, '待发货'),
          itemIcon(Icons.directions_car, '待收货'),
          itemIcon(Icons.featured_play_list, '待评价'),

        ],
      ),
    );
  }
//icon Item
  Widget itemIcon(iconString, String itemName){
   return Container(
      width: ScreenUtil().setWidth(187),
      child: Column(

        children: <Widget>[
          Icon(
            iconString,
            size: 30,
          ),
          Text(itemName),
        ],
      ),
    );
  }

  //
  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTitle('领取优惠券',Icons.save),
          _myListTitle('已领取优惠券',Icons.map),
          _myListTitle('地址管理',Icons.zoom_out_map),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[

                _myListTitle('客服电话',Icons.phone),
                _myListTitle('关于我们',Icons.my_location),
              ],
            ),
          )
        ],
      ),
    );
  }

Widget _myListTitle(String title, icons){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(icons),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
}
}
