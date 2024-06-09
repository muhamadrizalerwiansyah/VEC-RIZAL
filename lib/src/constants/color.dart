import 'package:flutter/material.dart';

const primary = Color(0xff7D26CD);
const shadowColor = Color(0x0D28293D);
const white = Color(0xffFFFFFF);
const gray100 = Color(0xffF0F0F0);
const gray200 = Color(0xffE6E6E6);
const gray500 = Color(0xffBEBEBE);
const gray600 = Color(0xff949494);
const gray900 = Color(0xff2E2E2E);
const red50 = Color(0xffFFF5F5);
const red500 = Color(0xffFF3B3B);
const red600 = Color(0xffE83636);
const green50 = Color(0xffE6F9F1);
const green600 = Color(0xff06C270);
const grayText = Color(0xFF62717D);

const gradientColorRedWhite = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: <Color>[
      Color.fromARGB(255, 216, 255, 246),
      red500,
    ]);

TextStyle boldGreyText =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey);
