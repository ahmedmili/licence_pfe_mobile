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

class ProductRatingPage extends StatelessWidget {
  final TextEditingController _commentController = TextEditingController();
  var arguments = Get.arguments; // Access the arguments passed

  // final String _productId = "your_product_id";

  ProductRatingPage({super.key});
  late String selectedEmoji = "";

  void _submitRating(String emoji) async {
    // final String apiUrl = "http://your-api-url.com/api/ratings";

    // final Map<String, dynamic> requestData = {
    //   "product_id": _productId,
    //   "emoji": emoji,
    //   "comment": _commentController.text,
    // };

    // final http.Response response = await http.post(
    //   Uri.parse(apiUrl),
    //   body: requestData,
    // );

    // final Map<String, dynamic> responseData = json.decode(response.body);

    // if (response.statusCode == 200) {
    //   // Rating submitted successfully
    //   print(responseData);
    //   Get.back();
    // } else {
    //   // Rating submission failed
    //   print(responseData['error']);
    // }
  }

  void _showRatingPopup(BuildContext context) {
    print(arguments["partner_id"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rate the product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmojiButton('😍'),
                _buildEmojiButton('😐'),
                _buildEmojiButton('😞'),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_commentController.text.isNotEmpty) {
                _submitRating(selectedEmoji);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiButton(String emoji) {
    return InkWell(
      onTap: () {
        Get.back(result: emoji);
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Rating'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showRatingPopup(context),
          child: const Text('Rate the Product'),
        ),
      ),
    );
  }
}
