import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/window/popup_page.dart';
import 'package:flutterapp/window/popup_window.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    //在 initState 方法中获取 BuildContext
    Future.delayed(Duration(seconds: 0), () {
      print(MediaQuery.of(context).size);
    });
  }

  double windowHeight = 200;
  var _bodyStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter UI"),
          actions: <Widget>[
            _nomalPopMenu(),
            PopupWindowButton(
              offset: Offset(0, windowHeight),
              child: Icon(Icons.share),
              window: Container(
                color: Colors.greenAccent,
                height: windowHeight,
              ),

              /// not required.
              builder: (Widget child, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
//            getItem(context, "侧滑删除", SlideButtonPage()),
//            getItem(context, "进度条", ArcProgressBarPage()),
//            getItem(context, "PageView指示器", SlideIndicatorPage()),
//            getItem(context, "ClearTextField", ClearTextFieldPage()),
            getItem(context, "PopupPage", PopupPage()),
          ],
        ));
  }

  ListTile getItem(BuildContext context, String title, Widget widget) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => widget));
      },
    );
  }

  Widget _nomalPopMenu() {
    return new PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  value: 'value01', child: Text('Item One')),
              new PopupMenuItem<String>(
                  value: 'value02', child: new Text('Item Two')),
              new PopupMenuItem<String>(
                  value: 'value03', child: new Text('Item Three')),
              new PopupMenuItem<String>(
                  value: 'value04', child: new Text('I am Item Four'))
            ],
        onSelected: (String value) {
          setState(() {
            _bodyStr = value;
          });
        });
  }
}
