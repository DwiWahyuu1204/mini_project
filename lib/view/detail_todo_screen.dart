import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/theme/myfont_style.dart';

import 'package:provider/provider.dart';

import '../models/todo-models/todo.dart';
import '../view-models/todos_provider.dart';

class DetailTodoScreen extends StatefulWidget {
  final Todo todoLokal;
  const DetailTodoScreen({super.key, required this.todoLokal});

  @override
  State<DetailTodoScreen> createState() => _DetailTodoScreenState();
}

class _DetailTodoScreenState extends State<DetailTodoScreen> {
  @override
  Widget build(BuildContext context) {
    var todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.todoLokal.title,
                                      style: MyFonstStyle().fontHeader,
                                    ),
                                    Text(
                                      'Deadline Tugas: ${DateFormat('dd-MM-yyyy').format(todoProvider.deadline)}',
                                      style: MyFonstStyle().fontHeader,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Divider(),
                            Text(
                              'Deskripsi Tugas',
                              style: MyFonstStyle().fontDeskripsi,
                            ),
                            const Divider(),
                            Text(
                              widget.todoLokal.description,
                              style: MyFonstStyle().fontDeskripsi,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await todoProvider.editTodo(
                      widget.todoLokal.id,
                      widget.todoLokal.title,
                      widget.todoLokal.description,
                      true);

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('berhasil ditandai sebagai selesai!'),
                    ),
                  );
                  Navigator.pop(context);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Gagal menandai todo sebagai selesai: $error'),
                    ),
                  );
                }
              },
              child: const Text('Tandai Selesai'),
            ),
          ],
        ),
      ),
    );
  }
}
