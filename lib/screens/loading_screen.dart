import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    //initState only gets called once and that's when it's rendered to the screen
    super.initState();
    getLocationData();
  }

  void getData() async {
    // because jsonDecode(data)'s type is dynamic we leave it as var which is for dynamic things
  }

  void getLocationData() async {
    // WeatherModel weatherModel = WeatherModel(); instead of writing all this you can instansiate it inline 👇🏽
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 70.0,
          duration: Duration(milliseconds: 1800),
        ),
      ),
    );
  }
}
