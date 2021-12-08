import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/provider/pati.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/add_patient_text_field.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({Key? key}) : super(key: key);

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final fkey = GlobalKey<FormState>();

  final TextEditingController patientNameController = TextEditingController();

  final TextEditingController patientPhoneController = TextEditingController();

  final TextEditingController patientAdressController = TextEditingController();

  final TextEditingController sourceController = TextEditingController();

  final TextEditingController volNameController = TextEditingController();

  final TextEditingController ilnessController = TextEditingController();

  final TextEditingController latestController = TextEditingController();

  final Key patientNameKey = const Key('patientName');

  final Key patientNumKey = const Key('patientNum');

  final Key patientAdressKey = const Key('patientAdress');

  final Key sourceKey = const Key('sourceKey');

  final Key volNameKey = const Key('volNameKey');

  final Key ilnessKey = const Key('ilnessKey');

  final Key latestKey = const Key('latestKey');

  String? value;

  @override
  Widget build(BuildContext context) {
    final docs = Provider.of<Doc>(context);
    final patients = Provider.of<PatientProv>(context, listen: false);
    Map<String, Object> newPatient = {};
    void save() {
      if (fkey.currentState!.validate()) {
        if (value == null) {
          newPatient['Doctor'] = false;
        } else {
          int i =
              docs.doctors.indexWhere((element) => element['name'] == value);
          newPatient['Doctor'] = true;
          newPatient['date'] = DateTime.now();
          (docs.doctors[i]['patients'] as List).add(newPatient);
          fkey.currentState!.save();
        }
        patients.addPatient(newPatient);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: fkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddPatientTextField(
                label: 'الاسم',
                controller: patientNameController,
                tKey: patientNameKey,
                save: (v) {
                  newPatient['name'] = v;
                },
                validate: (String v) {
                  if (v.length < 4) return 'ادخل اسم صحيح';
                },
                multiline: false,
              ),
              AddPatientTextField(
                label: 'رقم التلفون',
                controller: patientPhoneController,
                tKey: patientNumKey,
                save: (v) {
                  newPatient['phoneNum'] = v;
                },
                validate: (String v) {
                  if (v.length != 10 && v.length != 11) return 'ادخل رقم صحيح';
                },
                multiline: false,
              ),
              AddPatientTextField(
                label: 'العنوان',
                controller: patientAdressController,
                tKey: patientAdressKey,
                multiline: false,
                save: (v) {
                  newPatient['adress'] = v;
                },
                validate: (String v) {
                  if (v.length < 4) return 'ادخل عنوان مناسب';
                },
              ),
              AddPatientTextField(
                label: 'اسم السورس',
                controller: sourceController,
                tKey: sourceKey,
                multiline: false,
                save: (v) => newPatient['source'] = v,
                validate: (v) {
                  if (v.length < 4) return 'ادخل اسم صحيح';
                },
              ),
              AddPatientTextField(
                label: 'اسم المتابع',
                controller: volNameController,
                tKey: volNameKey,
                multiline: false,
                save: (v) => newPatient['volName'] = v,
                validate: (v) {
                  if (v.length < 4) return 'ادخل اسم مناسب';
                },
              ),
              AddPatientTextField(
                label: 'التشخيص',
                controller: ilnessController,
                tKey: ilnessKey,
                multiline: true,
                save: (v) => newPatient['illness'] = v,
                validate: (v) {},
              ),
              AddPatientTextField(
                label: 'اخر ما وصلناله',
                controller: latestController,
                tKey: latestKey,
                validate: (v) {},
                save: (v) => newPatient['latest'] = v,
                multiline: true,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side:
                        const BorderSide(width: 1, color: Colors.greenAccent)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButton(
                    isDense: true,
                    hint: const Text('اختر الطبيب المتابع'),
                    value: value,
                    underline: Container(),
                    onChanged: (v) => setState(() {
                      value = v as String;
                    }),
                    items: docs.doctors.map(
                      (e) {
                        return DropdownMenuItem(
                          child: Text(e['name'] as String),
                          value: e['name'],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              ElevatedButton(onPressed: save, child: const Text('save'))
            ],
          ),
        ),
      ),
    );
  }
}
