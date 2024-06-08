import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/splashScreen/component/splashscreen_controller.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));
    Get.lazyPut<SplashscreenController>(
      () => SplashscreenController(
        userRepository: Get.find<UserRepository>(),
      ),
    );
  }
}
