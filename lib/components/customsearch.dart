import 'package:flutter/material.dart';

class CustomSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final Function onClear;
  final String hintText;

  const CustomSearchBox({
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(30.0),
        gradient: const LinearGradient(
          colors: [Colors.white,],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    controller.clear();
                    onClear();
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        ),
        style: const TextStyle(color: Colors.blueGrey),
      ),
    );
  }
}
