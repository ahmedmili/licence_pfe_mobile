import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/dimensions.dart';

class OrderCardPartner extends StatefulWidget {
  OrderCardPartner({
    super.key,
    required this.order,
  });

  Order order;

  @override
  State<OrderCardPartner> createState() => _OrderCardPartnerState();
}

class _OrderCardPartnerState extends State<OrderCardPartner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(0, 0),
              blurRadius: 10.0,
              spreadRadius: 1.0),
          const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 10.0,
              spreadRadius: 1.0),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: Dimensions.height70 * 3,
              width: Dimensions.width40 * 8,
              child: Image.network(
                "http://$localhost:8000/storage/boxs_imgs/${widget.order.box_image}",
                fit: BoxFit.cover,
                height: Dimensions.height50 * 3,
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 110.0,
                width: Dimensions.width40 * 8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: Dimensions.width10,
              bottom: Dimensions.height10 / 2,
              right: Dimensions.width10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.order.box_name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: <Widget>[
                          Text(
                            '${widget.order.oldprice} Dt',
                            style: TextStyle(
                              fontSize: Dimensions.font18,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '${widget.order.newprice} Dt',
                            style: TextStyle(
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: Dimensions.width20 * 10),
                            child: Text(
                              widget.order.user_name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.font18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.order.user_phone.toString()}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.phone, color: Colors.green[800]),
                    ],
                  ),
                ],
              ),
            ),

            //quantity
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10 / 2, top: Dimensions.height10 / 2),
              height: Dimensions.height30,
              width: Dimensions.width70 * 2,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(6, 6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
              ),
              child: Center(
                child: Text(
                  'Stay ${widget.order.remaining_quantity.toString()} to save',
                  style: TextStyle(
                    fontSize: Dimensions.font18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
