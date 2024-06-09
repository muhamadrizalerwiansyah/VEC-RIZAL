import 'dart:async';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/endpoint.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;
  final dio = d.Dio();

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();
  RxBool isObscure = true.obs;
  RxBool statusPhone = true.obs;
  RxBool statusPassword = true.obs;
  RxBool statusSubmit = false.obs;
  final notePhone = "".obs;
  final notePassword = "".obs;
  final country = "62".obs;

  void doLogin() async {
    statusSubmit.value = true;
    if (!isValidForm()) {
      Timer(const Duration(milliseconds: 100), () async {
        statusSubmit.value = false;
      });
      return;
    }
    try {
      final response = await dio.post("${Endpoint.baseUrl}/sign-in", data: {
        "phone_number": etPhone.text,
        "password": etPassword.text,
        "country_code": country.value,
      });
      if (response.statusCode == 200) {
        await _userRepository.login(response.data["data"]["token"]);
        Get.offAllNamed(RouteName.dashboard);
      }
      Timer(const Duration(milliseconds: 100), () async {
        statusSubmit.value = false;
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        SnackbarWidget.showFailedSnackbar(e.response?.data["message"]);
      } else {
        SnackbarWidget.showFailedSnackbar("Terjadi kesalahan");
      }
      Timer(const Duration(milliseconds: 100), () async {
        statusSubmit.value = false;
      });
    } catch (e) {
      SnackbarWidget.showFailedSnackbar("Terjadi kesalahan");
      Timer(const Duration(milliseconds: 100), () async {
        statusSubmit.value = false;
      });
    }
  }

  void validatePhone() {}

  bool isValidForm() {
    if (etPhone.text.isEmpty && etPassword.text.isEmpty) {
      notePhone.value = "Number phone must be entered";
      notePassword.value = "Password must be entered";
      statusPassword.value = false;
      statusPhone.value = false;
      return false;
    }
    if (etPhone.text.isEmpty ||
        etPhone.text.length <= 8 ||
        etPhone.text.length > 16) {
      if (etPhone.text.isEmpty) {
        notePhone.value = "Number phone must be entered";
      } else if (etPhone.text.length <= 8) {
        notePhone.value = "Mobile phone number less than 8 digits";
      } else if (etPhone.text.length > 16) {
        notePhone.value = "Mobile phone number more than 8 digits";
      }
      statusPhone.value = false;
      return false;
    } else {
      statusPhone.value = true;
    }
    if (etPassword.text.isEmpty || etPassword.text.length < 8) {
      if (etPassword.text.isEmpty) {
        notePassword.value = "Password must be entered";
      } else if (etPassword.text.length < 8) {
        notePassword.value = "Password less than 8 digits";
      }
      statusPassword.value = false;
      return false;
    } else {
      statusPassword.value = true;
    }

    statusPassword.value = true;
    statusPhone.value = true;

    return true;
  }
}
