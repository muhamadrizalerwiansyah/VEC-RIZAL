// ignore_for_file: prefer_const_constructors

import 'package:entrance_test/src/features/dashboard/profile/webPage/component/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebPage extends GetView<WebController> {
  WebPage({Key? key}) : super(key: key);
  final url = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // controller.toPage();
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: InAppWebView(
        key: controller.webViewKey,
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
        initialOptions: controller.options,
        pullToRefreshController: controller.pullToRefreshController,
        onWebViewCreated: (ctrl) {
          controller.webViewController = ctrl;
        },
        onLoadStart: (ctrl, url) {
          controller.url = url.toString();
          controller.urlController.text = this.url;
        },
        androidOnPermissionRequest: (ctrl, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
        shouldOverrideUrlLoading: (ctrl, navigationAction) async {
          var uri = navigationAction.request.url!;

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (ctrl, url) async {
          controller.pullToRefreshController.endRefreshing();

          controller.url = url.toString();
          controller.urlController.text = this.url;
        },
        onLoadError: (ctrl, url, code, message) {
          controller.pullToRefreshController.endRefreshing();
        },
        onConsoleMessage: (controller, consoleMessage) {},
      ),
    ));
  }
}
