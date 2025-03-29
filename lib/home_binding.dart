import 'package:get/get.dart';

import 'core/network_info.dart';
import 'data/datasources/local/user_local_datasource.dart';
import 'data/datasources/remote/user_remote_datasource.dart';
import 'data/repositories/user_repository.dart';
import 'domain/repositories/iuserrepository.dart';
import 'domain/use_case/user_use_case.dart';
import 'ui/controllers/connectivity_controller.dart';
import 'ui/controllers/user_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkInfo());
    Get.put(ConnectivityController());

    Get.put<UserRemoteDatatasource>(UserRemoteDatatasource());
    Get.put<UserLocalDataSource>(UserLocalDataSource());
    Get.put<IUserRepository>(UserRepository(Get.find(), Get.find()));
    Get.put<UserUseCase>(UserUseCase(Get.find()));
    Get.put<UserController>(UserController(userUseCase: Get.find()));
  }
}
