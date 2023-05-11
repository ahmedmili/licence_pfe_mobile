import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';

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
              height: 210.0,
              width: 320.0,
              child: Image.network(
                "http://192.168.100.34:8000/storage/boxs_imgs/${widget.order.box_image}",
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 110.0,
                width: 320.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
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
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
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
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '${widget.order.newprice} Dt',
                            style: TextStyle(
                              fontSize: 18,
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
                            padding: const EdgeInsets.only(right: 220),
                            child: Text(
                              widget.order.user_name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.order.user_phone.toString()}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
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
              margin: const EdgeInsets.only(left: 5, top: 5),
              height: 30,
              width: 130,
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
                    fontSize: 18,
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
