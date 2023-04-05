import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NeuButton extends StatelessWidget {
  final onTap;
  final isButtonPressed;
  const NeuButton({super.key, this.onTap, required this.isButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 40,
        width: 40,
        child: Icon(
          Icons.favorite,
          size: 20,
          color: isButtonPressed ? Colors.grey : Colors.red[400],
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(35),
          boxShadow: isButtonPressed
              ? []
              : [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(6, 6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6, -6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
        ),
      ),
    );
  }
}
