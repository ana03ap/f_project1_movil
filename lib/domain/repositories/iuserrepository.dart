import '../entities/random_user.dart';

abstract class IUserRepository {
  Future<void> addUser();
  Future<List<RandomUser>> getAllUsers();
  Future<void> deleteUser(id);
  Future<void> deleteAll();
  Future<void> updateUser(user);
}
