import 'package:flutter/material.dart';

const costumeTextField = InputDecoration(
  filled: true,
  fillColor: Color(0xFFD9D9D9),
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey), // Adjust hint text color as needed
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);