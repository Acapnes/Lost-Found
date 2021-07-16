import 'dart:async';

import 'package:bulundum_mobile/Login-Register/LoginPage.dart';
import 'package:bulundum_mobile/MainMenu/MenuPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String sk1 = "", sk2 = "";
  bool LoggedIn = false, AnimRun = false;

  @override
  void initState() {
    if (AnimRun == false) {
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..forward();
      AnimRun = true;
    }
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sk1 = sharedPreferences.get("Username");
    sk2 = sharedPreferences.get("Password");
    print(sk1);
    print(sk2);
  }

  @override
  Widget build(BuildContext context) {
    Animation<RelativeRect> _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height),
      end: RelativeRect.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height / 2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Animation<RelativeRect> _animation2 = RelativeRectTween(
      begin:
          RelativeRect.fromLTRB(0, 0, 0, -MediaQuery.of(context).size.height),
      end: RelativeRect.fromLTRB(
          0, 0, 0, -MediaQuery.of(context).size.height / 4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Stack(
          children: <Widget>[
            PositionedTransition(
              rect: _animation,
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Image(
                    image: AssetImage("img/icon.png"),
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: _animation2,
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Image(
                    image: AssetImage("img/bulundum-yazi.png"),
                  ),
                ),
              ),
            ),
            RaisedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondPage()));
            }),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 70,
                  height: 90,
                  child: GestureDetector(
                    onTap: () {
                      initState();
                      if (sk1 != null && sk2 != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginMain()));
                      }
                    },
                    child: Container(
                        child: Image(
                      image: AssetImage("img/right_arrow.png"),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Text("Bulduğunuzu Ulaştırın",style: TextStyle(fontSize: 30,color: Colors.orangeAccent),),
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("2. Sayfa"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Kaybettiğinize Ulaşın",
                          style:
                              TextStyle(fontSize: 35, color: Colors.blueAccent),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Bulduğunuzu Ulaştırın",
                          style: TextStyle(
                              fontSize: 35, color: Colors.orangeAccent),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Color(0xFF0078CE),
                      child: Text("Tanıtım",
                          style: TextStyle(color: Colors.white,fontSize: 18)),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Color(0xFF0078CE),
                      child: Text("Oturum Aç",
                          style: TextStyle(color: Colors.white,fontSize: 18)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}