import 'package:flutter/material.dart';

const kBGColor = Color.fromRGBO(87, 87, 87, 0.6);

const kTempTextStyle = TextStyle(
  fontFamily: 'Lobster Regular',
  fontSize: 80.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Lobster Regular',
  fontSize: 40.0,
);

const kOtherTextStyle = TextStyle(
  fontFamily: 'Lobster Regular',
  fontSize: 20.0,
);

const kSunTextStyle = TextStyle(
  fontFamily: 'Lobster Regular',
  fontSize: 18.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Lobster Regular',
);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);
