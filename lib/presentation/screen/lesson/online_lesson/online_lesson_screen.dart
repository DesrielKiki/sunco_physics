import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LessonDetailScreen extends StatelessWidget {
  final String lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson Detail')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('lessons')
            .doc(lessonId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching lesson data'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Lesson not found'));
          }

          final lesson = snapshot.data!;
          final content = List<Map<String, dynamic>>.from(lesson['content']);

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: content.map((item) {
              if (item['type'] == 'text') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(item['value']),
                );
              } else if (item['type'] == 'image') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(item['value']),
                );
              } else if (item['type'] == 'question') {
                final question = item['value'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ExpansionTile(
                    title: Text(question['title']),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Question: ${question['question']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Answer: ${question['answer']}'),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }).toList(),
          );
        },
      ),
    );
  }
}
