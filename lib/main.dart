import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sisfo_pgt/screen/content/Home/content/dataNilai/nilaiAk.dart';
import 'package:sisfo_pgt/screen/content/auth/loginpage.dart';
import 'package:sisfo_pgt/screen/route/routing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoute().route,
      builder: EasyLoading.init(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginMHS(),
//     );
//   }
// }
