import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/random_user.dart';
import '../controllers/user_controller.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  RandomUser user = Get.arguments[0];

  final controllerName = TextEditingController();
  final controllerCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    controllerName.text = user.name;
    controllerCity.text = user.city;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await userController.deleteUser(user.id);
              Get.back();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                key: const Key('TextFieldCity'),
                controller: controllerCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () async {
                            RandomUser userM = user;
                            userM.name = controllerName.text;
                            userM.city = controllerCity.text;
                            await userController.updateUser(userM);
                            Get.back();
                          },
                          child: const Text("Save")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
