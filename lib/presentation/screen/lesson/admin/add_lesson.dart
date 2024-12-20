import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({super.key});

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  final List<Map<String, dynamic>> _lessonContent = [];
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _addTextContent() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _lessonContent.add({
          'type': 'text',
          'value': _textController.text,
        });
        _textController.clear();
      });
    }
  }

  Future<void> _addImageContent() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('lesson_images/$fileName');

      final UploadTask uploadTask = storageRef.putFile(File(image.path));
      final TaskSnapshot snapshot = await uploadTask;
      final String imageUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _lessonContent.add({
          'type': 'image',
          'value': imageUrl,
        });
      });
    }
  }

  void _addQuestionContent(String title, String question, String answer) {
    setState(() {
      _lessonContent.add({
        'type': 'question',
        'value': {'title': title, 'question': question, 'answer': answer},
      });
    });
  }

  void _previewLesson() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _lessonContent.map((content) {
                  if (content['type'] == 'text') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        content['value'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  } else if (content['type'] == 'image') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(content['value']),
                    );
                  } else if (content['type'] == 'question') {
                    return QuestionButton(
                      title: content['value']['title'],
                      question: content['value']['question'],
                      answer: content['value']['answer'],
                    );
                  }
                  return const SizedBox.shrink();
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveLesson() async {
    await FirebaseFirestore.instance.collection('lessons').add({
      'content': _lessonContent,
      'createdAt': DateTime.now(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lesson saved successfully!')),
    );
    setState(() {
      _lessonContent.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Add Text',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTextContent,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _addImageContent,
                  icon: const Icon(Icons.image),
                  label: const Text('Add Image'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await showDialog<Map<String, String>>(
                      context: context,
                      builder: (context) => const AddQuestionDialog(),
                    );
                    if (result != null) {
                      _addQuestionContent(
                        result['title']!,
                        result['question']!,
                        result['answer']!,
                      );
                    }
                  },
                  icon: const Icon(Icons.quiz),
                  label: const Text('Add Question'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _previewLesson,
              child: const Text('Preview Lesson'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveLesson,
              child: const Text('Save Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddQuestionDialog extends StatefulWidget {
  const AddQuestionDialog({Key? key}) : super(key: key);

  @override
  _AddQuestionDialogState createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Question'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'title': _titleController.text,
              'question': _questionController.text,
              'answer': _answerController.text,
            });
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class QuestionButton extends StatelessWidget {
  final String title;
  final String question;
  final String answer;

  const QuestionButton({
    Key? key,
    required this.title,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(question),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Answer: $answer'),
        ),
      ],
    );
  }
}
