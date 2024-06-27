import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroServices {
  static Future<bool> delete(String id) async {
    final url = 'http://localhost:3000/deletRegistro/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> getRegistros() async {
    const url = 'http://localhost:3000/registro';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> updateRegistro(String id, Map body) async {
    final url = 'http://localhost:3000/updateRegistro/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  static Future<bool> addRegistro(Map body) async {
    const url = 'http://localhost:3000/addRegistro/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }
}
