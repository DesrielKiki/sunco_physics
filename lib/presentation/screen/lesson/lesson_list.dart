import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/calculator_data.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({super.key});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredLessons = CalculatorEntity.lesson;
  String _searchText = '';

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
      _searchText = _searchController.text;

      _filteredLessons = CalculatorEntity.lesson
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            _filteredLessons = CalculatorEntity.lesson;
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LessonGrid(filteredLessons: _filteredLessons),
            ),
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
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: filteredLessons.length,
            itemBuilder: (context, index) {
              final lesson = filteredLessons[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, lesson['route'] as String);
                },
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
                      const SizedBox(height: 8),
                      Text(
                        lesson['title'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
