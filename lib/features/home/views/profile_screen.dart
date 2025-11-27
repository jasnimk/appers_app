import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
      ),
      body: Center(
        child: Text('Profile Screen - Settings & Theme toggle will go here'),
      ),
    );
  }
}
