import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/bottomnav.dart';
import 'package:sample/provider/pati.dart';
import 'package:sample/provider/state.dart';
import 'package:sample/provider/vol.dart';
import 'package:sample/screens/stream_builder.dart';

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
    print(FirebaseDatabase.instance.ref());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateManagment>(
          create: (context) => StateManagment(),
        ),
        ChangeNotifierProvider<BottomNav>(
          create: (context) => BottomNav(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
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
                ),),),
        home: const MainStream(),
      ),
    );
  }
}
