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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConfig.primaryColor,
            floating: true,
            pinned: false,
            snap: true,
            title: const Text(
              'Physics Calculators',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            foregroundColor: Colors.white,
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
                        hintText: 'Search Calculator',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
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
            padding: const EdgeInsets.all(8.0),
            sliver: CalculatorGridItem(filteredCalculator: _filteredCalculator),
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
    if (filteredCalculator.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ic_notfound.png',
                height: 120,
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
          ),
        ),
      );
    } else {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final calculator = filteredCalculator[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, calculator['route'] as String);
              },
              child: Card(
                color: ColorConfig.primaryColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(calculator['icon'] as String),
                      width: 81,
                      height: 81,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      calculator['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorConfig.onPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: filteredCalculator.length,
        ),
      );
    }
  }
}
