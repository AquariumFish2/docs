import 'package:flutter/material.dart';
import 'package:sample/helper.dart';
import 'package:sample/screens/docscreen/add_doc.dart';

class DocSample extends StatefulWidget {
  const DocSample({
    Key? key,
    required this.cont,
    required this.docName,
    required this.agreed,
    required this.docType,
    required this.id,
    this.docNum,
    this.docEmail,
    this.hint,
    this.patients,
  }) : super(key: key);
  final contactType cont;
  final String docName;
  final String id;
  final String? docNum;
  final String? docEmail;
  final String docType;
  final bool agreed;
  final String? hint;
  final List? patients;

  @override
  State<DocSample> createState() => _DocSampleState();
}

class _DocSampleState extends State<DocSample> {
  bool toggled = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), curve: Curves.bounceOut,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: (widget.agreed) ? Colors.blue[300] : Colors.red[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:5.0,vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.docName,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.docType,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(widget.docEmail != null) ? widget.docEmail : widget.docNum}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AddDoctor(
                          id: widget.id,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (widget.hint != '' && toggled)
            Text(
              widget.hint as String,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          if (widget.patients != null && toggled)
            Column(
              children: widget.patients!
                  .map((e) => Container(
                        color: Colors.green[800],
                        child: Row(
                          children: [
                            Text(
                              e['name'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              e['illness'],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          if (widget.hint != '' || widget.patients!.isEmpty)
            IconButton(
              onPressed: () {
                setState(() {
                  toggled = !toggled;
                });
              },
              splashRadius: 0.1,
              padding: EdgeInsets.zero,
              icon: (!toggled)
                  ? const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                    ),
            )
        ],
      ),
    );
  }
}
