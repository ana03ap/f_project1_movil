import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_binding.dart';
import 'pages/user_detail_page.dart';
import 'pages/user_list_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web Service',
      initialBinding: HomeBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => UserListPage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/userdetail',
          page: () => const UserDetailPage(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
