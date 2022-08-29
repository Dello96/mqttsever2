import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqttsever2/Widgets/Slider.dart';
import 'package:mqttsever2/Widgets/buttons.dart';
import 'package:mqttsever2/main.dart';
import 'dart:async';
import 'package:mqttsever2/Resources/data.dart';

class GlassCardMini extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  int x;

  GlassCardMini({required this.mqttClient, required this.client, required this.x, Key? key}) : super(key: key);

  @override
  State<GlassCardMini> createState() => _GlassCardMiniState();
}

class _GlassCardMiniState extends State<GlassCardMini> {
  final oneSec = Duration(milliseconds: 20);

  /*@override
  void initState() {
    super.initState();
    Timer.periodic(oneSec, (Timer t) {
      widget.mqttClient!.mqttPub(myData.glasses[widget.x].board, '{\"value\" : ${myData.glasses[widget.x].sliderValue.round()}}', widget.client);
      print(myData.glasses[widget.x].sliderValue);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          child: Stack(
            children: [
              Positioned(
                  top: 30,
                  left: 35,
                  child: Container(
                      width: 100,
                      height: 50,
                      child: Text(myData.glasses[widget.x].glassNAme,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                  )
              ),
              Positioned(
                  top: 50,
                  left: 180,
                  child: Container(child: Text('${myData.glasses[widget.x].sliderValue.round().toString()}%',
                      style: TextStyle(
                          fontSize: 30
                      )))),
              Positioned(
                  top: 65,
                  left: 100,
                  width: 220,
                  height: 80,
                  child: glassSlider()
              ),
              Positioned(
                  top: 70,
                  right: 20,
                  width: 80,
                  height: 70,
                  child: glassButton2()),
              Positioned(
                  top: 70,
                  left: 20,
                  width: 80,
                  height: 70,
                  child: glassButton())
            ],
          ),
        ),
      ],
    );
  }

  Widget glassSlider () {
    return Container(
      child: SliderTheme(
        data: SliderThemeData(
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15)
        ),
        child: Slider(
            value: myData.glasses[widget.x].sliderValue,
            max: 100,
            min: 0,
            divisions: 100,
            inactiveColor: Colors.black,
            thumbColor: Colors.white,
            activeColor: Colors.blueAccent,
            onChanged: (double value){
              setState(() {
                  myData.glasses[widget.x].sliderValue = value;
                  print(myData.glasses[widget.x].sliderValue.round().toString());
              });
            }),
      ),
    );
  }
  Widget glassButton () {
    return Container(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.mqttClient!.mqttPub(myData.glasses[widget.x].board, '{\"value\" : 0}', widget.client);
                myData.glasses[widget.x].sliderValue = 0.0;
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/rectangle2.png'))
              ),
            )
        )
    );
  }
  Widget glassButton2 () {
    return Container(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.mqttClient!.mqttPub(myData.glasses[widget.x].board, '{\"value\" : 100}', widget.client);
                myData.glasses[widget.x].sliderValue = 100.0;
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/rectangle1.png'))
              ),
            )
        )
    );
  }
}