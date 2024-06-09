// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class SplashscreenController extends GetxController {
  final UserRepository _userRepository;

  SplashscreenController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  void toPage() async {
    try {
      var data = await _userRepository.getUser();
      Timer(const Duration(seconds: 3), () async {
        if (data.status == 0) {
          Get.offAllNamed(RouteName.dashboard);
        } else {
          Get.offNamed(RouteName.onboarding);
        }
      });
    } catch (e) {
      Timer(const Duration(seconds: 3), () async {
        Get.offNamed(RouteName.onboarding);
      });
    }
  }
}
