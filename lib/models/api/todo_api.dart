import 'package:dio/dio.dart';

class TodoApi {
  late Dio _dio;

  TodoApi() {
    _dio = Dio();
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      Response response = await _dio.get('https://api.nstack.in/v1/todos');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['items'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Gagal Load Data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getTodoById(String id) async {
    try {
      Response response = await _dio.get('https://api.nstack.in/v1/todos/$id');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return data;
      } else {
        throw Exception('Gagal Load data details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createTodo(
      String title, String description, bool isCompleted) async {
    try {
      Response response = await _dio.post(
        'https://api.nstack.in/v1/todos',
        data: {
          "title": title,
          "description": description,
          'is_completed': isCompleted
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 201) {
        throw Exception('Gagal membuat todo');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> editTodo(String id, String newTitle, String newDescription,
      bool isCompleted) async {
    try {
      Response response = await _dio.put(
        'https://api.nstack.in/v1/todos/$id',
        data: {
          "title": newTitle,
          "description": newDescription,
          'is_completed': isCompleted
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal edit Todo');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      Response response = await _dio.delete(
        'https://api.nstack.in/v1/todos/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal Menghapus Todo');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
