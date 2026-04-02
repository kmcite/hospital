import 'package:flutter/material.dart';
import 'package:hospital/data/medical_data.dart';

class TreatmentOptionsSelector extends StatelessWidget {
  final List<TreatmentOption> suggestedOptions;
  final Set<String> givenTreatments;
  final Function(TreatmentOption) onOptionSelected;

  const TreatmentOptionsSelector({
    super.key,
    required this.suggestedOptions,
    required this.givenTreatments,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Recommended Solutions:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 140,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: suggestedOptions.map((treatment) {
                final isAlreadyGiven = givenTreatments.contains(treatment.name);
                return ActionChip(
                  label: Text(
                    treatment.name,
                    style: TextStyle(
                      decoration: isAlreadyGiven
                          ? TextDecoration.lineThrough
                          : null,
                      color: isAlreadyGiven ? Colors.grey : null,
                    ),
                  ),
                  onPressed: isAlreadyGiven
                      ? null
                      : () => onOptionSelected(treatment),
                  avatar: isAlreadyGiven
                      ? const Icon(Icons.check, size: 16, color: Colors.green)
                      : null,
                  backgroundColor: isAlreadyGiven
                      ? Colors.black12
                      : Theme.of(context).colorScheme.primaryContainer,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
