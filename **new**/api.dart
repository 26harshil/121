import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://67c683da351c081993fd9532.mockapi.io/pract';

  // Future<List<Map<String, dynamic>>> getUser() async {
  //   try {
  //     final res = await http.get(Uri.parse(baseUrl));
  //     if (res.statusCode == 200) {
  //       List data = json.decode(res.body);
  //       return List<Map<String, dynamic>>.from(data);
  //     } else {
  //       throw Exception(res.statusCode);
  //     }
  //   } catch (e) {
  //     throw Exception("the Error $e");
  //   }
  // }

  // Future<void> insertdata(name, email) async {
  //   final res = await http.post(
  //       headers: {"Content-type": "application.json"},
  //       body: json.encode({"name": name, "email": email}),
  //       Uri.parse(baseUrl));
  // }

  // Future<void> deletdata(id) async {
  //   final res = await http.delete(Uri.parse('$baseUrl/$id'));
  // }

  // Future<void> updateUser(id, name, email) async {
  //   final res = await http.patch(Uri.parse("$baseUrl/$id"),
  //       headers: {"content-Type": "application/json"},
  //       body: json.encode({"name": name, "email": email}));
  // }
  Future<List<Map<String, dynamic>>> getUser() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List data = json.decode(res.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception("Error : $baseUrl");
    }
  }

  Future<void> deleteUser(String id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
  }

  Future<void> insertdata(name, email) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      body: json.encode({"name": name, "email": email}),
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<void> updateUser(id, name, email) async {
    final res = await http.put(Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"name": name, "email": email}));
  }
}
