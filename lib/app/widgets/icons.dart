import 'package:flutter/material.dart';
import 'package:get_x/app/core/values/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: Colors.red),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: Colors.green),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: Colors.yellow),
    Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: Colors.purple),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: Colors.blue),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: Colors.orange),
  ];
}
