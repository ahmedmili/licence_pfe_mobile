import 'package:flutter/material.dart';
import 'package:saverapp/Services/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeuButton extends StatefulWidget {
  const NeuButton({
    super.key,
    required this.boxid,
  });
  // final onTap;
  final int boxid;

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool isButtonPressed = false;

  Future<void> buttonPresssed(String token) async {
    // var boxid = widget.boxid;
    String message = await UserService.likeOrDislikeBox(token, widget.boxid);
    print(message);
    setState(() {
      isButtonPressed = !isButtonPressed;
    });
    // print("box id : $boxid is pressed .? $isButtonPressed");
    // print(token);
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readToken(),
        builder: (context, tokensnapshot) {
          if (tokensnapshot.hasData) {
            return GestureDetector(
              onTap: () => buttonPresssed(tokensnapshot.data!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: isButtonPressed
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
                  color: isButtonPressed ? Colors.red[400] : Colors.grey,
                ),
              ),
            );
          } else if (tokensnapshot.hasError) {
            return Text('Error: ${tokensnapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                strokeWidth: 5,
              ),
            );
          }
        });
  }
}
