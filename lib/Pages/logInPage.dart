import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'dart:async';

import 'package:mqttsever2/Pages/firstPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextField(

        ),
      ),
    );
  }
}
