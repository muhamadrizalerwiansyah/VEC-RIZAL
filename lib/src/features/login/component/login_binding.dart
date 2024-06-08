import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(LoginController(
      userRepository: Get.find<UserRepository>(),
    ));
  }
}