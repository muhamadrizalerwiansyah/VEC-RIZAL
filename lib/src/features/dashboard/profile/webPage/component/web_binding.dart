import 'package:entrance_test/src/features/dashboard/profile/webPage/component/web_controller.dart';
import 'package:get/get.dart';

class WebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebController>(
      () => WebController(),
    );
  }
}
