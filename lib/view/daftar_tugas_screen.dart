import 'package:flutter/material.dart';
import 'package:mini_project/theme/myfont_style.dart';
import 'package:mini_project/view/add_todo_screen.dart';
import 'package:provider/provider.dart';
import '../models/todo-models/todo.dart';
import '../view-models/todos_provider.dart';
import 'detail_todo_screen.dart';
import 'edit_todo_screen.dart';

class DaftarTugasScreen extends StatelessWidget {
  const DaftarTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var todoLokalprovider =
    //     Provider.of<TodoLokalProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Task', style: MyFonstStyle().fontAppbar),
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          List<Todo> uncompletedTodos =
              todoProvider.todos.where((todo) => !todo.isCompleted).toList();

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
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditTodoScreen(todo: todo),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
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
                        icon: const Icon(Icons.delete_sharp),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailTodoScreen(todoLokal: todo),
                            ),
                          );
                        },
                        child: const Text('Detail Tugas'),
                      )
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
              builder: (context) => const AddTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
