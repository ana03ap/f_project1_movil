import '../../domain/entities/random_user.dart';
import 'random_user_json_response_model.dart';

class RandomUserModel {
  RandomUserModel({
    this.id,
    required this.gender,
    required this.name,
    required this.email,
    required this.picture,
    required this.city,
  });

  final int? id;
  String name;
  final String gender;
  final String email;
  final String picture;
  String city;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'email': email,
      'picture': picture,
      'city': city
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $gender, email: $email, picture : $picture, city: $city}';
  }

  factory RandomUserModel.fromRemote(UserRemoteModel remoteModel) =>
      RandomUserModel(
        gender: remoteModel.gender,
        name: remoteModel.name.first + " " + remoteModel.name.last,
        city: remoteModel.location.city,
        email: remoteModel.email,
        picture: remoteModel.picture.thumbnail,
      );

  RandomUser toEntity() => RandomUser(
        id: id,
        name: name,
        gender: gender,
        email: email,
        picture: picture,
        city: city,
      );
}
