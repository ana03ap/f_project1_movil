import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/random_user.dart';
import '../../domain/use_case/user_use_case.dart';

class UserController extends GetxController {
  final RxList<RandomUser> _users = <RandomUser>[].obs;
  UserController({required this.userUseCase});
  UserUseCase userUseCase;

  List<RandomUser> get users => _users;

  @override
  onInit() {
    super.onInit();
    getAllUsers();
  }

  Future<void> addUser() async {
    logInfo("userController -> add user");
    await userUseCase.addUser();
    await getAllUsers();
  }

  Future<void> getAllUsers() async {
    var list = await userUseCase.getAllUsers();
    logInfo("userController -> getAllUsers got " + list.length.toString());
    _users.value = list;
    _users.refresh();
  }

  Future<void> deleteUser(id) async {
    logInfo("userController -> delete user $id");
    await userUseCase.deleteUser(id);
    await getAllUsers();
  }

  Future<void> deleteAll() async {
    logInfo("userController -> delete all");
    await userUseCase.deleteAll();
    await getAllUsers();
  }

  Future<void> updateUser(user) async {
    logInfo("userController -> updateUser user ${user.id}");
    await userUseCase.updateUser(user);
    await getAllUsers();
  }
}
