import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({super.key, required this.number, required this.color, required this.title});

  final int number;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5, color: color))),
      SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey))
        ],
      )
    ]);
  }
}
