import 'package:entrance_test/src/features/dashboard/component/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
            index: controller.selectedNavbar, children: controller.listPages),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
              () => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "Products",
                icon: Image.asset(
                  ic_home,
                  height: 24,
                  width: 24,
                ),
                activeIcon: Image.asset(
                  ic_home_active,
                  height: 24,
                  width: 24,
                ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Image.asset(
                  ic_profile,
                  height: 24,
                  width: 24,
                ),
                activeIcon: Image.asset(
                  ic_profile_active,
                  height: 24,
                  width: 24,
                ),
              )
            ],
            currentIndex: controller.selectedNavbar,
            selectedItemColor: primary,
            unselectedItemColor: gray500,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            onTap: (int index) {
              controller.updateSelectedNavbar(index);
            },
          ),
        ),
      ),
    );
  }
}
