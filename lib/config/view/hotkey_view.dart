import 'package:flutter/material.dart';

class HotKeyView extends StatelessWidget {
  final Map<String, dynamic> _hotkey;

  const HotKeyView(this._hotkey, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> hotkey = [];

    _hotkey["modifiers"].forEach((e) {
      hotkey.add(
        Icon(
          e == 'Alt'
              ? Icons.keyboard_option_key
              : e == 'Ctrl'
                  ? Icons.keyboard_control_key
                  : e == 'Shift'
                      ? Icons.keyboard_capslock
                      : Icons.keyboard,
        ),
      );
    });

    hotkey.add(
      Text(
        '+ ${_hotkey["key"]}',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );

    return ListTile(
      title: Text(_hotkey["name"]),
      trailing: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: hotkey,
        ),
      ),
    );
  }
}
