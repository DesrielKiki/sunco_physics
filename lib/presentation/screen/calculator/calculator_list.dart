import 'package:flutter/material.dart';
import 'package:sunco_physics/database/calculator_data.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class CalculatorListScreen extends StatefulWidget {
  const CalculatorListScreen({super.key});

  @override
  State<CalculatorListScreen> createState() => _CalculatorListScreenState();
}

class _CalculatorListScreenState extends State<CalculatorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredCalculator = CalculatorEntity.data;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchController.text = '';
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

      _filteredCalculator = CalculatorEntity.data
          .where((calculator) => calculator['title']!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Physics Calculators'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.menu,
                      color: ColorConfig.grey,
                      size: 24,
                    ),
                    suffixIcon: _searchText.isEmpty
                        ? const Icon(
                            Icons.search,
                            color: ColorConfig.grey,
                            size: 24,
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: ColorConfig.grey,
                              size: 24,
                            ),
                            onPressed: () {
                              _searchController.clear();
                            },
                          ),
                    hintText: 'Search Calculator',
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: ColorConfig.black),
                    contentPadding: const EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 10),
                  ),
                  style: const TextStyle(color: ColorConfig.black),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _filteredCalculator.length,
                  itemBuilder: (context, index) {
                    final calculator = _filteredCalculator[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, calculator['route'] as String);
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              calculator['icon'] as IconData,
                              size: 40,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              calculator['title'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
