import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqttsever2/Pages/firstPage.dart';

class IpStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readIP() async {
    try {
      final file = await _localFile;

      // 파일 읽기
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // 에러가 발생할 경우 error을 반환
      return 'error';
    }
  }

  Future<File> writeIP(String Ip) async {
    final file = await _localFile;

    // 파일 쓰기
    return file.writeAsString(Ip);
  }
}
class LoginPage extends StatefulWidget {
  final IpStorage storage;
  LoginPage({required this.storage, Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  late MqttClient mqttClient;

  MqttServerClient? client = null;

  int delayMiliseconds = 100;

  @override
  void initState() {
    super.initState();
    widget.storage.readIP().then((String _iip) {
      setState(() {
        ipController.text = _iip;
      });
    });

    ipController = TextEditingController();
  }


  Future<void> setClient() async{
    while(client == null) {
      client = await mqttClient.getMqttClient();
      await Future.delayed((Duration(milliseconds: delayMiliseconds)));
      delayMiliseconds = delayMiliseconds * 2;
      print('$client  $delayMiliseconds');

    }
  }



  TextEditingController ipController = TextEditingController();

  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                            scale: 10,
                            image: AssetImage('assets/images/Glatic_logo.png'))
                    ),
                  ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  color: Colors.grey[300],
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: TextField(
                    controller: ipController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Raspberry wifiIP',
                    ),
                    onSubmitted: (String iip) async {
                      widget.storage.writeIP(iip);
                      mqttClient = MqttClient(ipController.text);
                      await setClient();
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => FirstPage(mqttClient: mqttClient)));
                    },
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                  flex: 2,
                  child: Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ))
            ],
          )),
    );
  }
}
