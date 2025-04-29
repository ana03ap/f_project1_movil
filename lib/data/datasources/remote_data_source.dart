import 'package:f_project_1/data/models/event_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteDataSource {
  static const String baseUrl = 'https://api-puntog.onrender.com';

  // Obtener lista de eventos
  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  // Suscribirse a un evento
  Future<void> subscribeToEvent(int id) async {
    final response = await http.post(Uri.parse('$baseUrl/subscribe/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to subscribe to event');
    }
  }

  // Enviar feedback anónimo
  Future<void> sendFeedback(int id, int rating, String comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/feedback/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'rating': rating,
        'comment': comment,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit feedback');
    }
  }
}
