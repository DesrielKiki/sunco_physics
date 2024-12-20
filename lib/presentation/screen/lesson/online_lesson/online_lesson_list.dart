import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/lesson/online_lesson/online_lesson_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class OnlineLessonListScreen extends StatefulWidget {
  const OnlineLessonListScreen({super.key});

  @override
  State<OnlineLessonListScreen> createState() => _OnlineLessonListScreenState();
}

class _OnlineLessonListScreenState extends State<OnlineLessonListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredLessons = [];
  List<Map<String, dynamic>> _allLessons = [];
  String _searchText = '';
  bool isAdmin = false;

  // Fetch lessons from Firestore
  Future<void> _fetchLessons() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('lessons').get();
    final lessons = snapshot.docs.map((doc) {
      return {
        'id': doc.id, // ID dokumen
        'title': doc['title'],
        'content': doc['content'],
        'createdAt': doc['createdAt'].toDate(),
      };
    }).toList();

    setState(() {
      _allLessons = lessons;
      _filteredLessons = lessons; // Initially show all lessons
    });
  }

  void _checkAdminStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email == 'admin@gmail.com') {
      setState(() {
        isAdmin = true;
      });
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchLessons();
    _checkAdminStatus();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text;

      // Filter lessons based on search query
      _filteredLessons = _allLessons.where((lesson) {
        return lesson['title']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.primaryColor,
        title: const Text('Material Physics'),
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addLesson');
              },
              backgroundColor: ColorConfig.primaryColor,
              child: const Icon(Icons.add),
            )
          : null,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Material',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchText.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _filteredLessons = _allLessons;
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: LessonGrid(filteredLessons: _filteredLessons),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonGrid extends StatelessWidget {
  const LessonGrid({
    super.key,
    required this.filteredLessons,
  });

  final List<Map<String, dynamic>> filteredLessons;

  @override
  Widget build(BuildContext context) {
    return filteredLessons.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/ic_notfound.png', height: 120),
                const SizedBox(height: 16),
                const Text(
                  "Material Not Found",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: filteredLessons.length,
            itemBuilder: (context, index) {
              final lesson = filteredLessons[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LessonDetailScreen(lessonId: lesson['id']),
                    ),
                  );
                },
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 136,
                        height: 136,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: ColorConfig.gradientBrandReverse,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.book,
                                size: 64,
                                color: Colors.white,
                              ),
                              SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        lesson['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorConfig.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
