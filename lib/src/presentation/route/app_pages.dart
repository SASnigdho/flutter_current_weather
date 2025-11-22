import 'package:get/get.dart';

import '../bindings/home_binding.dart';
import '../pages/home_page.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
