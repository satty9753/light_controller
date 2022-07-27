import 'package:flutter/material.dart';
import 'package:light_controller/view/input_name_page.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:html';

  void main() {
  var url = "https://www.youtube.com/embed/cAmRG-GWMhM";
  ui.platformViewRegistry.registerViewFactory(
      'hello-world-html',
          (int viewId) => IFrameElement()
        ..width = '640'
        ..height = '360'
        ..src = 'https://www.youtube.com/embed/g2WPxu7EL90'
        ..style.border = 'none');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final mainColor = const Color(0xff0c0d3f);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '工程年會',
      theme: ThemeData(
        primarySwatch: MaterialColor(mainColor.value, getSwatch(mainColor)),
      ),
      home: InputNamePage(),
    );
  }

  Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;
  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

}
