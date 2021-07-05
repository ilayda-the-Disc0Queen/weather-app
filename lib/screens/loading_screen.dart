import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    // ⬆ we need to wait for line above (add await keyword) to complete before we use it, so we need to make the function we're waiting for (getCurrentLocation) a Future fn
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
  }

  @override
  Widget build(BuildContext context) {
    // build gets called everytime something gets changed so better to put
    // get location in init as it uses less resources/ phone battery cos its
    // not called over and over again!
    return Scaffold();
  }
}

// double temperature = decodedData['main']['temp'];
// int condition = decodedData['weather'][0]['id'];
// String cityName = decodedData['name'];
