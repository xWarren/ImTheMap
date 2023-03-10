import 'package:flutter/material.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/controller/navigator.dart';
import 'package:lottie/lottie.dart';
class Process extends StatefulWidget {
  const Process({Key? key}) : super(key: key);

  @override
  State<Process> createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainPages())));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
        Lottie.asset('assets/85340-processing-loader.json'),
    )
    );
  }
}
