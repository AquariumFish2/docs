import 'package:flutter/material.dart';
import 'package:sample/screens/volscreen/widgets/vollist.dart';

class VolScreen extends StatelessWidget {
  const VolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتطوعين'),

      ),
      body: const VolList(),
    );
  }
}
