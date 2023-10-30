import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo-models/todo.dart';
import '../view-models/todos_provider.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  const EditTodoScreen({super.key, required this.todo});

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  @override
  void initState() {
    super.initState();
    // Set nilai awal pada TextEditingController saat initState
    var todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.newtitleController.text = widget.todo.title;
    todoProvider.newdeskripsiController.text = widget.todo.description;
  }

  void showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berhasil Edit Todo'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var todoProvider = Provider.of<TodoProvider>(context);
    void initState() {
      super.initState();
      // Set nilai awal pada TextEditingController saat initState
      todoProvider.newtitleController.text = widget.todo.title;
      todoProvider.newdeskripsiController.text = widget.todo.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: todoProvider.newtitleController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 7,
            ),
            TextField(
                controller: todoProvider.newdeskripsiController,
                decoration:
                    const InputDecoration(border: OutlineInputBorder())),
            const SizedBox(
              height: 7,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Mengubah todo
                  await todoProvider.editTodo(
                    widget.todo.id,
                    todoProvider.newtitleController.text,
                    todoProvider.newdeskripsiController.text,
                    false,
                  );

                  // ignore: use_build_context_synchronously
                  showSuccessSnackBar(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal mengubah todo: $error'),
                    ),
                  );
                }
              },
              child: Text("Edit"),
            )
          ],
        ),
      ),
    );
  }
}
