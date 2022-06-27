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
        ),
        body: 
        Column(children: [
          const Image(image: AssetImage('2.0x/kv-techCon.png')),
          const Image(image: AssetImage('2.0x/kv-beatol.png')),
          Stack(children: [
           deerImageView(),
           Column(children: [
            Container(height: 300.0),
            nameInputWidget(),
           ],)
        ],),
          sendButton()
        ])
        
        );
  }

  Container deerImageView() {
    return Container(
      alignment: Alignment.center,
      child: const Image(image: AssetImage('2.0x/kv-deer.png'),
      fit: BoxFit.fill),
    );
  }


  Widget nameInputWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 250.0,
        child: buildForm(),
        color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child:
              TextFormField(
                  style: const TextStyle(fontSize: 40.0),
                  controller: nameFormController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: '請輸入你的暱稱',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '欄位不可空白';
                    }
                    return null;
                  }),
        ));
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
          if (_formKey.currentState!.validate()) {
            // Process data.
              setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainPage();
        }));
      });
          }
        },
        child: const Text('送出暱稱'),
      ),
    );
  }
}
