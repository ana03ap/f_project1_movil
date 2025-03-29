import '../../domain/repositories/iuserrepository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../../domain/entities/random_user.dart';

class UserRepository implements IUserRepository {
  late UserRemoteDatatasource remoteDataSource;
  late UserLocalDataSource localDataSource;

  UserRepository(this.remoteDataSource, this.localDataSource);

  @override
  Future<void> addUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List<RandomUser>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
