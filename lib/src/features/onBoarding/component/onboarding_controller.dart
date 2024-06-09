// ignore_for_file: unnecessary_null_comparison
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/image.dart';

class OnboardingController extends GetxController {
  final carouselController = CarouselController();

  final curentSlider = 0.obs;

  final List<dynamic> corauselData = [
    {
      'img': product,
      'title': "Our Affiliation",
      'desc':
          "We Offer a wide range of skincare products from trusted brands that are designed to help you achieve healty. beautiful, and glowing skin.",
    },
    {
      'img': product,
      'title': "Our Affiliation",
      'desc':
          "We Offer a wide range of skincare products from trusted brands that are designed to help you achieve healty. beautiful, and glowing skin.",
    },
    {
      'img': product,
      'title': "Our Affiliation",
      'desc':
          "We Offer a wide range of skincare products from trusted brands that are designed to help you achieve healty. beautiful, and glowing skin.",
    },
    {
      'img': product,
      'title': "Our Affiliation",
      'desc':
          "We Offer a wide range of skincare products from trusted brands that are designed to help you achieve healty. beautiful, and glowing skin.",
    }
  ].obs;
}
