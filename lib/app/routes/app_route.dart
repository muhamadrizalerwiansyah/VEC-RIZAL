import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_binding.dart';
import 'package:entrance_test/src/features/dashboard/dashboard_page.dart';
import 'package:entrance_test/src/features/dashboard/profile/edit/edit_profile_page.dart';
import 'package:entrance_test/src/features/dashboard/profile/webPage/component/web_binding.dart';
import 'package:entrance_test/src/features/dashboard/profile/webPage/web_page.dart';
import 'package:entrance_test/src/features/splashScreen/component/splashscreen_binding.dart';
import 'package:entrance_test/src/features/splashScreen/splashscreen_page.dart';
import 'package:get/get.dart';

import '../../src/features/dashboard/profile/edit/component/edit_profile_binding.dart';
import '../../src/features/login/component/login_binding.dart';
import '../../src/features/login/login_page.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.splashscreen,
      page: () => const SplashscreenPage(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RouteName.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: RouteName.webPage,
      page: () => WebPage(),
      binding: WebBinding(),
    ),
  ];
}
