<h1 align='center'>
<img src="https://github.com/AHMRezaul/Clima-Weather/blob/main/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png" width="200" height="200">
<br> Clima - Weather App </br>
</h1>

<h4 align="center">
A mobile application developed using flutter technologies.
Download the application from this link: "https://github.com/AHMRezaul/Clima-Weather/blob/main/clima/universal.apk"
</h4>


## Overview
A flutter mobile application that can run on any android smartphones or iOS smartphones. The application uses the device location and fetches the weather data from the Internet for the user. It can also fetch the weather information of any city across the world and provide that to the user. The app requires the following from the user: 
1. Internet Connection
2. Device Location Access

Using these technologies, the application can fetch the geo-location of the device and use that location to grab the weather data from the internet, such as, **Temperature (in Celsius), Weather Condition, Humidity (Percentage), Sunrise and Sunset time, Local Time of the location,** and finally provide a **short description**. The app also shows an animated progression of the remaining time until sunset.
The app can also be used to find the weather data of any major city across the world by a simple search. The *Search Field* takes a *valid city name* as input and loads the weather data from the internet for the user. The app also changes the background depending on the weather of the search location or the location of the user.

## Tools:
The application is developed using **Flutter Technologies** and **Dart** language. Flutter is a technology developed by Google that can create both an **Android** and an **iOS** application simultaneously. 
In this app, different custom widgets were created and the use of *navigation* system was made to navigate between the pages. Also, the integration of **API** made the live weather data viewing possible.
The following tools and software were used to develop the application:
1. Flutter
2. Dart
3. Android Studio
4. Emulator

### Technical details:
Flutter version: 2.8.1

Dart version: 2.1.5

geolocator: ^3.0.1

http: ^0.12.0+2

flutter_spinkit: ^3.1.0

intl: ^0.17.0

flutter_rounded_progress_bar: ^0.2.0

OpenWeatherMap API

## Installation:
To run the project, clone the repository and open it using *Android Studio*. 
Open the **pubspec.yaml** file and run the following command,

```
Flutter pub get
```

This will download all the dependencies and packages required for the project. Next, run the emulator and finally, build and run the application on the emulator.

To install the application directly from an apk, download the file from this link and install on any device. 
"https://github.com/AHMRezaul/Clima-Weather/blob/main/clima/universal.apk"

## App preview:
### Loading Screen:
![Loading Screen](https://github.com/AHMRezaul/Clima-Weather/blob/main/loading.png)

### Weather Page Demo:
![Clear Sky](https://github.com/AHMRezaul/Clima-Weather/blob/main/weather1.png)
![Misty](https://github.com/AHMRezaul/Clima-Weather/blob/main/weather2.png)
![Cloudy](https://github.com/AHMRezaul/Clima-Weather/blob/main/weather3.png)
![Light Rain](https://github.com/AHMRezaul/Clima-Weather/blob/main/weather4.png)
![Drizzling](https://github.com/AHMRezaul/Clima-Weather/blob/main/weather5.png)
![Snowing](https://github.com/AHMRezaul/Clima-Weather/blob/main/weather6.png)

### Get weather by City Name:
![Get weather](https://github.com/AHMRezaul/Clima-Weather/blob/main/city-name.png)