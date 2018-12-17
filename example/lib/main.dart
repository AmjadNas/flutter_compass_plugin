import 'package:flutter/material.dart';
import 'package:compass_plugin/compass_plugin.dart';



void main() => runApp(new MyApp());

class MyApp extends StatefulWidget  {
  @override
  _MyAppState createState() => new _MyAppState();


}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    CompassPlugin.initCompassListener;
  }

  @override
  void dispose(){
    CompassPlugin.stopCompassListener;
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Flutter Compass'),
        ),
        body:  Container(
          alignment: Alignment.center,
          color: Colors.white,
           child: StreamBuilder<double>(
             stream: CompassPlugin.getAzimuth,
             builder: (context, snapshot){
               if(snapshot.hasData)
                 return Text('Azimuth: ${snapshot.data.round()}');
               else
                 return Text('Azimuth: N/A');
             },
           ),
      ),
    )
    );
  }

  double getDir(){
    return 5;
  }


}
