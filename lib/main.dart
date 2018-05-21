import 'package:flutter/material.dart';
import 'perks.dart';
import 'home.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primaryColor: new Color(0xFF137f45),
        accentColor: new Color(0xFF000000),
        primaryColorLight: new Color(0xFF4faf71),
        primaryColorDark: new Color(0xFF00511c),
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: (_state==0 ? new HomePage() : new PerksPage()),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _state,
        onTap: (int index){
          setState(() {
            _state = index;
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
    ),
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
