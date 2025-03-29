import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/connectivity_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/list_item.dart';

class UserListPage extends StatelessWidget {
  UserListPage({Key? key}) : super(key: key);
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User list"), actions: <Widget>[
        IconButton(
            key: const Key('deleteAllButton'),
            onPressed: () {
              userController.deleteAll();
            },
            icon: const Icon(Icons.delete))
      ]),
      floatingActionButton: GetX<ConnectivityController>(
        builder: (controller) {
          return FloatingActionButton(
            key: const Key('addUserButton'),
            child: Icon(controller.connection
                ? Icons.add
                : Icons.portable_wifi_off_rounded),
            onPressed: () async {
              if (controller.connection) {
                await userController.addUser();
              } else {
                Get.snackbar('Refresh failed!', "Can't get users",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red);
              }
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getXlistView(),
      ),
    );
  }

  Widget _getXlistView() {
    return Obx(
      () => ListView.builder(
        itemCount: userController.users.length,
        itemBuilder: (context, index) {
          final user = userController.users[index];
          return ListItem(user);
        },
      ),
    );
  }
}
