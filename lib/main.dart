import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'City Brew Coffee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _state = 0;

  @override
  Widget build(BuildContext context) {

    MyBottomNav _bottomNav = new MyBottomNav(listener: this,);


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: (_state==0 ? new Text("Hello") : new _PerksPage()),
      bottomNavigationBar: _bottomNav,
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: null,
        tooltip: 'Increment',
        icon: new Icon(Icons.store),
        label: new Text("Order Now"),
      ),
    );
  }

  void stateChanged(int state) {
    _state = state;
  }
}

class _PerksPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _PerksPageState();

}

class _PerksPageState extends State <_PerksPage> {

  Future<http.Response> fetchPost() async{
    final response = await http.get('https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Example');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    var cardNumber = '40280 0000 00563';
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
//        _getPerkCard(cardNumber),
        new Card(
            margin: new EdgeInsets.all(16.0),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(16.0),
            ),
            child: new Container(
                padding: EdgeInsets.only(
                  left: 70.0,
                  right: 70.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: new Image.network(
                  'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=' +  cardNumber,
                )
            )

        ),
        new Divider(),
      ],
    );
  }
}

Widget _getPerkCard(String cardNumber){
  return new Card(
      color: Colors.grey[700],
      margin: new EdgeInsets.all(16.0),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(16.0),
      ),
      child:
      new ListTile(
        leading: new Icon(Icons.album),
        title: new Text('City Brew Coffee', style: new TextStyle(
            color: Colors.white
        ),),
        subtitle: new Text(cardNumber),
      )
  );
}

class MyBottomNav extends StatefulWidget{
  MyBottomNav({Key key, this.listener}) : super(key: key);

  final _MyHomePageState listener;

  @override
  State<StatefulWidget> createState() {
    MyBottomNavState state = new MyBottomNavState();
    return state;
  }

  void stateChanged(int state){
    listener.stateChanged(state);
  }

}

class MyBottomNavState extends State<MyBottomNav>{
  int _state = 0;

  Scaffold.of(context).

  void notifyStateChanged(){
    _listener.stateChanged(_state);
  }

  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      currentIndex: _state,
      onTap: (int index){
        setState(() {
          if(_state==0){
            _state=1;
          }else{
            _state = 0;
          };
          notifyStateChanged();
          print('$_state');
          Scaffold.of(context).build(context);
        });
      },
      items: [
        new BottomNavigationBarItem(
          title: new Text("Home"),
          icon: new Icon(Icons.home),
          backgroundColor: Colors.red,
        ),
        new BottomNavigationBarItem(
          title: new Text("Perks"),
          icon: new Icon(Icons.card_membership),
          backgroundColor: Colors.black,
        ),
      ],
    );
  }

}