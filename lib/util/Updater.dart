import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyalcf/dio/launcher/update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Updater {
  static void startUp() async {
    print('Checking update...');
    final packageInfo = PackageInfo.fromPlatform();
    packageInfo.then((pak_inf) {
      final result = LauncherUpdateDio().getUpdate();
      result.then((u_if) {
        print('${u_if?.version} | v${pak_inf.version}');
        if ('v${pak_inf.version}' != u_if?.version) {
          print('New version: ${u_if?.version}');
          Get.dialog(AlertDialog(
            icon: Icon(Icons.update),
            title: Text('好耶！是新版本！'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('当前版本：v${pak_inf.version}'),
                Text('新版本：${u_if?.version}'),
                Text('是否打开下载界面喵？'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    '取消',
                  ),
                  onPressed: () async {
                    Get.close(0);
                  }),
              TextButton(
                child: Text(
                  '确定',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  const url = 'https://nyalcf.1l1.icu/download';
                  if (!await launchUrl(Uri.parse(url))) {
                    Get.snackbar(
                      '发生错误',
                      '无法打开网页，请检查设备是否存在WebView',
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: Duration(milliseconds: 300),
                    );
                  }
                },
              ),
            ],
          ));
        } else {
          print('You are running latest version.');
          Future.delayed(Duration(hours: 1), () {
            startUp();
          });
        }
      });
    });
  }
}