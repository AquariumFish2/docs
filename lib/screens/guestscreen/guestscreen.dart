import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحالات'),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: const[],
      ),
    );
  }
}
