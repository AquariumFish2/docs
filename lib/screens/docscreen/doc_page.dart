import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/screens/app_bar_button.dart';
import 'package:sample/screens/docscreen/add_doc.dart';
import 'package:sample/provider/doc.dart';
import '../../helper.dart';
import 'widgets/doc_sample.dart';

class DocList extends StatelessWidget {
  const DocList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final docs = Provider.of<Doc>(context);
    //contactType _contactType;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدكاترة'),
        actions: [
          AppBarButton(
            onPressed:()=> Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  AddDoctor(),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.red[300],
                      ),
                      const Text('phone'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.blue[300],
                      ),
                      const Text('email address'),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: docs.doctors
                  .map((e) => DocSample(
                    id: e['id'] as String,
                        cont: e['cont'] as contactType,
                        docName: e['name'] as String,
                        agreed: e['agreed'] as bool,
                        docType: e['type'] as String,
                        hint: e['hint'] as String?,
                        docEmail: e['email'] as String?,
                        docNum: e['phone'] as String?,
                        patients: (e['patients'] as List?),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
