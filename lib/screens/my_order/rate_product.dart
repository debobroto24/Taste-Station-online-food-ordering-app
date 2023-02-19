import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:provider/provider.dart';

class RateProduct extends StatefulWidget {
  String productId;
  String docKey;
  String name;
  String category;
  int price;
  String image;

  RateProduct(
      {Key key,
      this.productId,
      this.docKey,
      this.name,
      this.price,
      this.image,
      this.category})
      : super(key: key);

  @override
  State<RateProduct> createState() => _RateProductState();
}

class _RateProductState extends State<RateProduct> {
  ProductOrderProvider productOrderProvider;
  bool isExist = false;
  double rateIs = 0;
//     @overrride
// initState() {         // this is called when the class is initialized or called for the first time
//   super.initState();  //  this is the material super constructor for init state to link your instance initState to the global initState context
// }

  Future<void> setUserRating(
      String productId, double rate, String category, String dockey) async {
    try {
      FirebaseFirestore.instance
          .collection('userrating')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('product')
          .doc(dockey)
          .collection(dockey)
          .doc(productId)
          .set({'rate': rate, 'productId': productId}).then((value) {
        // print("user rate is set");
        setState(() {
          isExist = true;
          rateIs = rate;
        });
      });
      DocumentSnapshot rateData = await FirebaseFirestore.instance
          .collection(category)
          .doc(productId)
          .get();

      QuerySnapshot collection =
          await FirebaseFirestore.instance.collection(category).get();
      print(collection.docs.length);
      double rateNumber = 0;
      int totalRate = 0;
      double updateRate;

      collection.docs.forEach((e) {
        if (e.get('productId') == productId) {
          // print("hello");
          rateNumber = e.get('rate');
          totalRate = e.get('totalRate');
        }
      });
      updateRate = ((rate * totalRate) + rate) / (totalRate + 1);
      FirebaseFirestore.instance.collection(category).doc(productId).update({
        "rate": updateRate,
        "totalRate": totalRate + 1,
      });
    } catch (e) {}

    // print('--------------');
  }

  Future<void> getUserRating(String productId, String docKey) async {
    // print("getUserRating called");
    setState(() {
      bool rateExist = false;
    });
    DocumentSnapshot rate = await FirebaseFirestore.instance
        .collection('userrating')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('product')
        .doc(docKey)
        .collection(docKey)
        .doc(productId)
        .get();
    // print("rate exist is : ${rate.exists}");
    if (rate.exists) {
      setState(() {
        isExist = true;
        rateIs = rate['rate'];
      });
    } else {
      setState(() {
        isExist = false;
        rateIs = 0;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRating(widget.productId, widget.docKey);
  }

  @override
  Widget build(BuildContext context) {
    // productOrderProvider =
    //     Provider.of<ProductOrderProvider>(context, listen: true);
    // productOrderProvider.getUserRating(widget.productId, widget.docKey);
    // print("${productOrderProvider.getRateIs} ratein widget");
    // print("${productOrderProvider.getRateExist} rate exist widget");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Feedback"),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.network(
                  widget.image ?? 'assets/online-food-app.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Text(widget.name,
                    style: TextStyle(color: textColor2, fontSize: 20)),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Text(widget.price.toString(),
                    style: TextStyle(color: textColor2, fontSize: 17)),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("${rateIs}/5",
                    style: TextStyle(color: textColor2, fontSize: 30)),
              ),
              SizedBox(height: 20),
              Container(
                // child: productOrderProvider.getRateExist
                child: isExist
                    ? RatingBarIndicator(
                        rating: rateIs,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        itemCount: 5,
                        itemSize: 50.0,
                        direction: Axis.horizontal,
                      )
                    : RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        itemSize: 50,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        onRatingUpdate: (rating) async {
                          // productOrderProvider.setUserRating(widget.productId,
                          //     rating, widget.category, widget.docKey);
                          await setUserRating(widget.productId, rating,
                              widget.category, widget.docKey);
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
