import 'package:flutter/material.dart';

class ProfileMHS extends StatelessWidget {
  const ProfileMHS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [Center(child: Text('PROFILE'))],
      ),
    );
  }
}
