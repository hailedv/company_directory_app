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

    Get.put(CompanyController());

    return GetMaterialApp(
      title: 'Company Directory',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}