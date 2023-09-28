import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchData {
  String baseUrl='https://chicwardrobe-znz5.onrender.com/';
  Future<Map<String,dynamic>> getData({required String endpoint}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
      );

      var data = jsonDecode(response.body);
      print(data);
    } catch (e) {
      print('Error fetching data: $e');
    }
    return {};
  }
}
