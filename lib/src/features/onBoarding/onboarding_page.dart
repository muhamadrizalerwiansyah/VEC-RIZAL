// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/features/onBoarding/component/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            SizedBox(height: 50),
            SizedBox(
              width: size.width,
              height: 300,
              child: Obx(
                () => CarouselSlider(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 1,
                      autoPlayCurve: Curves.bounceIn,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      reverse: false,
                      viewportFraction: 1.0,
                      initialPage: 1,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        // setState(() {
                        //   current = index;
                        // });
                        // print(current);
                        controller.curentSlider.value = index;
                      }),
                  items: controller.corauselData
                      .map(
                        (item) => AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(item["img"]))),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Our Affiliation",
              style: TextStyle(
                color: gray900,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: size.width,
                child: Text(
                  "We Offer a wide range of skincare products from trusted brands that are designed to help you achieve healty. beautiful, and glowing skin.",
                  style: TextStyle(
                      color: grayText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: size.width,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Obx(
                      () => DotsIndicator(
                        dotsCount: controller.corauselData.length,
                        position: controller.curentSlider.value,
                        decorator: DotsDecorator(
                          size: const Size(10.0, 10.0), // Ukuran indikator
                          spacing: const EdgeInsets.all(3.0),
                          activeSize: const Size(
                              10.0, 10.0), // Ukuran indikator saat aktif
                          color: const Color.fromARGB(
                              111, 158, 158, 158), // Warna indikator non-aktif
                          activeColor: primary, // Warna indikator aktif
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => (controller.corauselData.length - 1) ==
                        controller.curentSlider.value
                    ? InkWell(
                        onTap: () {
                          Get.offAllNamed(RouteName.login);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "Selesai",
                            style: TextStyle(
                                color: white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      )
                    : SizedBox(
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Get.offAllNamed(RouteName.login);
                                    },
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                controller.carouselController.nextPage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ))
                          ],
                        ),
                      ),
              ),
            )
          ],
        ));
  }
}
