import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    //initState only gets called once and that's when it's rendered to the screen
    super.initState();
    getLocation();
  }

  void getData() async {
    String apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=$apiKey'));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(
          data); // because jsonDecode(data)'s type is dynamic we leave it as var which is for dynamic things
      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print('Temperature = $temperature');
      print('Condition = $condition');
      print('city = $cityName');
    } else {
      print(response.statusCode);
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    // ⬆ we need to wait for line 20 (add await keyword) to complete before we use it, so we need to make the function we're waiting for (getCurrentLocation) a Future fn
    print("LATITUDE: ${location.latitude}");
    print("LONGITUDE: ${location.longitude}");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // build gets called everytime something gets changed so better to put
    // get location in init as it uses less resources/ phone battery cos its
    // not called over and over again!
    return Scaffold();
  }
}
