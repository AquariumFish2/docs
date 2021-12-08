import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/add_patient_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  final emailKey = const Key('emai' 'l.Key');

  final passwordKey = const Key('password');

  final passwordConfirmKey = const Key('passwordConfirm');

  final authFormKey = GlobalKey<FormState>();

  bool signIn = true;

  void save(Auth auth) {
    authFormKey.currentState!.save();
    if (signIn) {
      auth.signIn();
    } else {
      auth.register();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: authFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddPatientTextField(
                label: 'الايميل',
                controller: emailController,
                tKey: emailKey,
                multiline: false,
                save: (v) {
                  auth.setEmail(v);
                },
                validate: (v) {},
              ),
              AddPatientTextField(
                label: 'كلمة السر',
                controller: passwordController,
                tKey: passwordKey,
                multiline: false,
                save: (v) {
                  auth.setPassword(v);
                },
                validate: (v) {},
              ),
              if (!signIn)
                AddPatientTextField(
                  label: 'تأكيد كلمة السر',
                  controller: passwordConfirmController,
                  tKey: passwordConfirmKey,
                  multiline: false,
                  save: (v) {},
                  validate: (v) {
                    if (passwordConfirmController.text !=
                        passwordController.text) {
                      return 'كلمة السر غير متشابهة';
                    }
                  },
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    signIn = !signIn;
                  });
                },
                child: (signIn)
                    ? const Text('التسجيل')
                    : const Text('تسجيل الدخول'),
              ),
              ElevatedButton(
                  onPressed: () => save(auth),
                  child: (signIn)
                      ? const Text('تسجيل الدخول')
                      : const Text('التسجيل'))
            ],
          ),
        ),
      ),
    );
  }
}
