import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import '../../../domain/entities/random_user.dart';
import '../../models/random_user_json_response_model.dart';
import '../../models/random_user_model.dart';

class UserRemoteDatatasource {
  // This method is used to get a random user from the internet
  Future<RandomUser> getUser() async {
    //https://randomuser.me/api/?format=json&results=1

    var request =
        Uri.parse("https://randomuser.me/api").resolveUri(Uri(queryParameters: {
      "format": 'json',
      "results": "1",
    }));

    var response = await http.get(request);
    if (response.statusCode == 200) {
      logInfo("Got code 200");

      var jsonString = response.body;

      UserRemoteModel userRemoteModel =
          RandomUserJsonReponseModel.fromJson(json.decode(jsonString))
              .results[0];

      return RandomUserModel.fromRemote(userRemoteModel).toEntity();
    }
    logError("Got error code ${response.statusCode}");
    return Future.error("error");
  }
}
