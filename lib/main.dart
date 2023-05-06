import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:ui';

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
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

class WeatherData {
  String temp;
  String condition;
  String wind;
  String humidity;
  String feelslike;
  String uv;
  String visibility;
  String pressure;
  String cloud;
  String precipitation;
  String winddir;
  String winddegree;
  String windgust;
  String icon;
  String location;
  String airquality;

  WeatherData({
    required this.temp,
    required this.condition,
    required this.wind,
    required this.humidity,
    required this.feelslike,
    required this.uv,
    required this.visibility,
    required this.pressure,
    required this.cloud,
    required this.precipitation,
    required this.winddir,
    required this.winddegree,
    required this.windgust,
    required this.icon,
    required this.location,
    required this.airquality,
  });
}

class MyHomePage extends StatefulWidget {
  final Position position;
  final WeatherData? weatherData;

  const MyHomePage({Key? key, required this.position, this.weatherData})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = widget.weatherData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                MapboxMap(
                  accessToken:
                      'pk.eyJ1IjoianVzdHlhbm5pY2MiLCJhIjoiY2xoMjhmY2xiMWIweTNxcnptemcxYWVsOCJ9.nNpMduoTVhCHkvecc0ffCw',
                  onMapCreated: (controller) {
                    // Add any initialization code here
                  },
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  styleString:
                      'mapbox://styles/justyannicc/clh28i7gb00kx01qybd5l5mwx',
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        widget.position.latitude, widget.position.longitude),
                    zoom: 12.0,
                  ),
                  scrollGesturesEnabled: false,
                  attributionButtonPosition:
                      AttributionButtonPosition.BottomRight,
                ),
                
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                          0.1), // set the background color to black with 50% opacity
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                        ),
                      ],
                    )
                  ),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 800,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.white.withOpacity(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          '${weatherData?.location}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          child: Image.network(
                            'https:${weatherData?.icon}',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weatherData?.temp}',
                                style: TextStyle(fontSize: 60),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '°C',
                                style: TextStyle(fontSize: 36),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${weatherData?.condition}',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),


                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wind',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.wind} kph',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Humidity',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.humidity}%',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Feels Like',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.feelslike} °C',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UV Index',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.uv}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Visibility',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.visibility} km',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pressure',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.pressure} mb',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cloud Cover',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.cloud}%',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Precipitation',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.precipitation} mm',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wind Direction',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.winddir}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wind Degree',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.winddir}°',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wind Gust',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.windgust} kph',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Air Quality Index',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${weatherData?.airquality}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    getLocation().then((position) async {
      // Use the position object here
      WeatherData weatherData = await fetchcurrentweather(position);
      setState(() {
        this.weatherData = weatherData;
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(position: position, weatherData: weatherData)));
    }).catchError((error) {
      // Handle the error here
    });
  }

  Future<WeatherData> fetchcurrentweather(position) async {
    var apiKey = 'fad8109ce3ec4083978154521212708';
    var formatedlocation =
        position.latitude.toString() + ',' + position.longitude.toString();
    var getweatherURL =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$formatedlocation&aqi=yes';
    var url = Uri.parse(getweatherURL);
    var response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);

    var weatherData = WeatherData(
      temp: data['current']['temp_c'].toString(),
      condition: data['current']['condition']['text'].toString(),
      wind: data['current']['wind_kph'].toString(),
      humidity: data['current']['humidity'].toString(),
      feelslike: data['current']['feelslike_c'].toString(),
      uv: data['current']['uv'].toString(),
      visibility: data['current']['vis_km'].toString(),
      pressure: data['current']['pressure_mb'].toString(),
      cloud: data['current']['cloud'].toString(),
      precipitation: data['current']['precip_mm'].toString(),
      winddir: data['current']['wind_dir'].toString(),
      winddegree: data['current']['wind_degree'].toString(),
      windgust: data['current']['gust_kph'].toString(),
      icon: data['current']['condition']['icon'].toString(),
      location: data['location']['name'].toString(),
      airquality: data['current']['air_quality']['us-epa-index'].toString(),
    );

    setState(() {
      this.weatherData = weatherData;
    });

    return weatherData;
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request the user to enable location services
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // Location services are still not enabled, return
        return Future.error('Location services are disabled.');
      }
    }

    // Check the user's location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied location permissions permanently, return
      return Future.error('Location permissions are denied permanently.');
    } else if (permission == LocationPermission.denied) {
      // Request location permissions from the user
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // The user denied location permissions, return
        return Future.error('Location permissions are denied.');
      }
    }

    // Get the user's current location
    Position position = await Geolocator.getCurrentPosition();
    return position;
    //debugPrint(position.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
