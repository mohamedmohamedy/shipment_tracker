import 'package:flutter/material.dart';

import '../values/doubles.dart';

class ListItem extends StatelessWidget {
  ListItem({
    Key? key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
  }) : super(key: key);

  final String title;
  String? leading;
  String? subtitle;
  Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Doubles.d_8),
      child: Card(
        color: Colors.blueGrey[200],
        elevation: 8,
        shape: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Colors.grey, width: Doubles.d_1),
            borderRadius: BorderRadius.circular(Doubles.d_25)),
        child: Padding(
          padding: const EdgeInsets.all(Doubles.d_8),
          child: ListTile(
            title: Text(title),
            leading: CircleAvatar(
              backgroundColor: Colors.indigo[400],
              child: leading != null ? Text(leading!) : null,
            ),
            subtitle: subtitle != null ? Text(subtitle!) : null,
            trailing: trailing != null ? trailing! : null ,
          ),
        ),
      ),
    );
  }
}
