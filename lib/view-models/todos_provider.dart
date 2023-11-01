import 'package:flutter/material.dart';
import '../models/api/todo_api.dart';
import '../models/todo-models/todo.dart';
import 'dart:async';

class TodoProvider extends ChangeNotifier {
  final TodoApi _todoApi = TodoApi();
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  DateTime _deadline = DateTime.now();
  DateTime get deadline => _deadline;
  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;
  final TextEditingController _deskripsiController = TextEditingController();
  TextEditingController get deskripsiController => _deskripsiController;
  final TextEditingController _newtitleController = TextEditingController();
  TextEditingController get newtitleController => _newtitleController;
  final TextEditingController _newdeskripsiController = TextEditingController();
  TextEditingController get newdeskripsiController => _newdeskripsiController;
  bool isCompleted = false;

  void setDeadline(DateTime newDate) {
    _deadline = newDate;
    notifyListeners();
  }

  Future<void> loadTodos() async {
    try {
      List<Map<String, dynamic>> todoData = await _todoApi.getTodos();
      _todos = todoData.map((todo) => Todo.fromJson(todo)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading todos: $e');
    }
    notifyListeners();
  }

  Future<void> loadTodoDetails(String id) async {
    try {
      Map<String, dynamic> todoData = await _todoApi.getTodoById(id);
      Todo todo = Todo.fromJson(todoData);

      print('Todo details loaded: $todo');
    } catch (e) {
      print('Error loading todo details: $e');
    }
  }

  Future<void> createNewTodo(bool isCompleted) async {
    try {
      await _todoApi.createTodo(
          _titleController.text, _deskripsiController.text, isCompleted);
      await loadTodos();
    } catch (e) {
      print('Error creating todo: $e');
    }
  }

  Future<void> editTodo(
      String id, String newTitle, String newDescription, bool complate) async {
    try {
      await _todoApi.editTodo(id, newTitle, newDescription, complate);
      await loadTodos();
    } catch (e) {
      print('Error editing todo: $e');
    }
  }

  Future<void> deleteTodoById(String id) async {
    try {
      await _todoApi.deleteTodo(id);
      await loadTodos();
    } catch (e) {
      print('Error deleting todo: $e');
    }
  }
}
