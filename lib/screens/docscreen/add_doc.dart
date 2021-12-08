import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helper.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/add_patient_text_field.dart';

// ignore: must_be_immutable
class AddDoctor extends StatefulWidget {
  AddDoctor({Key? key, this.id}) : super(key: key);
  String? id;
  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  Map<String, Object> toAdd = {};
  bool value = true;
  bool agreed = false;
  bool triedToValidate = false;
  bool once = true;
  final key = GlobalKey<FormState>();
  String? val;

  final TextEditingController docNameController = TextEditingController();
  final TextEditingController docPhoneController = TextEditingController();
  final TextEditingController docEmailController = TextEditingController();
  final TextEditingController hintController = TextEditingController();
  final Key docNameKey = const Key('docName');
  final Key docPhoneKey = const Key('docPhone');
  final Key docEmailKey = const Key('docEmail');
  final Key hintKey = const Key('doctorHint');
  @override
  void didChangeDependencies() {
    if (once) {
      if (widget.id != null) {
        final prov = Provider.of<Doc>(context);
        final docs = prov.doctors;
        final i = docs.indexWhere((element) => element['id'] == widget.id);
        docNameController.text = docs[i]['name'] as String;
        if (docs[i]['phone'] == null) {
          value = false;
          docEmailController.text = docs[i]['email'] as String;
        } else {
          docPhoneController.text = docs[i]['phone'] as String;
        }
        val = docs[i]['type'] as String;
        agreed = docs[i]['agreed'] as bool;
        hintController.text = docs[i]['hint'] as String;
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Doc>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    void save() {
      setState(() {
        triedToValidate = true;
      });
      bool validate = key.currentState!.validate();
      if (val != null && validate) {
        toAdd['type'] = val as String;
        toAdd['agreed'] = agreed;

        if (value == true) {
          toAdd['cont'] = contactType.phone;
        } else {
          toAdd['cont'] = contactType.email;
        }
        toAdd['id'] = DateTime.now().toIso8601String();
        key.currentState!.save();
        if (widget.id == null) {
          prov.add(toAdd);
        } else {
          prov.delete(widget.id as String);
          prov.add(toAdd);
        }
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddPatientTextField(
                  label: 'اسم الدكتور',
                  controller: docNameController,
                  tKey: docNameKey,
                  save: (v) => {toAdd['name'] = v as String},
                  validate: (v) {
                    if (v!.length < 4) return 'ادخل اسم صحيح';
                  },
                  multiline: false),
              Row(
                children: [
                  SizedBox(
                      width: size.width * .8,
                      child: AddPatientTextField(
                          label: 'رقم التليفون',
                          controller: docPhoneController,
                          tKey: docPhoneKey,
                          save: (v) => toAdd['phone'] = v as String,
                          validate: (v) {
                            if (v!.length != 10 && v.length != 11) {
                              return ' ادخل رقم هاتف صحيح';
                            }
                          },
                          multiline: false)),
                  Switch(
                    value: value,
                    onChanged: (v) => setState(
                      () {
                        value = v;
                      },
                    ),
                  ),
                ],
              ),
              (value)
                  ? Container()
                  : AddPatientTextField(
                      label: 'طريقة التواصل',
                      controller: docEmailController,
                      tKey: docEmailKey,
                      save: (v) => toAdd['email'] = v as String,
                      validate: (v) {
                        if (!v!.contains('@') || !v.contains('.com')) {
                          return 'ادخل بريد الكتروني صحيح';
                        }
                      },
                      multiline: false),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                              width: 1, color: Colors.greenAccent),
                        ),
                        elevation: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButton(
                            isDense: true,
                            elevation: 0,
                            // focusColor: Colors.white,
                            underline: Container(),
                            value: val,
                            isExpanded: true,
                            hint: const Text('اختر التخصص'),
                            onChanged: (va) => setState(() {
                              val = va as String;
                            }),
                            items: List.generate(
                              speciality.length,
                              (index) => DropdownMenuItem(
                                child: Text(
                                  speciality[index],
                                ),
                                value: speciality[index],
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                    if (triedToValidate && val == null)
                      const Text(
                        'اختر التخصص',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                ),
              ),
              AddPatientTextField(
                  label: 'ملاحظة',
                  controller: hintController,
                  tKey: hintKey,
                  save: (v) => toAdd['hint'] = v as String,
                  validate: (v) {},
                  multiline: true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                child: GestureDetector(
                  child: Row(
                    children: [
                      const Text('موافق يشتغل معانا؟'),
                      const Spacer(),
                      (!agreed)
                          ? const Icon(
                              Icons.check_box_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      agreed = !agreed;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: save,
                child: const Text('save'),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(size.width * .8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
