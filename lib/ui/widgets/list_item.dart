import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/random_user.dart';
import '../controllers/user_controller.dart';

class ListItem extends StatelessWidget {
  final RandomUser user;
  const ListItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logInfo("ListItem for user " + user.name.toString());
    UserController userController = Get.find();
    int id = user.id ?? 0;
    return Center(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Deleting",
                style: TextStyle(color: Colors.white),
              ),
            )),
        onDismissed: (direction) {
          // Remove the item from the data source.
          userController.deleteUser(user.id);
        },
        child: Card(
          key: Key('userItem' + id.toString()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  // leading: CircleAvatar(
                  //   radius: 30.0,
                  //   backgroundColor: Colors.transparent,
                  //   child: ClipOval(child: Image.network(user.picture)),
                  // ),
                  title: Text(user.name),
                  subtitle: Text(user.city),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('userdetail', arguments: [user, user.id]);
                },
                child: const Text("more"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
