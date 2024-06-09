import 'package:entrance_test/src/widgets/empty_list_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Hi, Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Sign in to your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: gray500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Phone Number',
                                style: TextStyle(color: gray900),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: red500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CustomPhoneNumberFormatter(),
                    ],
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: gray900),
                    cursorColor: primary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: gray200, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: gray200, width: 1.5),
                      ),
                      fillColor: white,
                      filled: true,
                      hintText: 'Phone Number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                height: 320,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(18))),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Country",
                                            style: TextStyle(
                                              color: gray900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              height: 1.2,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => Get.back(),
                                            child: const Icon(
                                              Icons.close,
                                              size: 24,
                                              color: gray900,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Obx(
                                      () => ItemSelectDayWidget(
                                          size: size,
                                          label: "Indonesia (+62)",
                                          status:
                                              controller.country.value == "62"
                                                  ? true
                                                  : false,
                                          tap: () async {
                                            controller.country.value = "62";
                                            Get.back();
                                          }),
                                    ),
                                    Container(
                                      width: size.width,
                                      height: 0.5,
                                      color: gray600,
                                    ),
                                    Obx(
                                      () => ItemSelectDayWidget(
                                          size: size,
                                          label: "Malaysia (+60)",
                                          status:
                                              controller.country.value == "60"
                                                  ? true
                                                  : false,
                                          tap: () async {
                                            controller.country.value = "60";
                                            Get.back();
                                          }),
                                    ),
                                    Container(
                                      width: size.width,
                                      height: 0.5,
                                      color: gray600,
                                    ),
                                    Obx(
                                      () => ItemSelectDayWidget(
                                          size: size,
                                          label: "Australia (+61)",
                                          status:
                                              controller.country.value == "61"
                                                  ? true
                                                  : false,
                                          tap: () async {
                                            controller.country.value = "61";
                                            Get.back();
                                          }),
                                    ),
                                    Container(
                                      width: size.width,
                                      height: 0.5,
                                      color: gray600,
                                    ),
                                    Obx(
                                      () => ItemSelectDayWidget(
                                          size: size,
                                          label: "Philipina (+63)",
                                          status:
                                              controller.country.value == "63"
                                                  ? true
                                                  : false,
                                          tap: () async {
                                            controller.country.value = "63";
                                            Get.back();
                                          }),
                                    ),
                                    Container(
                                      width: size.width,
                                      height: 0.5,
                                      color: gray600,
                                    ),
                                    Obx(
                                      () => ItemSelectDayWidget(
                                          size: size,
                                          label: "Singapura (+65)",
                                          status:
                                              controller.country.value == "65"
                                                  ? true
                                                  : false,
                                          tap: () async {
                                            controller.country.value = "65";
                                            Get.back();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 6),
                              Obx(
                                () => Text(
                                  '+${controller.country.value}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: gray900),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const SizedBox(
                                width: 1.5,
                                height: 48,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: gray100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    controller: controller.etPhone,
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => (!controller.statusPhone.value)
                        ? SizedBox(
                            width: size.width,
                            child: Text(
                              controller.notePhone.value,
                              style: const TextStyle(
                                  color: red500,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Password',
                                style: TextStyle(color: gray900),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: red500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      obscureText: controller.isObscure.value,
                      cursorColor: primary,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          right: -14,
                          top: 20,
                          bottom: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObscure.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: gray600,
                            ),
                            onPressed: () {
                              controller.isObscure.value =
                                  !controller.isObscure.value;
                            }),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: ImageIcon(
                            AssetImage(ic_password),
                          ), // icon is 48px widget.
                        ),
                      ),
                      controller: controller.etPassword,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => (!controller.statusPassword.value)
                        ? SizedBox(
                            width: size.width,
                            child: Text(
                              controller.notePassword.value,
                              style: const TextStyle(
                                  color: red500,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              loginButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() => SizedBox(
      height: 52,
      width: double.infinity,
      child: SizedBox(
        height: 52,
        width: double.infinity,
        child: Obx(
          () => ButtonIcon(
            buttonColor: controller.statusSubmit.value ? gray600 : primary,
            textColor: controller.statusSubmit.value ? gray900 : white,
            textLabel: "Sign In",
            onClick: () {
              if ((!controller.statusSubmit.value)) {
                controller.doLogin();
              }
            },
          ),
        ),
      ));
}
