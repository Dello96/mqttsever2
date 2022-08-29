import 'package:flutter/material.dart';

class GlassGroupData {
  late Function changeState;
  late bool activeStatus;
  late String allboard;
  late double allSliderValue;

  List<GlassData> glasses = [
    GlassData(glassNAme: 'Glass1', board: 'CONTROL/35/1', sliderValue: 0.0),
    GlassData(glassNAme: 'Glass2', board: 'CONTROL/35/2', sliderValue: 0.0),
    GlassData(glassNAme: 'Glass3', board: 'CONTROL/35/3', sliderValue: 0.0),
    GlassData(glassNAme: 'Glass4', board: 'CONTROL/35/4', sliderValue: 0.0)
  ];
  GlassGroupData({required this.activeStatus, required this.allboard, required this.allSliderValue});
}

class GlassData {
  String board;
  double sliderValue;
  String glassNAme;
  GlassData({required this.board, required this.sliderValue, required this.glassNAme});
}

GlassGroupData myData = GlassGroupData(activeStatus: true, allboard: 'CONTROL/ALL', allSliderValue: 0.0);