import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/pati.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list_tile.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patientprov = Provider.of<PatientProv>(context);
    return ListView(
      children: patientprov.patients
          .map((e) => PatientListTile(
                name: (e['name'] as String),
                phone: (e['phoneNum'] as String),
                vol: (e['volName'] as String),
                adress: (e['adress'] as String),
                source: (e['source'] as String),
                followed: e['Doctor'] as bool,
                date: e['date'].toString(),
                illness: e['illness'] as String,
                latest: e['latest'] as String,
              ))
          .toList(),
    );
  }
}
