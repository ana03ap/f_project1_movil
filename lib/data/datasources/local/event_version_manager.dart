import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventVersionManager {
  static const String _versionKey = 'events_version';
  static const String baseUrl = 'https://api-puntog.onrender.com';

  // Obtener versión guardada localmente
  Future<int> getLocalVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_versionKey) ?? 0;
  }

  // Guardar versión nueva localmente
  Future<void> setLocalVersion(int version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_versionKey, version);
  }

  // Obtener versión actual desde la API
  Future<int> fetchRemoteVersion() async {
    final response = await http.get(Uri.parse('$baseUrl/events/version'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['version'];
    } else {
      throw Exception('Failed to fetch remote version');
    }
  }
}
