import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:meteo_flutter/services/user_location.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = 'not found', temp = '0';

  bool daySun = false, done = false;
  Map weatherData = {};
  UserLoc userLoc = UserLoc();
  DateTime time = DateTime.now();
  String strTime = '';

  updateInfo() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weatherData = ModalRoute.of(context).settings.arguments;

    // time = time.subtract(Duration(hours: weatherData['utcDiff']));
    strTime = DateFormat.jm().format(time);
    print(weatherData);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.location_on_sharp),
          iconSize: 30,
          color: Colors.red,
          onPressed: () {
            updateInfo();
          },
        ),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => print('tapped'),
                child: SvgPicture.asset(
                  'assets/images/menu.svg',
                  width: 30,
                  height: 30,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            weatherData['time'] == 'day'
                ? Image.asset(
                    'assets/images/day.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  )
                : Image.asset(
                    'assets/images/night.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 150.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    Text(
                      weatherData['location'] + ', ' + weatherData['country'],
                      style: TextStyle(
                        color: weatherData['time'] == 'night'
                            ? Colors.white
                            : Colors.black,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${weatherData['temp']}°c',
                      style: TextStyle(
                        color: weatherData['time'] == 'night'
                            ? Colors.white
                            : Colors.black,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        strTime,
                        style: TextStyle(
                          fontSize: 60,
                          color: weatherData['time'] == 'night'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
