import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqttsever2/Widgets/Slider.dart';
import 'package:mqttsever2/Widgets/buttons.dart';
import 'package:mqttsever2/main.dart';
import 'dart:async';
import 'package:mqttsever2/Resources/data.dart';
import 'package:mqttsever2/Widgets/a_singleGlass.dart';
import 'package:mqttsever2/Widgets/allGlass.dart';

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
      height: 810,
      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: GroupGlass(
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(x: 0,
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(x: 1,
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(x: 2,
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                ),
                Container(
                  child: GlassCardMini(x: 3,
                      mqttClient: widget.mqttClient,
                      client: widget.mqttClient!.getClient),
                )
              ],
            ),
    );
  }
}