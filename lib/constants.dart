import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFFC107), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFFC107), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
);

const kNotificationTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.white,
);

const kHintTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black54,
);

const kParagraph1TextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kParagraph2TextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kParagraph3TextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kHeaderTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
