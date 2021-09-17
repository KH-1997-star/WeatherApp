import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WeatherRequest {
  String city = 'tunis';
  DateTime sunSet;
  DateTime sunRise;
  String temp;
  String time = 'day';
  int hoursAdd;

  WeatherRequest({this.city});
  var year = DateTime.now().year,
      month = DateTime.now().month.toString().length == 1
          ? '0${DateTime.now().month}'
          : DateTime.now().month,
      day = DateTime.now().day == 1
          ? '0${DateTime.now().day}'
          : DateTime.now().day;

  DateTime getClockInUtcPlus3Hours(int timeSinceEpochInSec, int hoursAdd) {
    String hour, minute;

    final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000,
            isUtc: true)
        .add(Duration(hours: hoursAdd));
    hour = time.hour.toString().length == 1 ? '0${time.hour}' : '${time.hour}';

    minute = time.minute.toString().length == 1
        ? '0${time.minute}'
        : '${time.minute}';
    return DateTime.parse('$year-$month-$day $hour:$minute');
  }

  Future<void> getWeather() async {
    try {
      Response response = await get(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=364f27fbbc64a5d9f67458091345b3d4');
      Map results = await jsonDecode(response.body);
      print(results);

      double numbr = await (results['timezone'] / 3600);
      hoursAdd = numbr.toInt();

      temp = (results['main']['temp'] - 273.15).toString().substring(0, 2);
      sunSet = getClockInUtcPlus3Hours(results['sys']['sunset'], hoursAdd);
      sunRise = getClockInUtcPlus3Hours(results['sys']['sunrise'], hoursAdd);
      if (DateTime.now().isAfter(sunRise) && DateTime.now().isBefore(sunSet)) {
        time = 'day';
      } else {
        time = 'night';
      }
    } catch (e) {
      print('cought error : $e');
      sunRise = DateTime.now();
      sunSet = DateTime.now().add(Duration(hours: 1));
    }
  }
}
