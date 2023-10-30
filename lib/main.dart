import 'package:flutter/material.dart';
import 'package:mini_project/view-models/todos_provider.dart';
import 'package:mini_project/view/splashscreen.dart';
import 'package:provider/provider.dart';

import 'view-models/todos_lokal_provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TodoProvider>(create: (context) => TodoProvider()),
      ChangeNotifierProvider<TodoLokalProvider>(
          create: (context) => TodoLokalProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
