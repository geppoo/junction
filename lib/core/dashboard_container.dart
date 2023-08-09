import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget{
  const DashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
    children: [SizedBox(width: 100, height: 100, child: TextButton(onPressed: () {}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lime)), child: const Text('Chiappe'),)),SizedBox(width: 100, height: 100, child: TextButton(onPressed: () {}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lime)), child: const Text('Chiappe'),)),SizedBox(width: 100, height: 100, child: TextButton(onPressed: () {}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lime)), child: const Text('Chiappe'),))],
);
  }
}
