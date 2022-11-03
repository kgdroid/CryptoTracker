import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.light});
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/doremon.jpeg'),
            ),
          ),
          const Text(
            'Krishan Gopal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
