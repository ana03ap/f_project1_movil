import '../entities/random_user.dart';
import '../repositories/iuserrepository.dart';

class UserUseCase {
  IUserRepository repository;

  UserUseCase(this.repository);

  // TODO: implement use case methods calling the repository
  Future<void> addUser() async => Future.value();
  Future<List<RandomUser>> getAllUsers() async => Future.value([]);
  Future<void> deleteUser(id) async => Future.value();
  Future<void> deleteAll() async => Future.value();
  Future<void> updateUser(user) async => Future.value();
}
