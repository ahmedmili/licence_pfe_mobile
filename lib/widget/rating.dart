// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProductRatingPage extends StatefulWidget {
//   const ProductRatingPage({super.key});

//   @override
//   PartnerRatingPageState createState() => PartnerRatingPageState();
// }

// class PartnerRatingPageState extends State<ProductRatingPage> {
//   late TextEditingController _ratingController;
//   late int _selectedRating = 0;
//   late String _selectedEmoji = "";

//   // final String _productId = "your_product_id";

//   @override
//   void initState() {
//     super.initState();
//     _ratingController = TextEditingController();
//     _selectedRating = 0;
//     _selectedEmoji = "";
//   }

//   @override
//   void dispose() {
//     _ratingController.dispose();
//     super.dispose();
//   }

//   void _submitRating() async {
//     // const String apiUrl = "http://your-api-url.com/api/ratings";

//     print(_selectedRating.toString());
//     print(_selectedEmoji.toString());
//     // final Map<String, dynamic> requestData = {
//     //   "product_id": _productId,
//     //   "rating": _selectedRating.toString(),
//     //   "comment": _ratingController.text,
//     // };

//     // final http.Response response = await http.post(
//     //   Uri.parse(apiUrl),
//     //   body: requestData,
//     // );

//     // final Map<String, dynamic> responseData = json.decode(response.body);

//     // if (response.statusCode == 200) {
//     //   // Rating submitted successfully
//     //   print(responseData);
//     // } else {
//     //   // Rating submission failed
//     //   print(responseData['error']);
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Rating'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             const Text(
//               'Rate the product:',
//               style: TextStyle(fontSize: 18.0),
//             ),
//             const SizedBox(height: 16.0),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: <Widget>[
//             Flex(
//               direction: Axis.horizontal,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildEmojiButton('😍', 1),
//                 const SizedBox(width: 5),
//                 _buildEmojiButton('😐', 2),
//                 const SizedBox(width: 5),
//                 _buildEmojiButton('😞', 3),
//               ],
//             ),
//             //   ],
//             // ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _ratingController,
//               decoration: const InputDecoration(
//                 labelText: 'Comment',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _submitRating,
//               child: const Text('Submit Rating'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget _buildRatingButton(int rating) {
//   //   return IconButton(
//   //     onPressed: () {
//   //       setState(() {
//   //         _selectedRating = rating;
//   //       });
//   //     },
//   //     icon: Icon(
//   //       Icons.star,
//   //       color: rating <= _selectedRating ? Colors.yellow : Colors.grey,
//   //     ),
//   //   );
//   // }
//   Widget _buildEmojiButton(String emoji, int rate) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedRating = rate;
//           _selectedEmoji = emoji;
//         });
//       },
//       child: Container(
//         width: 60.0,
//         height: 60.0,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: _selectedEmoji == emoji ? Colors.yellow : Colors.grey,
//         ),
//         child: Text(
//           emoji,
//           style: const TextStyle(fontSize: 30.0),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/users.dart';

class ProductRatingPage extends StatefulWidget {
  const ProductRatingPage({
    super.key,
    required this.jsonDta,
  });
  final Map jsonDta;

  @override
  State<ProductRatingPage> createState() => _ProductRatingPageState();
}

class _ProductRatingPageState extends State<ProductRatingPage> {
  // final TextEditingController _commentController = TextEditingController();
  late int _selectedRating = 0;
  late String _selectedEmoji = "";
  // late String selectedEmoji = "";

  void _submitRating(int rate) async {
    Map<String, dynamic> data = {
      "rating": rate,
      'partner_id': widget.jsonDta["partner_id"],
      'command_id': widget.jsonDta["command_id"],
    };
    Map<String, dynamic> response = await UserService.rateBox(data);
    if (response['status'] == 200) {
      Get.snackbar("success".tr, response['message']);
      Get.offAllNamed("main");
    }
  }

  Widget _buildEmojiButton(String emoji, int rate) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRating = rate;
          _selectedEmoji = emoji;
        });
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedEmoji == emoji ? Colors.green.shade800 : Colors.grey,
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmojiButton('😍', 1),
              const SizedBox(width: 10),
              _buildEmojiButton('😐', 2),
              const SizedBox(width: 10),
              _buildEmojiButton('😞', 3),
            ],
          ),
          const SizedBox(height: 16.0),
          // TextField(
          //   controller: _commentController,
          //   decoration: const InputDecoration(
          //     labelText: 'Comment',
          //   ),
          // ),
          const SizedBox(height: 30),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    _submitRating(_selectedRating);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(360, 40),
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.green.shade800, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  // onPressed: () => Get.offAllNamed("main"),
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(360, 40),
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.red, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
