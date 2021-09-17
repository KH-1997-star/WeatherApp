import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meteo_flutter/services/user_location.dart';
import 'package:meteo_flutter/services/weather_request.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  UserLoc userLoc = UserLoc();

  void getLocationWeather() async {
    await userLoc.getLoc();
    WeatherRequest weatherRequest = WeatherRequest(city: userLoc.city);
    await weatherRequest.getWeather();

    Navigator.pushReplacementNamed(context, '/weather_screen', arguments: {
      'location': userLoc.city,
      'country': userLoc.country,
      'sunset': weatherRequest.sunSet,
      'sunrise': weatherRequest.sunRise,
      'temp': weatherRequest.temp,
      'time': weatherRequest.time,
      'utcDiff': weatherRequest.hoursAdd,
    });
  }

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.blue,
          size: 150,
        ),
      ),
    );
  }
}
