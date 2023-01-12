import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/models/order_cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/widgets/rating_bar.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  final List<OrderCartModel> orderDetails;
  OrderDetails({Key key, this.orderDetails}) : super(key: key);

  List<String> productIdList = [];

  @override
  Widget build(BuildContext context) {
    // print(widget.orderDetails.map((e) => e.cartId));
    // productIdList = ['aaa','ddd'];
    int i = 0;
    Timestamp dateTime;
    orderDetails.forEach((element) {
      // print(element.cartName);
      if (i == 0) {
        dateTime = element.dateTime;
        i = i + 4;
      }
      productIdList.add(element.cartId);
    });

    // in set review cart product id and cart id is same
    ProductOrderProvider productOrderProvider;
    productOrderProvider = Provider.of<ProductOrderProvider>(context);
    //  productOrderProvider.getUserRating(productIdList);
    //  List<double> rateList = productOrderProvider.getRateList;
    //  print(rateList.length);
    //  rateList.forEach((e)=>print('rate is : ${e}')); 
    return Scaffold(
      appBar: AppBar(title: Text("order ")),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * .7,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: orderDetails.map((e) {
                  return Container(
                    width: double.maxFinite,
                    height: 80,
                    // color: Colors.red,
                    margin: EdgeInsets.only(left: 10, right: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              margin: EdgeInsets.only(right: 10),
                              child: Image.network(
                                e.cartImage??'assets/online-food-app.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:120, 
                                  child: Text(e.cartName??'name',maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                SizedBox(height: 5),
                                Text(e.cartPrice.toString()??'price')
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // FoodRatingBar(initialRating: 3.4,minRating:0,size:20),
                              // RatingBarIndicator(
                              //   rating: 2,
                              //   itemBuilder: (context, index) => Icon(
                              //     Icons.star,
                              //     color: Colors.amber,
                              //   ),
                              //   itemCount: 5,
                              //   itemSize: 25.0,
                              //   direction: Axis.horizontal,
                              // ),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // print(rating);
                                  // productOrderProvider.setUserRating(e.cartId, rating,e.category);
                                  print("----start------------"); 
                                  print(e.category); 
                                  print(e.productId); 
                                  print("-----end-------"); 
                                },
                                // ),
                              ),
                              Container(
                                child: productOrderProvider.getRateLoaded
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text("Add Feedback"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                width: double.maxFinite,
                height: 140,
              ))
        ],
      ),
    );
  }
}
