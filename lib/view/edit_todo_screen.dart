import 'package:flutter/material.dart';
import 'package:mini_project/theme/myfont_style.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Judul Tugas',
                  style: MyFonstStyle().fontDeskripsi,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: todoProvider.newtitleController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi Tugas',
                  style: MyFonstStyle().fontDeskripsi,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                    maxLines: 5,
                    controller: todoProvider.newdeskripsiController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder())),
              ],
            ),
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
              child: const Text("Edit Tugas"),
            )
          ],
        ),
      ),
    );
  }
}
