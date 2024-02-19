import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:nyalcf/storages/configurations/launcher_configuration_storage.dart';
import 'package:nyalcf/utils/logger.dart';

class ThemeControl {
  static final lcs = LauncherConfigurationStorage();

  /// 设置主题为自动模式
  static void autoSet() {
    final bool isDarkMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    switchDarkTheme(isDarkMode);
  }

  /// 切换到暗色主题
  static void switchDarkTheme(bool value) {
    if (value) {
      Get.changeTheme(dark);
      Logger.info('切换到暗色主题');
    } else {
      Get.changeTheme(light);
      Logger.info('切换到亮色主题');
    }
  }

  /// 暗色主题设置
  static final dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'HarmonyOS Sans',
    brightness: Brightness.dark,
  );

  /// 亮色主题设置
  static final light = ThemeData(
    useMaterial3: true,
    fontFamily: 'HarmonyOS Sans',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink.shade300,
    ).copyWith(
      primary: Colors.pink.shade400,
      secondary: Colors.pink.shade300,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.pink.shade100,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.pink.shade200,
    ),
  );
  static final custom = ThemeData(
    useMaterial3: true,
    fontFamily: 'HarmonyOS Sans',
    colorSchemeSeed: colorFromHexCode(lcs.getThemeLightSeedValue()),
  );

  static colorFromHexCode(String hex) {
    return Color(
      int.parse(
            hex.substring(0, 6),
            radix: 16,
          ) +
          0xFF000000,
    );
  }
}