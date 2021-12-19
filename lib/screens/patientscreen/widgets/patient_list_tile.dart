import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientListTile extends StatefulWidget {
  const PatientListTile({
    Key? key,
    required this.name,
    required this.phone,
    required this.adress,
    required this.source,
    required this.vol,
    required this.followed,
    this.illness,
    this.latest,
    required this.date,
  }) : super(key: key);
  final String name;
  final Timestamp date;
  final String phone;
  final String adress;
  final String source;
  final String vol;
  final bool followed;
  final String? illness;
  final String? latest;

  @override
  State<PatientListTile> createState() => _PatientListTileState();
}

class _PatientListTileState extends State<PatientListTile> {
  bool openDetails = false;
  late Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: (widget.followed) ? Colors.cyan[200] : Colors.redAccent[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.name),
                      Text(DateFormat('dd/MM/yyyy').format(
                          Timestamp.fromMillisecondsSinceEpoch(
                                  widget.date.seconds * 1000)
                              .toDate())),
                    ],
                  ),
                  Text(widget.phone),
                  Text(widget.vol),
                ],
              ),
              if (openDetails == true)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.source),
                    Text(widget.adress),
                    if (widget.latest != '') Text(widget.latest as String),
                    if (widget.illness != '') Text(widget.illness as String)
                  ],
                ),
              IconButton(
                onPressed: () {
                  setState(() {
                    openDetails = !openDetails;
                  });
                },
                icon: (!openDetails)
                    ? const Icon(Icons.arrow_drop_down)
                    : const Icon(Icons.arrow_drop_up),
              )
            ],
          ),
        ),
      ),
    );
  }
}
