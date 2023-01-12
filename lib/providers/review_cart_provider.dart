import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  bool isLoading = true;
  bool get getIsLoading => isLoading;
  void addReviewCartData({
    String cartId,
    String cartName,
    String cartImage,
    int cartPrice,
    int cartQuantity,
    var cartUnit,
    String category, 
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        "isAdd": true,
        "dateTime": DateTime.now(),
        "category": category, 
      },
    );
  }

  void updateReviewCartData({
    String cartId,
    String cartName,
    String cartImage,
    int cartPrice,
    int cartQuantity,
    String category, 
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
        "dateTime": DateTime.now(),
        "category": category, 
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    // print('inside getReviewCartData');
    try {
      QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
          .collection("ReviewCart")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("YourReviewCart")
          .get();
      reviewCartValue.docs.forEach((element) {
        ReviewCartModel reviewCartModel = ReviewCartModel(
          cartId: element.get("cartId"),
          cartImage: element.get("cartImage"),
          cartName: element.get("cartName"),
          cartPrice: element.get("cartPrice"),
          cartQuantity: element.get("cartQuantity"),
          cartUnit: element.get("cartUnit"),
          // dateTime:  element.get("dateTime"),
        );
        newList.add(reviewCartModel);
      });
    } catch (e) {
      isLoading = false;
    }
    reviewCartDataList = newList;
    notifyListeners();
    isLoading = false;
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

//// TotalPrice  ///

  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }

////////////// ReviCartDeleteFunction ////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }
}
