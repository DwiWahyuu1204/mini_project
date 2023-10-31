import 'package:flutter/material.dart';
import 'package:mini_project/view-models/todos_provider.dart';
import 'package:mini_project/view/screen_todo.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Provider.of<TodoProvider>(context, listen: false).loadTodos().then((_) {
        // Navigasi ke halaman home screen saat pengambilan data selesai.
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ScreenTodo()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/splashscreen.jpg'),
        fit: BoxFit.cover,
      ),
    )));
  }
}
