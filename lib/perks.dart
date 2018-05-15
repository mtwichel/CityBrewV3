import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'dart:async';
import 'package:transparent_image/transparent_image.dart';



class PerksPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _PerksPageState();

}

class _PerksPageState extends State <PerksPage> {



  LocationResult location = null;
  StreamSubscription<LocationResult> streamSubscription;
  bool trackLocation = false;
  int storeNum = 1;

  var locations = {
    1: [-108.558485, 45.783883],
    3: [-108.577248, 45.755775],
    5: [-108.614153, 45.754857],
    7: [-108.515731, 45.794672],
    9: [-108.770728, 45.665017],
    11: [-108.472538, 45.811303],
    18: [-108.597714, 45.783772],
  };

  @override
  void initState() {
    super.initState();
    checkGps();
  }

  bool isNear(){
    print("${location.location.longitude} | ${location.location.latitude}");
    SnackBar snackBar;
    if((locations[storeNum][1] - location.location.longitude).abs() < .01  && (locations[storeNum][2] - location.location.latitude).abs() < .01){
      snackBar = new SnackBar(content: new Text('Near'));
    }else{
      snackBar = new SnackBar(content: new Text('Not Near'));
    }
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var cardNumber = '40280 0000 00563';
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
//        _getPerkCard(cardNumber),
        new Container(
          margin: EdgeInsets.all(8.0),
          child: new ActionChip(
            label: new Text("CHECK IN NOW"),
            labelStyle: new TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            labelPadding: new EdgeInsets.symmetric(horizontal: 40.0),
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              getLocations();
            },

          ),
        ),

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
              child: new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Center(child: new CircularProgressIndicator()),
                  new Center(child: new FadeInImage.memoryNetwork(
                    image: ('https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=' + cardNumber),
                    placeholder: kTransparentImage,
                  )),
                ],

              ),
            )

        ),
        new Divider(),
      ],
    );
  }

  getLocations() {
    if (trackLocation) {
      setState(() => trackLocation = false);
      streamSubscription.cancel();
      streamSubscription = null;
      location = null;
    } else {
      setState(() => trackLocation = true);

      streamSubscription = Geolocation
          .currentLocation(
        accuracy: LocationAccuracy.best,
        inBackground: false,
      )
          .listen((result) {
        final newLocation = result;
        setState(() {
          location = newLocation;
          isNear();
        });
      });

      streamSubscription.onDone(() =>
          setState(() {
            trackLocation = false;
          }));
    }
  }

  void checkGps() async {
    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      print("Geolocation successful");
    } else {
      print("Geolocation unsuccessful");
    }
  }

  Widget _getPerkCard(String cardNumber) {
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
}