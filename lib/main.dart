import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sample/docicon.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/pati.dart';
import 'package:sample/provider/vol.dart';
import 'package:sample/screens/authscreen/authscreen.dart';
import 'package:sample/screens/docscreen/doc_page.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/screens/patientscreen/patient_page.dart';
import 'package:sample/screens/volscreen/volscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<Doc>(
          create: (context) => Doc(),
        ),
        ChangeNotifierProvider<PatientProv>(
          create: (context) => PatientProv(),
        ),
        ChangeNotifierProvider<Vol>(
          create: (context) => Vol(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const [Locale('ar', '')],
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.green,
                  selectedItemColor: Colors.white,
                  selectedLabelStyle: TextStyle(
                    fontSize: 16,
                  ))),
          home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context,snapshot) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, AsyncSnapshot<User?> snapshot) {
                  print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  {
                    if (snapshot.data!=null) {
                      Scaffold(
                        body: (current == 0)
                            ? const DocList()
                            : (current == 1)
                                ? const PatientScreen()
                                : const VolScreen(),
                        bottomNavigationBar: BottomNavigationBar(
                          currentIndex: current,
                          onTap: (v) => setState(() {
                            current = v;
                          }),
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
                    } else {
                      return const AuthScreen();
                    }
                  }
                  return Container();
                },
              );
            }
          )),
    );
  }
}
