import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

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

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick(String url) async {
    Dio dio = Dio();
    try {
      await EasyLoading.show(
        status: 'Mengunduh...',
        maskType: EasyLoadingMaskType.custom,
      );
      String fileName = url.split('/').last;

      Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
      if (downloadsDirectory != null) {
        final savePath = "${downloadsDirectory.path}/$fileName";
        var proccess = await downloadFile(url, savePath);
        if (proccess) {
          EasyLoading.showSuccess("Berhasil");
        } else {
          EasyLoading.showError("Gagal");
        }
      } else {
        EasyLoading.showInfo("Gagal mengakses direktori unduhan.");
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  Future<bool> downloadFile(String url, String savePath) async {
    Dio dio = Dio();

    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("Progress: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  onOpenWebPageClick(String url) {
    Get.toNamed(RouteName.webPage, arguments: url);
  }

  void doLogout() async {
    await _userRepository.logout();
    Get.offAllNamed(RouteName.login);
  }
}
