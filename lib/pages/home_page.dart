import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:baixingshenghuo_shop/routers/application.dart';

//import 'package:dio/dio.dart';
//import 'package:flutter_shop/config/httpHeaders.dart';

//Dio网络请求示例
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  //声明一个controller
//  TextEditingController typeController = TextEditingController();
//  String showText = '欢迎您来到凤凰阁';
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text('小康小店'),
//        ),
//        //越界的话使用widget添加一个滑动的组件
//        body: SingleChildScrollView(
//          child: Container(
//            child: Column(
//              children: <Widget>[
//                TextField(
//                  controller: typeController,
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    labelText: "需要小康的类型",
//                    helperText: '请输入您需要小康的类型',
//                  ),
//                  //自动对焦要关闭，避免界面乱码
//                  autofocus: false,
//                ),
//                RaisedButton(
//                  onPressed: () {
//                    _choiceAction();
//                  },
//                  child: Text('选择完毕'),
//                ),
//                Text(
//                  showText,
//                  //兼容性，需要加限制
//                  overflow: TextOverflow.ellipsis,
//                  maxLines: 1,
//
//                ),
//              ],
//            ),
//          ),
//        )
//
//      ),
//    );
//  }
//
//  //内部方法使用 _
//
//  void _choiceAction(){
//    if (typeController.text.toString() == ''){
//      showDialog(context: context,
//      builder:(context) => AlertDialog(title: Text('小康类型不能为空'),),
//      );
//    }else{
//      getHttp(typeController.text.toString()).then((value){
//        setState(() {
//          showText = value['data']['name'].toString();
//        });
//      });
//    }
//
//  }
//
//
////网络请求
//  Future getHttp(String TypeText) async{
//    try {
//      Response response;
//
//      var parameters = {"name": TypeText};
////      get请求
////      response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
////        queryParameters: data
////      );
////      post 请求
//      response = await Dio().post("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian",
//          queryParameters: parameters
//
//      );
//
//      return response.data;
//
//    }catch(error){
//
//      return print(error);
//
//    }
//
//  }
//
//}

//伪造请求头
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  String showText = "还没有请求数据";
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text('远程数据'),
//        ),
//        body: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              RaisedButton(
//                onPressed: () {
//                  _jike();
//                },
//                child: Text("请求数据"),
//              ),
//              Text(showText),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  //调用请求方法
//  void _jike(){
//    print('开始请求数据.......');
//    getHttp().then((onValue){
//      showText = onValue['data'].toString();
//
//    });
//
//  }
//
//  //网络请求
//  Future getHttp() async {
//    try {
//      Response response;
//      Dio dio = Dio();
//      dio.options.headers = httpHeaders;
//      response =
//          await dio.get("https://time.geekbang.org/serv/v1/column/topList");
//      print(response);
//      return response.data;
//    } catch (error) {
//      print(error);
//    }
//  }
//}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//保持页面状态
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
//火爆专区的列表
  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  //保持页面状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '104.050699', 'lat': '30.690167'};
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        //解决异步请求再渲染，不需要异步渲染
        body: FutureBuilder(
          future: request('homePageContent', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();

              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              List<Map> floor3 = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '加载中...',
                  loadingText: '请稍后',
                  loadText: '上拉加载',
                  loadReadyText: '释放开始加载',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swperDateList: swiper),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(recommendList: recommendList),
                    FloorTitle(picture_address: floor1Title),
                    FloorContent(
                      floorGoodsList: floor1,
                    ),
                    FloorTitle(picture_address: floor2Title),
                    FloorContent(
                      floorGoodsList: floor2,
                    ),
                    FloorTitle(picture_address: floor3Title),
                    FloorContent(
                      floorGoodsList: floor3,
                    ),
                    _hotGoods(),
                  ],
                ),
                loadMore: () async {
                  print('开始加载更多.......');
                  var formData = {'page': page};
                  await request('homePageBelowConten', formData: formData)
                      .then((value) {
                    var data = json.decode(value.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page += 1;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text(
                  '加载中...',
                  style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                ),
              );
            }
          },
        ));
  }

  //使用变量的方式创建
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  //使用方法创建
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((value) {
        return InkWell(
          onTap: () {
            //路由跳转
            Application.router
                .navigateTo(context, '/detail?id=${value['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(370),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            //设置内边距
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  value['image'],
                  width: ScreenUtil().setWidth(388),
                ),
                Text(
                  value['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${value['mallPrice']}'),
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        '￥${value['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        //列数
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swperDateList;

  SwiperDiy({Key key, this.swperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swperDateList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        //自动播放
        autoplay: true,
      ),
    );
  }
}

//导航控件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUi(BuildContext context, item) {
    //能接受一个单击事件
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    if (this.navigatorList.length > 10){
//      this.navigatorList.removeRange(10, navigatorList.length);
//
//    }

    double itemInts = this.navigatorList.length / 5;

    double TopNavigatorHeight = itemInts.ceil() * ScreenUtil().setHeight(190);
    return Container(
      height: ScreenUtil().setWidth(480),
//      padding: EdgeInsets.all(ScreenUtil().setHeight(3.0)),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(3.0),
          ScreenUtil().setWidth(20.0),
          ScreenUtil().setWidth(3.0),
          ScreenUtil().setWidth(10.0)),
      child: GridView.count(
        //设置 列表不能滑动
        physics: const NeverScrollableScrollPhysics(),
        //每行展示几个
        crossAxisCount: 5,
        //设置item之间的间距
        padding: EdgeInsets.all(
          ScreenUtil().setWidth(5.0),
        ),
        //设置每一个item
        children: navigatorList.map((item) {
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}

//广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        adPicture,
      ),
    );
  }
}

//店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //背景图片
  final String leaderPhone; //电话号码

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    print("${url}");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能访问，异常';
    }
  }
}

//商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

//标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品 item

  Widget _item(index) {
    return InkWell(
        onTap: () {},
        child: Container(
          height: ScreenUtil().setHeight(330),
          width: ScreenUtil().setWidth(250),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(width: 0.5, color: Colors.black12),
              )),
          child: Column(
            children: <Widget>[
              Image.network(recommendList[index]['image']),
              Text('￥${recommendList[index]['mallPrice']}'),
              Text(
                '￥${recommendList[index]['price']}',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }

  //横向类表方法

  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setWidth(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        //构造器
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(390),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList(),
        ],
      ),
    );
  }
}

//楼层标题

class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
