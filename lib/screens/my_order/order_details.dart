import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/order_cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/screens/my_order/rate_product.dart';
import 'package:food_app/widgets/rating_bar.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final List<OrderCartModel> orderDetails;
  OrderDetails({Key key, this.orderDetails}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  ProductOrderProvider productOrderProvider;
  
  List<String> productIdList = [];

  bool rateExist = false;

  String Pid = "none";

  double rateIs = 0;
  
  @override
  Widget build(BuildContext context) {
    // print(widget.orderDetails.map((e) => e.cartId));
    // productIdList = ['aaa','ddd'];
    // --------------------------------------------
    int i = 0;
    Timestamp dateTime;
    productIdList = [];
    widget.orderDetails.forEach((element) {
      // print(element.cartName);
      if (i == 0) {
        dateTime = element.dateTime;
        i = i + 4;
      }
      productIdList.add(element.cartId);
    });
    // ------------------------------------------------------------------

    productOrderProvider =
        Provider.of<ProductOrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor, title: Text("order ")),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                height: MediaQuery.of(context).size.height * .7,
                child: ListView.builder(
                    itemCount: widget.orderDetails.length,
                    itemBuilder: (context, index) {
                      // int i = 1;
                      // if (i >= 1 && i <= 3) {
                      // productOrderProvider
                      //     .getUserRating(orderDetails[index].cartId);
                      // print(productOrderProvider.getRateIs);
                      // print(
                      //     "rating ${productOrderProvider.getRateIs} id: ${productOrderProvider.Pid}");
                      // }
                      print(
                          "product id : ${widget.orderDetails[index].cartId}  docKey id : ${widget.orderDetails[index].docKey}");
                      return Container(
                        width: double.maxFinite,
                        height: 80,
                        // color: Colors.red,
                        margin: EdgeInsets.only(left: 10, right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //     " product id : ${orderDetails[index].cartId}  docKey id : ${orderDetails[index].docKey}"),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Image.network(
                                    widget.orderDetails[index].cartImage ??
                                        'assets/online-food-app.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 120,
                                        child: Text(
                                          widget.orderDetails[index].cartName ??
                                              'name',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    SizedBox(height: 5),
                                    Text(widget.orderDetails[index]
                                            .cartPrice
                                            .toString() ??
                                        'price')
                                  ],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => RateProduct(
                                          category:
                                              widget.orderDetails[index].category,
                                          productId: widget.orderDetails[index].cartId,
                                          docKey: widget.orderDetails[index].docKey,
                                          name: widget.orderDetails[index].cartName,
                                          image: widget.orderDetails[index].cartImage,
                                          price: widget.orderDetails[index].cartPrice,
                                        )));
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "*****",
                                      style: TextStyle(color: textColor),
                                    ),
                                    Text(
                                      "Rate Food",
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   child: Column(
                            //     mainAxisSize: MainAxisSize.min,
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       // FoodRatingBar(initialRating: 3.4,minRating:0,size:20),
                            //       // RatingBarIndicator(
                            //       //   rating: 2,
                            //       //   itemBuilder: (context, index) => Icon(
                            //       //     Icons.star,
                            //       //     color: Colors.amber,
                            //       //   ),
                            //       //   itemCount: 5,
                            //       //   itemSize: 25.0,
                            //       //   direction: Axis.horizontal,
                            //       // ),
                            //       Container(
                            //         // child: productOrderProvider.getIsDone
                            //         //     ?
                            //         //  productOrderProvider.getUserRating(productIdList);
                            //         child: productOrderProvider.getRateExist
                            //             ? Text("${productOrderProvider.rateIs}",
                            //                 style:
                            //                     TextStyle(color: Colors.black))
                            //             // RatingBarIndicator(
                            //             //     rating: productOrderProvider.rateIs,
                            //             //     itemBuilder: (context, index) =>
                            //             //         Icon(
                            //             //       Icons.star,
                            //             //       color: primaryColor,
                            //             //     ),
                            //             //     itemCount: 5,
                            //             //     itemSize: 25.0,
                            //             //     direction: Axis.horizontal,
                            //             //   )
                            //             : RatingBar.builder(
                            //                 initialRating: 0,
                            //                 minRating: 0,
                            //                 itemSize: 20,
                            //                 direction: Axis.horizontal,
                            //                 allowHalfRating: true,
                            //                 itemCount: 5,
                            //                 itemPadding: EdgeInsets.symmetric(
                            //                     horizontal: 1.0),
                            //                 itemBuilder: (context, _) => Icon(
                            //                   Icons.star,
                            //                   color: Colors.amber,
                            //                 ),
                            //                 onRatingUpdate: (rating) {
                            //                   productOrderProvider
                            //                       .setUserRating(
                            //                           orderDetails[index]
                            //                               .cartId,
                            //                           rating,
                            //                           orderDetails[index]
                            //                               .category);
                            //                 },
                            //               ),
                            //       ),

                            //       Container(
                            //         child: productOrderProvider.getRateLoaded
                            //             ? Center(
                            //                 child: CircularProgressIndicator(),
                            //               )
                            //             : Text("Add Feedback"),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      );

                      i++;
                    })
                // print("=z================");

                ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // child: Container(
            //     color: Colors.red,
            //     width: double.maxFinite,
            //     height: 140,
            //     child: Column(
            //       children: [
            //         Container(
            //             child: Row(
            //           children: [
            //             Text(
            //               "Total price ${orderDetails.first.totalPrice}",
            //               style: TextStyle(color: Colors.white),
            //             )
            //           ],
            //         )),
            //         Text("Total price ${orderDetails.first.totalproduct}")
            //       ],
            //     )),
            child: Text(
              "Total price ${widget.orderDetails.first.totalPrice}",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
