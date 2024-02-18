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
  String? currentSelectedValue;

  @override
  void initState() {
    super.initState();
    currentSelectedValue = widget._themes["activeThemeId"];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text("Theme"),
          trailing: SizedBox(
            width: 300,
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    isCollapsed: false,
                    isDense: false,
                  ),
                  isEmpty: currentSelectedValue == '',
                  child: DropdownButtonHideUnderline(
                    //TODO Aggiustare altezza menu dropdown
                    child: DropdownButton<String>(
                      value: currentSelectedValue,
                      isExpanded: true,
                      isDense: false,
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
