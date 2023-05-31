import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRatingPage extends StatefulWidget {
  const ProductRatingPage({super.key});

  @override
  PartnerRatingPageState createState() => PartnerRatingPageState();
}

class PartnerRatingPageState extends State<ProductRatingPage> {
  late TextEditingController _ratingController;
  late int _selectedRating;
  final String _productId = "your_product_id";

  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController();
    _selectedRating = 0;
  }

  @override
  void dispose() {
    _ratingController.dispose();
    super.dispose();
  }

  void _submitRating() async {
    const String apiUrl = "http://your-api-url.com/api/ratings";

    final Map<String, dynamic> requestData = {
      "product_id": _productId,
      "rating": _selectedRating.toString(),
      "comment": _ratingController.text,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: requestData,
    );

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // Rating submitted successfully
      print(responseData);
    } else {
      // Rating submission failed
      print(responseData['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Rating'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Rate the product:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRatingButton(1),
                _buildRatingButton(2),
                _buildRatingButton(3),
                _buildRatingButton(4),
                _buildRatingButton(5),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Comment',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitRating,
              child: const Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton(int rating) {
    return IconButton(
      onPressed: () {
        setState(() {
          _selectedRating = rating;
        });
      },
      icon: Icon(
        Icons.star,
        color: rating <= _selectedRating ? Colors.yellow : Colors.grey,
      ),
    );
  }
}
