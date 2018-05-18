import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new HomePageState();

}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('New Perks!'),
                  subtitle: const Text('Check Out the New Drinks, made by our real baristas!'),
                ),
                new ButtonTheme.bar( // make buttons use the appropriate styles for cards
                  child: new ButtonBar(
                    children: <Widget>[
                      new FlatButton(
                        child: const Text('ORDER NOW'),
                        onPressed: () { /* ... */ },
                      ),
                      new FlatButton(
                        child: const Text('MORE INFO'),
                        onPressed: () { /* ... */ },
                      ),
                    ],
                  ),
                ),
              ],
            )
        );
      },
    );
  }

}