import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    String apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    Location location = Location();

    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    // to use this weather data in other parts of the app we need to do the following
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
