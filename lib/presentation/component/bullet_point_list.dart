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
              padding:
                  EdgeInsets.only(top: 6.0), // Posisikan titik di tengah teks
              child: Icon(
                Icons.circle, // Icon lingkaran kecil
                size: 8.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8.0), // Jarak antara titik dan teks
            Expanded(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  height: 1.5, // Spasi antar baris
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
