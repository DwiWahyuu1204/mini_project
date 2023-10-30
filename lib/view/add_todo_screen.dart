import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mini_project/theme/myfont_style.dart';
import 'package:provider/provider.dart';

import '../models/todo-models/todo_lokal.dart';
import '../view-models/todos_lokal_provider.dart';
import '../view-models/todos_provider.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    super.key,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    var todoProvider = Provider.of<TodoProvider>(context, listen: false);
    var todoLokalprovider =
        Provider.of<TodoLokalProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Silahkan Masukan Tugas Anda!!!',
            style: MyFonstStyle().fontHeader,
          ),
          Text(
            'Tetap Semangatt!!',
            style: MyFonstStyle().fontHeader,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(7),
            child: Column(children: [
              TextField(
                controller: todoProvider.titleController,
                decoration: const InputDecoration(
                    label: Text("Masukan Judul Tugas Anda"),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                maxLines: 4,
                controller: todoProvider.deskripsiController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Masukan Deskripsi Tugas')),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Masukan Deadline'),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: todoProvider.deadline,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null &&
                          pickedDate != todoProvider.deadline) {
                        todoProvider.setDeadline(pickedDate);
                      }
                      setState(() {});
                      print(todoProvider.deadline);
                    },
                    child: const Text('Pilih Tanggal Deadline'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Deadline Yang Dipilih '),
                  Text(DateFormat('dd-MM-yyyy').format(todoProvider.deadline)),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await todoProvider.createNewTodo(false);

                    String title = todoProvider.titleController.text;
                    String description = todoProvider.deskripsiController.text;
                    DateTime deadline = todoProvider.deadline;
                    todoLokalprovider.insertTodo(TodoLokal(
                        id: 'ID_Todo',
                        title: title,
                        description: description,
                        deadline: deadline));
                    todoProvider.titleController.clear();
                    todoProvider.deskripsiController.clear();

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Todo berhasil dibuat!'),
                      ),
                    );

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (error) {
                    // Jika gagal, tampilkan Snackbar gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal membuat todo: $error'),
                      ),
                    );
                  }
                },
                child: Text('Tambah Todo'),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
