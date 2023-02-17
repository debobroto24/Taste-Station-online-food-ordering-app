import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  String productName;
  String productImage;
  String productId;
  int productPrice;
  var productUnit;
  String category;
  // String category;

  Count({
    this.productName,
    this.productUnit,
    this.productId,
    this.productImage,
    this.productPrice,
    this.category,
  });
  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    //  print("check in count :category is : ${widget.category}");

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 40,
      width: 120,
      // width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTrue == true
          // product overview design
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                    } else if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                        category: widget.category,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    // height: 25,
                    //  width: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "$count",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffd0b84c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                      category: widget.category,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    // height: 25,
                    //  width: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isTrue = true;
                });
                reviewCartProvider.addReviewCartData(
                  cartId: widget.productId,
                  cartImage: widget.productImage,
                  cartName: widget.productName,
                  cartPrice: widget.productPrice,
                  cartQuantity: count,
                  cartUnit: widget.productUnit,
                  category: widget.category,
                );
              },
              child: Container(
                height: 40,
                width: 120,

                // width: double.infinity,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //   borderRadius: BorderRadius.circular(8),
                // ),
                child: Center(
                  // review vart design

                  child: Text(
                    "ADD",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ),
    );
  }
}
