import 'package:flutter/material.dart';
import 'package:get/get.dart';
import ' controllers/company_controller.dart';
import 'screens/home_screen.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => LocalStorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyController());

    return Obx(() => GetMaterialApp(
          title: 'Company Directory',
          themeMode:
              controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
