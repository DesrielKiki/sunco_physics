import 'package:flutter/material.dart';

class BulletPointList extends StatelessWidget {
  final List<String> items;

  const BulletPointList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Icon(
                Icons.circle,
                size: 8.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
