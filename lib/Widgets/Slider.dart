import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqttsever2/main.dart';
import 'dart:async';


class GlassSlider extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String mqttTopic;
  GlassSlider({required this.mqttTopic, Key? key}) : super(key: key);

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}


class _GlassSliderState extends State<GlassSlider> {
  final oneSec = Duration(milliseconds: 20);
  double _currentSliderValue = 0;

  /*@override
  void initState() {
    super.initState();
    Timer.periodic(oneSec, (Timer t) {
      widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : ${_currentSliderValue.round()}}', widget.client);
      print(_currentSliderValue);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
      width: 300,
      child: SliderTheme(
        data: SliderThemeData(
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 25)
        ),
        child: Slider(
            value: _currentSliderValue,
            max: 100,
            min: 0,
            divisions: 100,
            inactiveColor: Colors.black,
            thumbColor: Colors.white,
            activeColor: Colors.blueAccent,
            onChanged: (double value){
              setState(() {
                _currentSliderValue = value;
                print(_currentSliderValue.round().toString());
              });
            }),
      ),
    );
  }
}
