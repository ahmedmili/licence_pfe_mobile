import 'dart:convert';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Models/partner.dart';
// import '../widget/rating.dart';
import 'globals.dart';

final GlobalController controller = Get.find<GlobalController>();

class UserService {
  static Future<List<Box>> getRecommandedBoxs() async {
    final token = controller.token;

    // check for favorits partners
    final favorsurl = Uri.parse('${baseURL}user/partners/favorites');
    final favorsListresponse = await http.get(
      favorsurl,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    final favorsData = jsonDecode(favorsListresponse.body);

    if (favorsData[0].length > 0) {
      // if one or more favorits exists
      final name = favorsData[0][0]["name"];
      // get recommanded boxs from favorits partners
      final url = Uri.parse('${baseURL}user/recommandedBoxs/$name');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // fetch result into list
        List<dynamic> boxsList = jsonDecode(response.body)["boxs"];

        final List<Box> boxs = [];
        for (int i = 0; i < boxsList.length; i++) {
          final newBox = Box(
            // Add fields here to create the new Box object
            id: boxsList[i]['id'],
            description: boxsList[i]['description'],
            category: boxsList[i]['category'],
            newprice: boxsList[i]['newprice'],
            startdate: boxsList[i]['startdate'],
            enddate: boxsList[i]['enddate'],
            quantity: boxsList[i]['quantity'],
            remainingQuantity: boxsList[i]['remaining_quantity'],
            image: boxsList[i]['image'],
            partnerId: boxsList[i]['partner_id'],
            title: boxsList[i]['title'],
            oldprice: boxsList[i]['oldprice'],
          );
          boxs.add(newBox);
        }
        // return boxs list
        return boxs;
      } else {
        throw Exception('Failed to fetch products');
      }

      // no favorits partners exists
    } else {
      // get recommanded boxs from graph db
      final url = Uri.parse('${baseURL}user/graphRecommandedBoxs');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // fetch box into list
        List<dynamic> boxsList = jsonDecode(response.body)["boxs"];
        final List<Box> boxs = [];
        for (int i = 0; i < boxsList.length; i++) {
          final newBox = Box(
            // Add fields here to create the new Box object
            id: boxsList[i]['id'],
            description: boxsList[i]['description'],
            category: boxsList[i]['category'],
            newprice: boxsList[i]['newprice'],
            startdate: boxsList[i]['startdate'],
            enddate: boxsList[i]['enddate'],
            quantity: boxsList[i]['quantity'],
            remainingQuantity: boxsList[i]['remaining_quantity'],
            image: boxsList[i]['image'],
            partnerId: boxsList[i]['partner_id'],
            title: boxsList[i]['title'],
            oldprice: boxsList[i]['oldprice'],
          );
          boxs.add(newBox);
        }
        return boxs;
      } else {
        throw ("no data found");
      }
      // no graph db or favorits recommanded box exists
    }
  }

  static Future<List<Box>> getAvailableBoxs() async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/availableBoxs');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // final box = List<Box>.from(
      //   data.map((boxJson) => Box.fromJson(boxJson)),
      // );
      // print(box);
      // return box;
      final List<Box> boxs = [];

      for (int i = 0; i < data.length; i++) {
        final newBox = Box(
          // Add fields here to create the new Box object
          id: data[i]['id'],
          description: data[i]['description'],
          category: data[i]['category'],
          newprice: data[i]['newprice'],
          startdate: data[i]['startdate'],
          enddate: data[i]['enddate'],
          quantity: data[i]['quantity'],
          remainingQuantity: data[i]['remaining_quantity'],
          image: data[i]['image'],
          partnerId: data[i]['partner_id'],
          title: data[i]['title'],
          oldprice: data[i]['oldprice'],
        );
        boxs.add(newBox);
      }
      return boxs;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<List<Box>> getAvailableBoxsByCategorys(category) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/indexByCategory/$category');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['boxs'];
      final box = List<Box>.from(
        data.map((boxJson) => Box.fromJson(boxJson)),
      );

      return box;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<List<Box>> getAvailableBoxsByPartnerCategorys(
      partnercategory) async {
    final token = controller.token;
    final url =
        Uri.parse('${baseURL}user/indexByPartnerCategory/$partnercategory');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['boxs'];
      final box = List<Box>.from(
        data.map((boxJson) => Box.fromJson(boxJson)),
      );

      return box;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  //filter price :
  static Future<List<Box>> filterPrice(double min, double max) async {
    final token = controller.token;

    final url = Uri.parse('${baseURL}user/filterprice/?min=$min&max=$max');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      //body: json.encode({'min': min, 'max': max}),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['boxs'];
      final box = List<Box>.from(
        data.map((boxJson) => Box.fromJson(boxJson)),
      );

      return box;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<Partner> getBoxPartnerInfo(int id) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/boxs/boxdetails/$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final boxPartner = Partner.fromJson(data);

      return boxPartner;
    } else {
      throw Exception('Failed to fetch box partner info');
    }
  }

  static Future<String> likeOrDislikeBox(id) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/boxs/$id/likes');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final String message = data["message"];
      return message;
    } else {
      throw Exception('Failed to fetch like and dislike data');
    }
  }

  static Future<List<Box>> favorsBoxs() async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/boxs/favorites');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)[0];
      final List<Box> box = [];
      for (int i = 0; i < data.length; i++) {
        final newBox = Box(
          // Add fields here to create the new Box object
          id: data[i]['id'],
          description: data[i]['description'],
          category: data[i]['category'],
          newprice: data[i]['newprice'],
          startdate: data[i]['startdate'],
          enddate: data[i]['enddate'],
          quantity: data[i]['quantity'],
          remainingQuantity: data[i]['remaining_quantity'],
          image: data[i]['image'],
          partnerId: data[i]['partner_id'],
          title: data[i]['title'],
          oldprice: data[i]['oldprice'],
        );
        box.add(newBox);
      }
      return box;
    } else {
      throw Exception('Failed to fetch  favorites data');
    }
  }

  static Future<String> likeOrDislikePartner(id) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/partners/$id/likes');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final String message = data["message"];
      return message;
    } else {
      throw Exception('Failed to fetch like and dislike data');
    }
  }

//Fav Partners
  static Future<List<Partner>> favorsPartners() async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}user/partners/favorites');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)[0];
      final List<Partner> partner = [];
      for (int i = 0; i < data.length; i++) {
        final newPartner = Partner(
          // Add fields here to create the new Box object
          id: data[i]['id'],
          description: data[i]['description'],
          category: data[i]['category'],
          name: data[i]['name'],
          email: data[i]['email'],
          phone: data[i]['phone'],
          image: data[i]['image'],
          openingtime: data[i]['openingtime'],
          closingtime: data[i]['closingtime'],
          long: data[i]['long'],
          lat: data[i]['lat'],
          adress: data[i]['adress'],
        );
        partner.add(newPartner);
      }
      return partner;
    } else {
      throw Exception('Failed to fetch favors partners data');
    }
  }

//QrCode verification
  static Future<Map<String, dynamic>> verifAndTakeOrder(
      Map<String, dynamic> data) async {
    final token = controller.token;

    final url = Uri.parse('${baseURL}user/orders/verif');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = {
        "status": jsonDecode(response.body)["status"],
        "message": jsonDecode(response.body)["message"],
      };

      return responseData;
    } else {
      throw Exception('Failed to verif QrCode');
    }
  }

// rate partner
  static Future<Map<String, dynamic>> rateBox(Map<String, dynamic> data) async {
    final token = controller.token;

    final url = Uri.parse('${baseURL}user/RatePartner');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = {
        "status": jsonDecode(response.body)['status'],
        "message": jsonDecode(response.body)['message'],
      };
      return responseData;
    } else {
      throw Exception('Failed to rate partner');
    }
  }

  static Future<List<dynamic>> getNearByPartners(
    double long,
    double lat,
    double dist, {
    String? unity = "km",
  }) async {
    final token = controller.token;

    final url =
        Uri.parse('${baseURL}user/getNearbyPartners/$lat&$long&$dist&$unity');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data["partnerList"];
    } else {
      throw Exception('Failed to  data');
    }
  }

  static Future<Map<String, dynamic>> getUserStats() async {
    final token = controller.token;

    final url = Uri.parse('${baseURL}user/userStats');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to  data');
    }
  }
}
