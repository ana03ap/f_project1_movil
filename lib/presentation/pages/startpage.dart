import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Start Page!',
          style: AppStyles.title,
        ),
      ),
    );
  }
}
