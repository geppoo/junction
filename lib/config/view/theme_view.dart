import 'package:flutter/material.dart';

class ThemeView extends StatefulWidget {
  final Map<String, dynamic> _themes;
  final List<String> _themeNames = [];

  ThemeView(this._themes, {super.key}) {
    init();
  }

  init() {
    for (var theme in _themes["themes"]) {
      _themeNames.add(theme["id"]);
    }
  }

  @override
  State<StatefulWidget> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  @override
  Widget build(BuildContext context) {
    String? currentSelectedValue = widget._themes["activeThemeId"];

    return ListView(
      children: [
        ListTile(
          title: const Text("Tema"),
          trailing: SizedBox(
            width: 300,
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  isEmpty: currentSelectedValue == '',
                  child: DropdownButtonHideUnderline(
                    //TODO Aggiustare altezza menu dropdown
                    child: DropdownButton<String>(
                      value: currentSelectedValue,
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          currentSelectedValue = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: widget._themeNames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
