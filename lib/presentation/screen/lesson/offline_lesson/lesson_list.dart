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

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
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
      body: CustomScrollView(
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
            expandedHeight: 120.0, // Tinggi AppBar termasuk Search Bar
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search calculators',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white, // Tetap putih
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Jarak dengan list
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
                "Calculator Not Found",
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
                Navigator.pushNamed(context, lesson['route'] as String);
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
                        Image(
                          image: AssetImage(lesson['icon'] as String),
                          width: 81,
                          height: 81,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lesson['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
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
