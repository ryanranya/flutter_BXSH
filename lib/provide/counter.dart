import 'package:flutter/material.dart';


//混入
class Counter with ChangeNotifier{
  int value = 0;

  increment(){

    value += 1;
    //发送通知
    NotificationListener();

  }


}