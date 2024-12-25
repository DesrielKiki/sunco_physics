import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/application_entity.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class OfflineLessonListScreen extends StatefulWidget {
  const OfflineLessonListScreen({super.key});

  @override
  State<OfflineLessonListScreen> createState() =>
      _OfflineLessonListScreenState();
}

class _OfflineLessonListScreenState extends State<OfflineLessonListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredLessons = ApplicationEntity.lesson;
  String _searchText = '';
  bool isAdmin = false;

  void _checkAdminStatus() async {
    User? user = FirebaseAuth
        .instance.currentUser; // Dapatkan pengguna yang sedang login
    if (user != null && user.email == 'admin@gmail.com') {
      setState(() {
        isAdmin =
            true; // Jika email pengguna adalah admin, set isAdmin menjadi true
      });
    } else {
      setState(() {
        isAdmin = false; // Jika bukan admin, set isAdmin menjadi false
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
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

      _filteredLessons = ApplicationEntity.lesson
          .where((lesson) => lesson['title']!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
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
                              _filteredLessons = ApplicationEntity.lesson;
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
        : Padding(
            padding: const EdgeInsets.only(top: 32),
            child: GridView.builder(
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
                    Navigator.pushNamed(context, lesson['route'] as String);
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  lesson['icon'] as IconData,
                                  size: 64,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lesson['title'] as String,
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
            ),
          );
  }
}
