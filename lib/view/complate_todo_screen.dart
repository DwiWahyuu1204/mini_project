import 'package:flutter/material.dart';
import 'package:mini_project/view/add_todo_screen.dart';

import 'package:provider/provider.dart';

import '../models/todo-models/todo.dart';
import '../view-models/todos_provider.dart';

class ComplateTodoScreen extends StatelessWidget {
  const ComplateTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Task'),
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          List<Todo> uncompletedTodos =
              todoProvider.todos.where((todo) => todo.isCompleted).toList();

          return ListView.builder(
            itemCount: uncompletedTodos.length,
            itemBuilder: (context, index) {
              Todo todo = uncompletedTodos[index];

              return Padding(
                padding: const EdgeInsets.all(7),
                child: ListTile(
                  shape: Border.all(color: Colors.black26),
                  title: Text(todo.title),
                  subtitle: Text(todo.description,
                      overflow: TextOverflow.ellipsis, maxLines: 2),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Tugas Telah Selesai Dikerjakan'),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Apakah Anda yakin ingin menghapus todo ini?'),
                              action: SnackBarAction(
                                label: 'Hapus',
                                onPressed: () {
                                  todoProvider.deleteTodoById(todo.id);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Todo berhasil dihapus.'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.delete_sharp),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddTodo(), // Ganti dengan nama halaman detail tugas yang sesuai.
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
