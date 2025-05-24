import 'dart:convert';
import 'package:f_project_1/data/models/event_model.dart';
import 'package:f_project_1/domain/datasources/i_event_remote_data_source.dart';
import 'package:http/http.dart' as http;

class EventRemoteDataSource implements IEventRemoteDataSource {
  static const String baseUrl = 'https://api-puntog.onrender.com';

  @override
  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed');
    }
  }

// @override
// Future<EventModel> subscribeToEvent(String id) async {
//   final response = await http.post(Uri.parse('$baseUrl/subscribe/$id'));

//   if (response.statusCode == 200) {
//     final json = jsonDecode(response.body);
//     return EventModel.fromJson(json['event']);
//   } else {
//     throw Exception('Failed to subscribe to event');
//   }
// }

  @override
  Future<EventModel> subscribeToEvent(String id) async {
    final res = await http.post(Uri.parse('$baseUrl/subscribe/$id'),
      headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      final body = json.decode(res.body) as Map<String,dynamic>;
      return EventModel.fromJson(body['event']);
    }
    throw Exception('Error al suscribir: ${res.statusCode}');
  }

  @override
  Future<EventModel> unsubscribeFromEvent(String id) async {
    final res = await http.post(Uri.parse('$baseUrl/unsubscribe/$id'),
      headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      final body = json.decode(res.body) as Map<String,dynamic>;
      return EventModel.fromJson(body['event']);
    }
    throw Exception('Error al desuscribir: ${res.statusCode}');
  }
  



  @override
  Future<void> sendFeedback(String id, int rating, String comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/feedback/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'rating': rating, 'comment': comment}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit feedback');
    }
  }


  @override
  Future<List<double>> addRating(String eventId, double rating) async {
    final res = await http.post(
      
      Uri.parse('$baseUrl/addrating/$eventId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'rating': rating}),
    );

    if (res.statusCode == 200) {
      final body = json.decode(res.body) as Map<String, dynamic>;
      final List ratingsJson = body['ratings'] as List;
      // convierto la lista dinámica a List<double>
      return ratingsJson.map((e) => (e as num).toDouble()).toList();
    }

    throw Exception('Error al enviar rating: ${res.statusCode}');
  }
  



  @override
  Future<int> fetchEventVersion() async {
    final url = Uri.parse('https://api-puntog.onrender.com/events/version');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['version'] ?? 0;
    } else {
      throw Exception('Error al obtener versión remota');
    }
  }
}
