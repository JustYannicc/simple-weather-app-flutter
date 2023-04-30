import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mapbox_gl/mapbox_gl.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Basic Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  String position = '';

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request the user to enable location services
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // Location services are still not enabled, return
        return;
      }
    }

    // Check the user's location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied location permissions permanently, return
      return;
    } else if (permission == LocationPermission.denied) {
      // Request location permissions from the user
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // The user denied location permissions, return
        return;
      }
    }

    // Get the user's current location
    Position position = await Geolocator.getCurrentPosition();
    //debugPrint(position.toString());
    setState(() {
      this.position = position.toString();
    });
  }

  String formatedlocation = '';
  double latitude = 47.3769;
  double longitude = 8.5417;

  formatlocation(pos) {
    final String input = pos.toString();

    final latitude = double.parse(input.split(':')[1].split(',')[0].trim());
    final longitude = double.parse(input.split(':')[2].trim());

    final formatedlocation = '$latitude,$longitude';
    setState(() {
      this.formatedlocation = formatedlocation;
      this.longitude = longitude;
      this.latitude = latitude;
    });
    return formatedlocation;
  }


  String currenttemp = '';
  String currentcondition = '';
  String currentwind = '';
  String currenthumidity = '';
  String currentfeelslike = '';
  String currentuv = '';
  String currentvisibility = '';
  String currentpressure = '';
  String currentcloud = '';
  String currentprecipitation = '';
  String currentwinddir = '';
  String currentwinddegree = '';
  String currentwindgust = '';
  String currenticon = '';
  String currentlocation = '';
  String currentairquality = '';

  Future<void> fetchcurrentweather(formatedlocation) async {
    var apiKey = 'fad8109ce3ec4083978154521212708';
    var getweatherURL =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$formatedlocation&aqi=yes';
    var url = Uri.parse(getweatherURL);
    var response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);

    setState(() {
      this.currenttemp = data['current']['temp_c'].toString();
      this.currentcondition = data['current']['condition']['text'].toString();
      this.currentwind = data['current']['wind_kph'].toString();
      this.currenthumidity = data['current']['humidity'].toString();
      this.currentfeelslike = data['current']['feelslike_c'].toString();
      this.currentuv = data['current']['uv'].toString();
      this.currentvisibility = data['current']['vis_km'].toString();
      this.currentpressure = data['current']['pressure_mb'].toString();
      this.currentcloud = data['current']['cloud'].toString();
      this.currentprecipitation = data['current']['precip_mm'].toString();
      this.currentwinddir = data['current']['wind_dir'].toString();
      this.currentwinddegree = data['current']['wind_degree'].toString();
      this.currentwindgust = data['current']['gust_kph'].toString();
      this.currenticon = data['current']['condition']['icon'].toString();
      this.currentlocation = data['location']['name'].toString();
      this.currentairquality = data['current']['air_quality']['us-epa-index'].toString(); //us-epa-index
    });
  }

  Future<void> manageweather() async {
    await _getLocation();
    var formatedlocation = await formatlocation(position);
    await fetchcurrentweather(formatedlocation);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Stack(
              children: [

                MapboxMap(
                  accessToken: 'pk.eyJ1IjoianVzdHlhbm5pY2MiLCJhIjoiY2xoMjhmY2xiMWIweTNxcnptemcxYWVsOCJ9.nNpMduoTVhCHkvecc0ffCw',
                  onMapCreated: (controller) {
                    // Add any initialization code here
                  },
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  styleString: 'mapbox://styles/justyannicc/clh28i7gb00kx01qybd5l5mwx',
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: 11.0,
                  ),
                  scrollGesturesEnabled: false,
                  attributionButtonPosition: AttributionButtonPosition.BottomRight,
                ),

                Container(
                  color: Colors.black.withOpacity(0.1), // set the background color to black with 50% opacity
                ),
              ],
            )
          ),

          Positioned.fill(
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Current Temperature:',
                  ),
                  Text(
                    '$currenttemp',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: manageweather,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
