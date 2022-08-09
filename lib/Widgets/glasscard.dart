import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqttsever2/Widgets/Slider.dart';
import 'package:mqttsever2/Widgets/buttons.dart';
import 'package:mqttsever2/main.dart';
import 'dart:async';

class GlassControlCard extends StatefulWidget {
  String glassName;
  GlassControlCard({required this.glassName, Key? key}) : super(key: key);

  @override
  State<GlassControlCard> createState() => _GlassControlCardState();
}

class _GlassControlCardState extends State<GlassControlCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GroupGlass(groupName: 'Group1', mqttTopic: 'CONTROL/ALL'),
              GlassCardMini(glassName: 'Glass1', mqttTopic: 'CONTROL/0x42/0'),
              GlassCardMini(glassName: 'Glass2', mqttTopic: 'CONTROL/0x42/1'),
              GlassCardMini(glassName: 'Glass3', mqttTopic: 'CONTROL/0x42/2'),
              GlassCardMini(glassName: 'Glass4', mqttTopic: 'CONTROL/0x42/3')
            ],
          );
        },
      ),
    );
  }
}

class GlassCardMini extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String glassName;
  String mqttTopic;
  GlassCardMini({required this.glassName, required this.mqttTopic, Key? key}) : super(key: key);

  @override
  State<GlassCardMini> createState() => _GlassCardMiniState();
}

class _GlassCardMiniState extends State<GlassCardMini> {
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
    return Column(
      children: [
        Container(
          width: 400,
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  width: 1,
                  color: Colors.black
              )
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 50,
                  bottom: 100,
                  left: 50,
                  child: Container(
                      width: 100,
                      height: 50,
                      child: Text(widget.glassName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                  )
              ),
              Positioned(
                  top: 100,
                  left: 180,
                  child: Text('${_currentSliderValue.round().toString()}%')),
              Positioned(
                  top: 100,
                  bottom: 20,
                  left: 80,
                  child: Container(
                    width: 250,
                      height: 100,
                      child: glassSlider())
              ),
              Positioned(
                  top: 70,
                  right: 0,
                  child: glassButton2()),
              Positioned(
                  top: 70,
                  left: 0,
                  child: glassButton())
            ],
          ),
        ),
      ],
    );
  }

  Widget glassSlider () {
    return Container(
      width: 250,
      height: 100,
      child: SliderTheme(
        data: SliderThemeData(
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15)
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
  Widget glassButton () {
    return Container(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 0}', widget.client);
                _currentSliderValue = 0.0;
              });
            },
            child: Container(
              width: 80,
              height: 60,
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
                widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 100}', widget.client);
                _currentSliderValue = 100.0;
              });
            },
            child: Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/rectangle1.png'))
              ),
            )
        )
    );
  }
}

class GroupGlass extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String mqttTopic;
  String groupName;
  GroupGlass({required this.groupName, required this.mqttTopic, Key? key}) : super(key: key);

  @override
  State<GroupGlass> createState() => _GroupGlassState();
}

class _GroupGlassState extends State<GroupGlass> {
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
    return Column(
      children: [
        Container(
          width: 400,
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  width: 1,
                  color: Colors.black
              )
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 50,
                  bottom: 100,
                  left: 50,
                  child: Container(
                      width: 100,
                      height: 50,
                      child: Text(widget.groupName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                  )
              ),
              Positioned(
                  top: 50,
                  left: 200,
                  child: Text('${_currentSliderValue.round().toString()}%',
                    style: TextStyle(
                      fontSize: 30
                    ),)),
              Positioned(
                  top: 100,
                  bottom: 20,
                  left: 80,
                  child: Container(
                      width: 250,
                      height: 100,
                      child: glassSlider())
              ),
              Positioned(
                top: 70,
                right: 0,
                  child: glassButton2()),
              Positioned(
                top: 70,
                left: 0,
                  child: glassButton())
            ],
          ),
        ),
      ],
    );
  }

  Widget glassSlider () {
    return Container(
      width: 250,
      height: 100,
      child: SliderTheme(
        data: SliderThemeData(
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15)
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
  Widget glassButton () {
    return Container(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 0}', widget.client);
                _currentSliderValue = 0.0;
              });
            },
            child: Container(
              width: 80,
              height: 60,
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
                widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 100}', widget.client);
                _currentSliderValue = 100.0;
              });
            },
            child: Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/rectangle1.png'))
              ),
            )
        )
    );
  }
}
