import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LessonDetailScreen extends StatelessWidget {
  final String lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('lessons').doc(lessonId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Loading...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Error fetching lesson data')),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Lesson not found')),
          );
        }

        final lesson = snapshot.data!;
        final title = lesson['title'] as String;
        final content = List<Map<String, dynamic>>.from(lesson['content']);

        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView(
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
                  child: Image.network(
                    item['value'],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
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
          ),
        );
      },
    );
  }
}
