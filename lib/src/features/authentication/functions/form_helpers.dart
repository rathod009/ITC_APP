import 'package:flutter/material.dart';

Widget buildTextField(String label, ValueChanged<String> onChanged, 
  FormFieldValidator<String> validator, {TextInputType? keyboardType}) {

  String? errorMessage; // Store error message here

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        hintText: "",
        errorText: errorMessage, // Display the error message (or null if no error)
        errorStyle: const TextStyle( // Consistent error styling
        color: Colors.red,
        fontSize: 11, // Or whatever size you prefer
        ),
      ),
      onChanged: onChanged,
      validator: (value) { // Wrap validator to capture error message
        errorMessage = validator(value); // Store the returned error
        return errorMessage; // Return the error for the TextField
      },
    ),
  );
  }

Widget buildRadioButtons(String label, List<String> options, ValueChanged<String> onChanged, String priorKnowledge) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: options.map((option) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: option,
                groupValue: priorKnowledge,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0.0), // Added space here
                child: Text(option),
              ),
            ],
          )).toList(),
        ),
      ],
    ),
  );
}

  Widget buildDropdown(String label, List<String> options,
    ValueChanged<String?> onChanged, FormFieldValidator<String>? validateCourseCategory) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: DropdownButtonFormField<String>( // Use DropdownButtonFormField directly
      decoration: InputDecoration(
        labelText: label, // Use labelText for the label
        border: const OutlineInputBorder(), // Keep the border
        hintText: "",
        errorStyle: const TextStyle( // Consistent error styling
        color: Colors.red,
        fontSize: 11, // Or whatever size you prefer
        ),
      ),
      items: options.map((option) => DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              overflow: TextOverflow.ellipsis, // Keep ellipsis for long text
            ),
          )).toList(),
      onChanged: onChanged,
      validator: validateCourseCategory,
      isExpanded: true, // Keep isExpanded for full width
      // value: null,  //  Remove this. DropdownButtonFormField handles null by default
    ),
  );
}
