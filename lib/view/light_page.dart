import 'package:flutter/material.dart';
import 'package:light_controller/api/socket_manager.dart';

class LightSwitchPage extends StatefulWidget {
  final String username;
  const LightSwitchPage({Key? key, required this.username}) : super(key: key);
  @override
  State<LightSwitchPage> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitchPage> {
  bool isLightOn = false;
  bool isButtonEnabled = false;
  ScrollController scrollController = ScrollController();
  var records = <String>[""];
  @override
  void initState() {
    super.initState();
    SocketManager().tryConnect(widget.username, onConnect, errorHandler,
        onRecord, onDisconnect, onConnecting);
    Future.delayed(const Duration(milliseconds: 0), () {
      if(!SocketManager().isOnConnect) {
        isButtonEnabled = false;
        showToast("connecting...");
      } else {
        isButtonEnabled = true;
      }
      
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("3.0x/kv-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  usernameView(widget.username),
                  Image.asset(
                      isLightOn
                          ? '2.0x/light-on.png'
                          : '2.0x/light-off.png',
                      filterQuality: FilterQuality.high),
                  sendButton(),
                  const SizedBox(height: 30.0),
                  recordList()
                ],
              ),
            ))
          ],
        ));
  }

  Widget usernameView(String name) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 640.0),
        padding: const EdgeInsets.all(16.0),
        child: Align(
          child: Text("Hi $name ~",
              style: const TextStyle(fontSize: 30, color: Colors.white)),
          alignment: Alignment.centerLeft,
        ));
  }

  Widget recordList() {
    return Container(
        constraints: const BoxConstraints(maxWidth: 640.0),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            height: 250.0,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
              child: recordListView(),
            ),
            color: Colors.white.withOpacity(0.9),
          ),
        ));
  }

  ListView recordListView() {
    return ListView.builder(
        controller: scrollController,
        itemCount: records.length,
        itemBuilder: (context, index) {
          return Text(
            records[index],
            style: const TextStyle(fontSize: 18.0),
          );
        });
  }

  Container sendButton() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 640.0),
      width: double.infinity,
      height: 80.0,
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff9092ff)),
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 20.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)))),
        onPressed: isButtonEnabled ? onTap : null,
        child: isLightOn ? const Text('我要關燈') : const Text('我要開燈'),
      ),
    );
  }

  void onTap() {
    isLightOn ? SocketManager().turnOffLight() : SocketManager().turnOnLight();
  }

  void onConnect() {
    if (mounted) {
      SocketManager().getLightStatus();
      setState(() {
        isButtonEnabled = true;
        records = [];
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.hideCurrentSnackBar();
        showToast('connected');
        Future.delayed(const Duration(milliseconds: 1000), () {
          scaffold.hideCurrentSnackBar();
        });
      });
    }
  }

  void errorHandler() {
    if (mounted) {
      setState(() {
        isButtonEnabled = false;
        showToast('connecting...');
      });
    }
  }

  void onRecord(message, lightOn) {
    if (message != null) {
      if (message.length > 0) {
        records.add(message);
      }
    }
    isLightOn = lightOn;
    if (mounted) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.hideCurrentSnackBar();
      setState(() {
        if (scrollController.position.maxScrollExtent > 0) {
          Future.delayed(
            const Duration(milliseconds: 200),
            () {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            },
          );
        }
      });
    }
  }

  void onConnecting() {
    if (mounted) {
      setState(() {
        isButtonEnabled = false;
        showToast('connecting...');
      });
    }
  }

  void onDisconnect() {
    isButtonEnabled = false;
    if (mounted) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.hideCurrentSnackBar();
      showToast("disconnected");
    }
  }

  void showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
