import 'package:flutter/material.dart';
import 'package:saverapp/Services/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeuButton extends StatefulWidget {
  const NeuButton({
    super.key,
    required this.boxid,
    required this.isLiked,
  });
  // final onTap;
  final int boxid;
  final bool isLiked;

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool isliked = false;
  @override
  void initState() {
    super.initState();
    isliked = widget.isLiked;
  }

  Future<void> buttonPresssed() async {
    setState(() {
      isliked = !isliked;
    });
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buttonPresssed(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(35),
          boxShadow:
              // widget.isLiked
              isliked
                  ? [
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
                    ]
                  : [],
        ),
        child: Icon(
          Icons.favorite,
          size: 20,
          color:
              //  widget.isLiked
              isliked ? Colors.red[400] : Colors.grey,
        ),
      ),
    );
  }
}
