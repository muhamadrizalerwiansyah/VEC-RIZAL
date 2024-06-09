import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../constants/color.dart';
import '../../../constants/icon.dart';
import '../../../constants/image.dart';
import '../../../widgets/button_icon.dart';
import 'component/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 0), () {
            controller.loadUserFromServer();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.onEditProfileClick();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => ClipOval(
                                child: CachedNetworkImage(
                                  width: 48,
                                  height: 48,
                                  imageUrl: controller.profilePictureUrl,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    width: 48,
                                    height: 48,
                                    defaultProfileImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    controller.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: gray900,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                              const SizedBox(height: 4),
                              Obx(() => Text(
                                    controller.phone,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: gray500,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ],
                          )),
                          Image.asset(
                            ic_arrow_right,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 4, color: gray100, height: 4),
              Column(
                children: [
                  iconTileProfile(ic_test_unauthenticated, "Test 401", () {
                    controller.onTestUnauthenticatedClick();
                  }),
                  iconTileProfile(ic_download, "Download File", () {
                    controller.onDownloadFileClick(
                        "https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf");
                  }),
                  iconTileProfile(ic_webpage, "Open Webpage", () {
                    controller.onOpenWebPageClick(
                        "https://www.youtube.com/watch?v=lpnKWK-KEYs");
                  }),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: signOutButton(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconTileProfile(String iconSource, String text, Function onClick) =>
      InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconSource,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    color: gray900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Image.asset(
                ic_arrow_right,
                height: 20,
                width: 20,
              ),
            ],
          ),
        ),
      );

  Widget signOutButton(BuildContext context) => SizedBox(
        height: 52,
        width: double.infinity,
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ButtonIcon(
            buttonColor: red50,
            textColor: red600,
            textLabel: "Sign Out",
            onClick: () {
              Get.bottomSheet(
                Container(
                  height: 420,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18))),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Confirmation",
                              style: TextStyle(
                                color: gray900,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.close,
                                size: 24,
                                color: gray900,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 300,
                          height: 200,
                          child: SvgPicture.asset(
                            svg_confirmation,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Are you sure\nyou want to log out of your account?",
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: gray900),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: PrimaryButton(
                                  title: "Cancel",
                                  isDisabled: true,
                                  textColor: white,
                                  onClick: () {
                                    Get.back();
                                  },
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: PrimaryButton(
                                  title: "Sign Out",
                                  isDisabled: false,
                                  onClick: () {
                                    controller.doLogout();
                                  },
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
}
