import 'package:flutter/material.dart';
import 'package:junction/config/junction_widget_settings_repository.dart';
import 'package:provider/provider.dart';

import '../model/junction_model.dart';

class SettingsWindowImpl extends StatefulWidget {
  final JunctionWidgetPropertiesModel props;

  const SettingsWindowImpl(this.props, {super.key});

  @override
  State<StatefulWidget> createState() => _SettingsWindowImplState();
}

class _SettingsWindowImplState extends State<SettingsWindowImpl> {
  int _activeIndex = 0;
  final _controller = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    late final List<ListTile> routes = [];
    late final List<Expanded> pages = [];
    int pageIndex = 0;
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    Map<String, dynamic> settings = junctionModel.junctionSettings.jsonData;

    settings.forEach(
      (key, value) {
        final int index = pageIndex;
        routes.add(
          ListTile(
            title: Text(key),
            onTap: () {
              setState(() {
                _activeIndex = index;
              });
              _controller.animateToPage(
                index,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.linear,
              );
            },
          ),
        );

        pages.add(
          Expanded(
            child: Center(
              child: Text(key),
            ),
          ),
        );

        pageIndex++;
      },
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 200,
                    child: ListView(
                      children: routes,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: PageView(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    children: pages,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
