import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = new WeatherModel();
  int temperature;
  int humidity;
  String weatherIcon;
  String cityName;
  String message;
  String description;
  String bgimage;
  int timezone;
  var currentTime;
  var sunset;
  var sunrise;
  double percent;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        //time data
        timezone = 0;
        sunset = 0;
        sunrise = 0;
        currentTime = 0;
        percent = 0;

        //background image
        bgimage = 'images/sunny-day.jpeg';

        //weather data
        temperature = 0;
        humidity = 0;
        weatherIcon = '🤷‍';
        message = 'Unable to get weather data';
        cityName = '';
        description = 'Error';
        return;
      }
      // print(weatherData);
      //Time data calculation
      timezone = weatherData['timezone'];
      var tempCurrentTime = DateTime.now()
          .add(Duration(
              seconds: timezone - DateTime.now().timeZoneOffset.inSeconds))
          .millisecondsSinceEpoch;
      currentTime = DateFormat.jm()
          .format(DateTime.fromMillisecondsSinceEpoch(tempCurrentTime));
      var tempSunrise = weatherData['sys']['sunrise'] * 1000;
      var tempAdjustedSunrise = DateTime.fromMillisecondsSinceEpoch(tempSunrise)
          .add(Duration(
              seconds: timezone - DateTime.now().timeZoneOffset.inSeconds));
      var adjustedSunrise = tempAdjustedSunrise.millisecondsSinceEpoch;
      sunrise = DateFormat.jm().format(tempAdjustedSunrise);
      var tempSunset = weatherData['sys']['sunset'] * 1000;
      var tempAdjustedSunset = DateTime.fromMillisecondsSinceEpoch(tempSunset)
          .add(Duration(
              seconds: timezone - DateTime.now().timeZoneOffset.inSeconds));
      var adjustedSunset = tempAdjustedSunset.millisecondsSinceEpoch;
      sunset = DateFormat.jm().format(tempAdjustedSunset);

      // print(currentTime);
      // print(adjustedSunrise);
      // print(adjustedSunset);
      // print(DateTime.fromMillisecondsSinceEpoch(currentTime));
      // print(DateTime.fromMillisecondsSinceEpoch(adjustedSunrise));
      // print(DateTime.fromMillisecondsSinceEpoch(adjustedSunset));

      //Weather data calculation
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      humidity = weatherData['main']['humidity'];

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      description = weatherData['weather'][0]['description'];

      cityName = weatherData['name'];
      message = weather.getMessage(temperature);

      //Background Image
      bgimage = weather.getBgImage(
          condition, tempCurrentTime, adjustedSunrise, adjustedSunset);

      //percentage calculation
      int totalTime = adjustedSunset - adjustedSunrise;
      int tillNow = tempCurrentTime - adjustedSunrise;
      double tempPercent = tillNow / totalTime * 100;
      if (tempPercent >= 100) {
        percent = 100;
      } else if (tempPercent <= 0) {
        percent = 0;
      } else
        percent = tempPercent;
      // print(tempPercent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgimage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(
            height: double.infinity, width: double.infinity),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C ',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        // color: Colors.white30,
                        color: kBGColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '$description',
                          style: kOtherTextStyle,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: kBGColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Humidity: $humidity%',
                          style: kOtherTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: RoundedProgressBar(
                  style: RoundedProgressBarStyle(
                    borderWidth: 0,
                    widthShadow: 0,
                    colorProgress: Color.fromRGBO(87, 87, 87, 0.3),
                    backgroundProgress: Color.fromRGBO(0, 0, 0, 0.3),
                    colorProgressDark: Color.fromRGBO(87, 87, 87, 0.6),
                    colorBackgroundIcon: Color.fromRGBO(0, 0, 0, 0.3),
                    colorBorder: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                  milliseconds: 2000,
                  childLeft: Text(
                    "Sunrise:\n$sunrise",
                    textAlign: TextAlign.center,
                    style: kSunTextStyle,
                  ),
                  paddingChildLeft: EdgeInsets.only(left: 15),
                  childRight: Text(
                    "Sunset:\n$sunset",
                    textAlign: TextAlign.center,
                    style: kSunTextStyle,
                  ),
                  paddingChildRight: EdgeInsets.only(right: 15),
                  childCenter: Text(
                    "Current Time:\n$currentTime",
                    textAlign: TextAlign.center,
                    style: kSunTextStyle,
                  ),
                  percent: percent,
                  height: 65,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: kBGColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "$message $cityName",
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
