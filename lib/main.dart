import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/config/app_theme.dart';
import 'core/controllers/theme_controller.dart';
import 'features/cart/controllers/cart_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  Get.put(ThemeController());
  Get.put(CartController());

  runApp(const MyApp());

  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Appers Shop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        initialRoute: AppRoutes.shell,
        getPages: AppPages.pages,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(0.9)),
            child: child!,
          );
        },
      ),
    );
  }
}
