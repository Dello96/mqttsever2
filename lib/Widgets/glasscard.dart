import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqttsever2/Widgets/Slider.dart';
import 'package:mqttsever2/Widgets/buttons.dart';
import 'package:mqttsever2/main.dart';
import 'dart:async';
import 'package:mqttsever2/Resources/data.dart';

class GlassControlCard extends StatefulWidget {
  final MqttClient? mqttClient;
  GlassControlCard({required this.mqttClient, Key? key}) : super(key: key);

  @override
  State<GlassControlCard> createState() => _GlassControlCardState();
}

class _GlassControlCardState extends State<GlassControlCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 770,
      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: GroupGlass(groupName: 'All',
                      mqttTopic: 'CONTROL/ALL',
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(glassName: 'Glass1',
                      mqttTopic: 'CONTROL/35/1',
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(glassName: 'Glass2',
                      mqttTopic: 'CONTROL/35/2',
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(glassName: 'Glass3',
                      mqttTopic: 'CONTROL/35/3',
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(glassName: 'Glass4',
                      mqttTopic: 'CONTROL/35/4',
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                )
              ],
            ),
    );
  }
}

class GlassCardMini extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String glassName;
  String mqttTopic;

  GlassCardMini({required this.glassName, required this.mqttTopic, required this.mqttClient, required this.client, Key? key}) : super(key: key);

  @override
  State<GlassCardMini> createState() => _GlassCardMiniState();
}

class _GlassCardMiniState extends State<GlassCardMini> {
  final oneSec = Duration(milliseconds: 20);
  double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(oneSec, (Timer t) {
      widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : ${_currentSliderValue.round()}}', widget.client);
      print(_currentSliderValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Stack(
            children: [
              Positioned(
                  top: 20,
                  left: 45,
                  child: Container(
                      width: 100,
                      height: 50,
                      child: Text(widget.glassName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                  )
              ),
              Positioned(
                  top: 50,
                  left: 270,
                  child: Container(child: Text('${_currentSliderValue.round().toString()}%',
                      style: TextStyle(
                          fontSize: 30
                      )))),
              Positioned(
                  top: 55,
                  left: 130,
                  width: 350,
                  height: 100,
                  child: glassSlider()
              ),
              Positioned(
                  top: 70,
                  right: 30,
                  width: 80,
                  height: 70,
                  child: glassButton2()),
              Positioned(
                  top: 70,
                  left: 30,
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
                widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 100}', widget.client);
                _currentSliderValue = 100.0;
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

class GroupGlass extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String mqttTopic;
  String groupName;
  GroupGlass({required this.groupName, required this.mqttTopic, required this.mqttClient, required this.client,Key? key}) : super(key: key);

  @override
  State<GroupGlass> createState() => _GroupGlassState();
}

class _GroupGlassState extends State<GroupGlass> {
  final oneSec = Duration(milliseconds: 20);
  double _currentSliderValue = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(oneSec, (Timer t) {
      widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : ${_currentSliderValue.round()}}', widget.client);
      print(_currentSliderValue);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Stack(
            children: [
              Positioned(
                  top: 20,
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
                  left: 270,
                  child: Text('${_currentSliderValue.round().toString()}%',
                    style: TextStyle(
                      fontSize: 30
                    ))),
              Positioned(
                  top: 55,
                  left: 130,
                  width: 350,
                  height: 100,
                  child: glassSlider()
              ),
              Positioned(
                top: 70,
                  right: 30,
                  width: 80,
                  height: 70,
                  child: glassButton2()),
              Positioned(
                top: 70,
                  left: 30,
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
                widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 100}', widget.client);
                _currentSliderValue = 100.0;
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
