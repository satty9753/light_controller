import 'package:flutter/material.dart';

class LightSwitchPage extends StatefulWidget {
  final String username;
  const LightSwitchPage({Key? key, required this.username}) : super(key: key);
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
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/3.0x/kv-bg.png"),
                      fit: BoxFit.cover)),
            ),
            Center(child: Column(
              children: [
                usernameView(widget.username),
                Image.asset(isLightOn
                    ? 'assets/2.0x/light-on.png'
                    : 'assets/2.0x/light-off.png'),
                sendButton(),
                const SizedBox(height: 30.0),
                recordList()
              ],
            ),)

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
        )
        );
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
