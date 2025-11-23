import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'presentation/bindings/app_binding.dart';
import 'presentation/route/app_pages.dart';
import 'presentation/route/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,

      initialBinding: AppBinding(),

      // Routing
      initialRoute: Routes.home,
      getPages: AppPages.pages,

      debugShowCheckedModeBanner: false,
    );
  }
}
