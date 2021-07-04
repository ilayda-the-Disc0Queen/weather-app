import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;

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
    http.Response response = await http.get(api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid={API key});
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    // ⬆ we need to wait for line 20 (add await keyword) to complete before we use it, so we need to make the function we're waiting for (getCurrentLocation) a Future fn
    print("LATITUDE: ${location.latitude}");
    print(location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // build gets called everytime something gets changed so better to put
    // get location in init as it uses less resources/ phone battery cos its
    // not called over and over again!
    return Scaffold();
  }
}
