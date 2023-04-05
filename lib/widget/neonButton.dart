import 'package:flutter/material.dart';

class NeuButton extends StatelessWidget {
  const NeuButton({super.key, this.onTap, required this.isButtonPressed});
  final onTap;
  final isButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(35),
          boxShadow: isButtonPressed
              ? []
              : [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(6, 6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6, -6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
        ),
        child: Icon(
          Icons.favorite,
          size: 20,
          color: isButtonPressed ? Colors.grey : Colors.red[400],
        ),
      ),
    );
  }
}
