import 'package:flutter/material.dart';
import 'package:light_controller/view/light_page.dart';

class InputNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: InputNameForm());
  }
}

class InputNameForm extends StatefulWidget {
  const InputNameForm({Key? key}) : super(key: key);

  @override
  State<InputNameForm> createState() => _InputNameFormState();
}

class _InputNameFormState extends State<InputNameForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameFormController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameFormController.dispose();
  }

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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("3.0x/kv-bg.png"),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(child: Column(children: [
            const Image(image: AssetImage('2.0x/kv-techCon.png'), filterQuality: FilterQuality.high),
            const Image(image: AssetImage('2.0x/kv-beatol.png'), filterQuality: FilterQuality.high),
            Stack(
              children: [
                deerImageView(),
                Column(
                  children: [
                    Container(height: 300.0),
                    nameInputWidget(),
                  ],
                )
              ],
            ),
            sendButton()
          ]),)

        ]));
  }

  Container deerImageView() {
    return Container(
      alignment: Alignment.center,
      child:
          const Image(image: AssetImage('2.0x/kv-deer.png',), fit: BoxFit.fill, filterQuality: FilterQuality.high),
    );
  }

  Widget nameInputWidget() {
  return Container(
    constraints: const BoxConstraints(maxWidth: 640.0),
    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(40.0),
    child: Container(
    height: 250.0,
    child: buildForm(),
    color: Colors.white.withOpacity(0.9),
    ),
   ),);
  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: TextFormField(
              style: const TextStyle(fontSize: 40.0),
              controller: nameFormController,
              autocorrect: false,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: '請輸入你的暱稱',
                hintMaxLines: 2,
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '欄位不可空白';
                }
                if (value.length > 10) {
                  return '暱稱不可超過10個字';
                }

                return null;
              }),
        ));
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
          if (_formKey.currentState!.validate()) {
            // Process data.
            setState(() {
              String username = nameFormController.text;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LightSwitchPage(username: username);
              }));
            });
          }
        },
        child: const Text('送出暱稱'),
      ),
    );
  }
}
