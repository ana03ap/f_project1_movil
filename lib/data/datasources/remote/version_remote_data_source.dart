import 'dart:convert';
import 'package:f_project_1/domain/datasources/i_version_remote_data_source.dart';
import 'package:http/http.dart' as http;


class VersionRemoteDataSource implements IVersionRemoteDataSource {
  static const String baseUrl = 'https://api-puntog.onrender.com';

  @override
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
