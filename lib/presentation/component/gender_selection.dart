import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class GenderDropdown extends StatefulWidget {
  final Function(String?)? onChanged;
  final String? selectedGender;

  const GenderDropdown({
    super.key,
    this.onChanged,
    this.selectedGender,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  final List<Map<String, dynamic>> _genderOptions = [
    {
      'label': 'Male',
      'icon': Icons.male,
    },
    {
      'label': 'Female',
      'icon': Icons.female,
    },
    {
      'label': 'Rather not to say',
      'icon': Icons.question_mark,
    },
  ];

  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConfig.onPrimaryColor,
        labelText: "Gender",
        hintText: "Select your gender",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      value: _selectedGender,
      items: _genderOptions.map((option) {
        return DropdownMenuItem<String>(
          value: option['label'],
          child: Row(
            children: [
              Icon(
                option['icon'],
                color: ColorConfig.primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                option['label'],
                style: const TextStyle(
                  color: ColorConfig.black,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
