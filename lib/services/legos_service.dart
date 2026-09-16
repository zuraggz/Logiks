import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logiks_crud/models/lego.dart';

class LegosService {
  static const String _baseUrl = "https://api.restful-api.dev/collections/legos/objects";
  static const Map<String, String> _apiKeyHeader = {
    'x-api-key': '5735a599-dc02-441c-8688-b6afbcdf2fff',
  };

  static Future<List<Lego>?> fetchAll() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(uri, headers: _apiKeyHeader);

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.map((json) => Lego.fromJson(json as Map)).toList();
    }
    return null;
  }

  static Future<bool> create(Lego lego) async {
    final uri = Uri.parse(_baseUrl);
    final headers = {
      'Content-Type': 'application/json',
      ..._apiKeyHeader,
    };
    try {
      final response = await http.post(uri, body: jsonEncode(lego.toJson()), headers: headers);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> updateById(String id, Lego lego) async {
    final uri = Uri.parse("$_baseUrl/$id");
    final headers = {
      'Content-Type': 'application/json',
      ..._apiKeyHeader,
    };
    try {
      final response = await http.put(uri, body: jsonEncode(lego.toJson()), headers: headers);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> deleteById(String id) async {
    final uri = Uri.parse("$_baseUrl/$id");
    try {
      final response = await http.delete(uri, headers: _apiKeyHeader);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
