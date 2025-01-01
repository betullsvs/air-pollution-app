import 'package:flutter/material.dart';

class EntryButton extends StatelessWidget {
  final String buttonText;
  final Widget pageRoute;
  final Color backgroundColor;

  const EntryButton({
    super.key,
    required this.buttonText,
    required this.pageRoute,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageRoute,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: const Size(350, 60),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 60,
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 48, 48, 48),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
