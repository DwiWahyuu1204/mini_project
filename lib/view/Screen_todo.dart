import 'package:flutter/material.dart';
import 'package:mini_project/view/complate_todo_screen.dart';
import 'package:mini_project/view/daftar_tugas_screen.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});

  @override
  State<ScreenTodo> createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DaftarTugasScreen(),
    ComplateTodoScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'My Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Complete Task',
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
