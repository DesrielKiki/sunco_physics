import 'dart:async';
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
  bool isLoading = true;

  StreamSubscription? _lessonSubscription;

  void _fetchLessons() {
    _lessonSubscription = FirebaseFirestore.instance
        .collection('lessons')
        .snapshots()
        .listen((snapshot) {
      final lessons = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'content': doc['content'],
          'createdAt': doc['createdAt'].toDate(),
        };
      }).toList();

      if (mounted) {
        setState(() {
          _allLessons = lessons;
          _filteredLessons = lessons;
          isLoading = false;
        });
      }
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
    _lessonSubscription?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text;

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
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addLesson');
              },
              backgroundColor: ColorConfig.primaryColor,
              child: const Icon(Icons.add, color: ColorConfig.onPrimaryColor),
            )
          : null,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: ColorConfig.primaryColor,
                  floating: true,
                  pinned: false,
                  snap: true,
                  title: const Text(
                    'Materi Offline',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  expandedHeight: 120.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search online lessons',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
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
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: LessonGrid(filteredLessons: _filteredLessons),
                ),
              ],
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
    if (filteredLessons.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
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
        ),
      );
    } else {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
              child: Column(
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: ColorConfig.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.book,
                          size: 84,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lesson['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: ColorConfig.onPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
          childCount: filteredLessons.length,
        ),
      );
    }
  }
}
