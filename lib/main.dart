import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logiks_crud/views/home_page.dart';


void main(){
  runApp(MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 7, 75, 132)),
      ),
      title: "Logiks CRUD",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}