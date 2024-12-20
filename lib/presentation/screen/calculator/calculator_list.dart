import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/application_entity.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class CalculatorListScreen extends StatefulWidget {
  const CalculatorListScreen({super.key});

  @override
  State<CalculatorListScreen> createState() => _CalculatorListScreenState();
}

class _CalculatorListScreenState extends State<CalculatorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredCalculator = ApplicationEntity.calculator;
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

      _filteredCalculator = ApplicationEntity.calculator
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
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
        title: const Text('Physics Calculators'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search Calculator',
              trailing: [
                IconButton(
                  icon: _searchText.isEmpty
                      ? const Icon(Icons.search)
                      : const Icon(Icons.close),
                  onPressed: () {
                    if (_searchText.isNotEmpty) {
                      _searchController.clear();
                      setState(() {
                        _searchText = '';
                        _filteredCalculator = ApplicationEntity.calculator;
                      });
                    }
                  },
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                  _filteredCalculator = ApplicationEntity.calculator
                      .where((calculator) => calculator['title']!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  CalculatorGridItem(filteredCalculator: _filteredCalculator),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorGridItem extends StatelessWidget {
  const CalculatorGridItem({
    super.key,
    required this.filteredCalculator,
  });

  final List<Map<String, dynamic>> filteredCalculator;

  @override
  Widget build(BuildContext context) {
    return filteredCalculator.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ic_notfound.png',
              ),
              const SizedBox(height: 20),
              const Text(
                "Kalkulator Tidak Di temukan",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ))
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: filteredCalculator.length,
            itemBuilder: (context, index) {
              final calculator = filteredCalculator[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, calculator['route'] as String);
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
          );
  }
}
