// ignore_for_file: prefer_const_constructors

import 'package:entrance_test/src/constants/image.dart';
import 'package:entrance_test/src/features/splashScreen/component/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';

class SplashscreenPage extends GetView<SplashscreenController> {
  const SplashscreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.toPage();
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: gradientColorRedWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(logoApp))),
          )
              .animate(delay: const Duration(milliseconds: 500))
              .fade(duration: const Duration(milliseconds: 900))
              .fadeIn(),
          SizedBox(height: 270),
          Text(
            "Ver: 1.0.0",
            style: TextStyle(
              color: gray900,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          )
              .animate(delay: const Duration(milliseconds: 600))
              .fade(duration: const Duration(milliseconds: 900))
              .fadeIn(),
          SizedBox(height: 20),
        ],
      ),
    ));
  }
}
