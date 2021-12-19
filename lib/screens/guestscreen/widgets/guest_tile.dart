import 'package:flutter/material.dart';

class GuestTile extends StatelessWidget {
  const GuestTile({
    Key? key,
    required this.illness,
    required this.needs,
  }) : super(key: key);
  final String illness;
  final Map<String, int> needs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: creating(),
    );
  }
  List<Widget> creating(){
  List<Widget> created=[];
  for (var i = 0; i < needs.length; i++) {
    created.add(Row(
      children: [
        Text('${needs.keys.elementAt(i)} :'),
        Text('${needs[i]}'),
      ],
    ));
  }
    return created;
}
}
