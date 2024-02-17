import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberView extends StatelessWidget {
  final String _title;
  final double _value;

  const NumberView(this._title, this._value, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_title),
      trailing: SizedBox(
        width: 100,
        height: 30,
        child: TextField(
          controller: TextEditingController(text: _value.toString()),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              fillColor: Theme.of(context).primaryColor,
              focusColor: Theme.of(context).primaryColor,
              hoverColor: Theme.of(context).focusColor,
              filled: true),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
      ),
    );
  }
}
