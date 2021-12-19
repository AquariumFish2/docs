import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';
import 'package:sample/screens/authscreen/authscreen.dart';
import 'package:sample/screens/patientscreen/patient_page.dart';
import 'package:sample/screens/volscreen/volscreen.dart';

import '../docicon.dart';
import 'docscreen/doc_page.dart';
import 'guestscreen/guestscreen.dart';

class MainStream extends StatefulWidget {
  const MainStream({Key? key}) : super(key: key);

  @override
  _MainStreamState createState() => _MainStreamState();
}

class _MainStreamState extends State<MainStream> {
  late final Stream<User?> stream;
  @override
  void initState() {
    super.initState();
    stream = FirebaseAuth.instance.userChanges();
  }

  @override
  Widget build(BuildContext context) {
    final bottomnav = Provider.of<BottomNav>(context, listen: false);
    final current = Provider.of<BottomNav>(context).current;
    return StreamBuilder<User?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isAnonymous) {
            return const GuestScreen();
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            body: (current == 0)
                ? const DocList()
                : (current == 1)
                    ? const PatientScreen()
                    : const VolScreen(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: current,
              onTap: (v) => bottomnav.set(v),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    DocIcons.doctor,
                  ),
                  label: 'الدكاترة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notes,
                  ),
                  label: 'الابحاث',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'المتطوعين',
                ),
              ],
            ),
          );
        }
        return const AuthScreen();
      },
    );
  }
}
