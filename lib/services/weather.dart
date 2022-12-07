import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const APIKey = '246afc6fccd02e16035d25de6a722148';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$APIKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$APIKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time in';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in';
    } else {
      return 'Bring a 🧥 just in case in';
    }
  }

  String getBgImage(int condition, var currentTime, var sunrise, var sunset) {
    if (condition < 300) {
      //Thunderstorm
      return 'images/rain-night.png';
    } else if (condition < 400) {
      //Rain
      if ((currentTime >= sunrise) && (currentTime <= sunset)) {
        return 'images/rain-day.jpg';
      } else
        return 'images/rain-night.png';
    } else if (condition < 600) {
      //Drizzle
      if ((currentTime >= sunrise) && (currentTime <= sunset)) {
        return 'images/drizzle-day.jpg';
      } else
        return 'images/drizzle-night.jpg';
    } else if (condition < 700) {
      //Snow
      if ((currentTime >= sunrise) && (currentTime <= sunset)) {
        return 'images/snow.png';
      } else
        return 'images/snow-night.jpg';
    } else if (condition < 800) {
      //Mist
      if ((currentTime >= sunrise) && (currentTime <= sunset)) {
        return 'images/misty-day.jpg';
      } else
        return 'images/misty-night.jpeg';
    } else if (condition == 800) {
      //Sunny
      if ((currentTime >= sunrise) && (currentTime <= sunset)) {
        return 'images/sunny-day.jpeg';
      } else
        return 'images/sunny-night.png';
    } else if (condition <= 804) {
      //Cloud
      if ((currentTime >= sunrise) && (currentTime <= sunset)) {
        return 'images/cloudy-day.jpg';
      } else
        return 'images/cloudy-night.jpg';
    } else {
      //Error
      return 'images/sunrise.jpg';
    }
  }
}
