import 'package:flutter/material.dart';

class KConstants {
  static const String themeModeKey='themeModeKey';
}

class KTextStyle {
  static const TextStyle titleTealText = TextStyle(
    color: Colors.teal,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 16.0,
  );

}

class KItemList {
  static const List<Map<String, String>> items = [
    {
      "title": "Sky Garden",
      "description": "A rooftop botanical garden that offers panoramic views of the city skyline."
    },
    {
      "title": "Echo Lamp",
      "description": "A smart lamp that changes color based on ambient noise levels in the room."
    },
    {
      "title": "Nomad Wallet",
      "description": "A travel-friendly wallet with built-in GPS tracking and RFID protection."
    },
    {
      "title": "Aqua Writer",
      "description": "An eco-friendly pen that uses water-soluble ink and biodegradable materials."
    },
    {
      "title": "Quantum Café",
      "description": "A science-themed coffee shop where each drink is named after a physics concept."
    }
  ];

}
