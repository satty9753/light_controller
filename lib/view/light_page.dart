import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LightSwitchPage());
  }
}

class LightSwitchPage extends StatefulWidget {
  const LightSwitchPage({Key? key}) : super(key: key);
  @override
  State<LightSwitchPage> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitchPage> {
  bool isLightOn = false;
  var records = <String>["faketext"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(16.0),
          child:           
          Align(
            child: Text("hi 你好嗎", style: TextStyle(fontSize: 30)),
            alignment: Alignment.centerLeft,)),
          Image.asset(isLightOn
              ? 'assets/2.0x/light-on.png'
              : 'assets/2.0x/light-off.png'),
          sendButton(),
          const SizedBox(height: 30.0),
          recordList()
        ],
      ),
    );
  }

  Widget recordList() {
    return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            height: 250.0,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: recordListView(),
            ),
            color: Colors.white.withOpacity(0.9),
          ),
        ));
  }

  ListView recordListView() {
    return ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return Text(records[index]);
        });
  }

  Container sendButton() {
    return Container(
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
        onPressed: () {
          setState(() {
            isLightOn = !isLightOn;
          });
        },
        child: isLightOn ? const Text('我要關燈') : const Text('我要開燈'),
      ),
    );
  }
}
