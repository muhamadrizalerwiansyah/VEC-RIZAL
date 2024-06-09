// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/endpoint.dart';
import 'package:entrance_test/src/features/dashboard/profile/component/profile_controller.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/date_util.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';
import 'package:dio/dio.dart' as d;

class EditProfileController extends GetxController {
  final dio = d.Dio();
  d.Dio dioClient = d.Dio();

  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final profileController = Get.find<ProfileController>();

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  DateTime birthDate = DateTime.now();

  final noteFullName = "".obs;
  final noteEmail = "".obs;
  RxBool statusFullname = true.obs;
  RxBool statusEmail = true.obs;
  Rx<File?> imageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode;

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate =
              DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      error.printError();
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  void changeImage(context, int value) async {
    //TODO: Implement change profile image
    try {
      if (value == 0) {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) return;
        final imageTemporary = File(image.path);

        imageFile.value = imageTemporary;
        update();
        Get.back();
      } else {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageTemporary = File(image.path);
        imageFile.value = imageTemporary;
        update();
        Get.back();
      }
    } on PlatformException {
      Get.back();
    }
  }

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
  }

  void saveData() async {
    //TODO: Implement edit user API
    if (!isValidForm()) {
      return;
    }
    try {
      await EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.custom,
      );
      final token = await _userRepository.getToken();
      d.MultipartFile? img;
      if (imageFile.value != null) {
        img = await d.MultipartFile.fromFile(
          imageFile.value!.path,
          filename: imageFile.value!.path.split('/').last,
        );
      }
      var data = d.FormData.fromMap({
        "name": etFullName.text,
        "email": etEmail.text,
        "gender": _gender.value,
        "date_of_birth": DateFormat('yyyy-MM-dd').format(birthDate),
        "height": etHeight.text,
        "weight": etWeight.text,
        "profile_picture": img,
        "_method": "PUT",
      });
      final response = await dio.post("${Endpoint.baseUrl}/user/profile",
          data: data,
          options: Options(headers: {'Authorization': 'Bearer ${token}'}));

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Success!");
        profileController.loadUserFromServer();
        Get.back();
      } else {
        EasyLoading.showInfo("Failed!");
      }
    } catch (e) {
      EasyLoading.showError("Error!");
    }
  }

  bool isValidForm() {
    if (etFullName.text.isEmpty) {
      noteFullName.value = "Name must be entered";
      statusFullname.value = false;
      return false;
    } else {
      statusFullname.value = true;
    }
    if (etEmail.text.isEmpty) {
      noteEmail.value = "Email must be entered";
      statusEmail.value = false;
      return false;
    } else {
      String pattern =
          r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})+$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(etEmail.text)) {
        noteEmail.value = "Enter a valid email";
        statusEmail.value = false;
        return false;
      } else {
        statusEmail.value = true;
      }
    }
    return true;
  }
}
