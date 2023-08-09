import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandButton extends StatefulWidget {
  const ExpandButton({super.key});

  @override
  State<StatefulWidget> createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(

        iconSize: 10,
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        icon: _expanded ? const Icon(Icons.lock_open) : const Icon(Icons.lock));
  }
}
