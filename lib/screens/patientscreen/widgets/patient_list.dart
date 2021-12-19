import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list_tile.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('patients').get().asStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                final Map<String, dynamic> e =
                    document.data() as Map<String, dynamic>;
                return PatientListTile(
                  name: (e['name'] as String),
                  phone: (e['phoneNum'] as String),
                  vol: (e['volName'] as String),
                  adress: (e['adress'] as String),
                  source: (e['source'] as String),
                  followed: e['Doctor'] as bool,
                  date: e['date'] as Timestamp,
                  illness: e['illness'] as String,
                  latest: e['latest'] as String,
                );
              }).toList(),
            );
          }
          return const Center(
            child: Text('لا توجد حالات'),
          );
        });
  }
}
