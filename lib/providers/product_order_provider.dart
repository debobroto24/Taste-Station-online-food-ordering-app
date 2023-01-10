import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_app/models/order_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/review_cart_model.dart';

class ProductOrderProvider with ChangeNotifier {
  Future<void> addOrderProduct() async {
    QuerySnapshot allItem = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .get();

    allItem.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection("OrderCart")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("allOrders")
          .doc(element.get("cartId"))
          .set({
        "cartId": element.get("cartId"),
        "cartName": element.get("cartName"),
        "cartImage": element.get("cartImage"),
        "cartPrice": element.get("cartPrice"),
        "cartQuantity": element.get("cartQuantity"),
        "cartUnit": element.get("cartUnit"),
        "cartQuantity": element.get("cartQuantity"),
        "isAdd": true,
        "dateTime": DateTime.now(),
      });
      allItem.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("ReviewCart")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("YourReviewCart")
            .doc(element.get("cartId"))
            .delete();
      });
      notifyListeners();
    });
  }

  List<OrderCartModel> get getOrderList => orderList;
  Map<String, List<OrderCartModel>> OrderMap = {};
  Map<String, List<OrderCartModel>> get getOrderMap => OrderMap;

  List<OrderCartModel> orderList = [];
  bool isLoading = false;
  bool get getIsLoading => isLoading;

  // test fetch
  Future<void> fetchOrderList() async {
    // List<ReviewCartModel> newList = [] ;
    // print("0000000000000000000");
    //  print("fetch order list");

    DocumentSnapshot docKey = await FirebaseFirestore.instance
        .collection("OrderList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("DocKey")
        .doc("DocKey")
        .get();
    List<OrderCartModel> singleOrderList = [];
    Map<String, List<OrderCartModel>> orderListMap = {};
    try {
      isLoading = true;
      List<dynamic> val = docKey.get("list");
      for (int i = 0; i < val.length; i++) {
        QuerySnapshot allorders = await FirebaseFirestore.instance
            .collection("OrderList")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("YourOrder")
            .doc(val[i].toString())
            .collection(val[i].toString())
            .get();
        // print working
        // print("doc length");
        // print(allorders.docs.length);
        singleOrderList = [];
        allorders.docs.forEach((element) {
          OrderCartModel data = OrderCartModel(
            cartId: element.get("cartId"),
            cartImage: element.get("cartImage"),
            cartName: element.get("cartName"),
            cartPrice: element.get("cartPrice"),
            cartQuantity: element.get("cartQuantity"),
            cartUnit: element.get("cartUnit"),
            dateTime: element.get("dateTime"),
            totalPrice: element.get("totalPrice"),
            totalproduct: element.get("totalProduct"),
          );
          singleOrderList.add(data);
        }); // end of foreach

        orderListMap.putIfAbsent(val[i].toString(), () {
          return singleOrderList;
        });
      } // end of for loop
    } catch (e) {
      // isLoading = false;
    }

    // print working
    // print("map key");
    // orderListMap.forEach((key, value) {
    //   print("-----start ======");
    //   print("map key is ${key}");
    //   value.forEach((element) {
    //     print(element.cartName);
    //   });
    //   print("------end---------");
    // });

    // print("xxxxxxxxxxx");
    // print("end fetch order list");

    OrderMap = orderListMap;
    notifyListeners();
    // isLoading = false;
  } // fetchorderlist end

  addOrder(String cashcheck) async {
    //  DocumentSnapshot tvalue = await FirebaseFirestore.instance.collection("OrderCart").doc(FirebaseAuth.instance.currentUser.uid).get();
    //  tvalue.get("allOrders");
    //  print( tvalue.get("allOrders").);
    //  print("all test here");
    //  print(tvalue.data());
    List<OrderCartModel> order = [];
    try {
      isLoading = true;
      QuerySnapshot allItem = await FirebaseFirestore.instance
          .collection("ReviewCart")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("YourReviewCart")
          .get();
      double totalPrice = 0;
      int totalProduct = 0;
      allItem.docs.forEach((element) {
        totalPrice += element.get("cartPrice");
        totalProduct += element.get("cartQuantity");
      });

      DateTime dt = DateTime.now();
      int day = dt.day;
      int month = dt.month;
      int year = dt.year;
      int hour = dt.hour;
      int min = dt.minute;
      String docKey =
          "${day.toString()}${month.toString()}${year.toString()}${hour.toString()}${min.toString()}";
      String SdocKey = docKey.toString();
      DocumentSnapshot docExits = await FirebaseFirestore.instance
          .collection('OrderList')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("DocKey")
          .doc("DocKey")
          .get();
      FirebaseFirestore.instance
          .collection('PaymentDetails')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'totalAmount': totalPrice,
        'totalProduct': totalProduct,
        'dateTime': DateTime.now(),
        'orderDocKey': docKey,
        'paymentgetway': cashcheck,
      });

      QuerySnapshot isUserSetInOrderList =
          await FirebaseFirestore.instance.collection("OrderList").get();
      if (docExits.exists) {
        print("doc alwready set");
        print(isUserSetInOrderList.docs.isEmpty);

        await FirebaseFirestore.instance
            .collection('OrderList')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("DocKey")
            .doc("DocKey")
            .update({
          'list': FieldValue.arrayUnion([SdocKey]),
        });
      } else {
        print("doc is not set");
        await FirebaseFirestore.instance
            .collection('OrderList')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("DocKey")
            .doc("DocKey")
            .set({
          'list': FieldValue.arrayUnion([SdocKey]),
        });
      }

      allItem.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("OrderList")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("YourOrder")
            .doc(docKey)
            .collection(docKey)
            .doc(element.get("cartId"))
            .set({
          "cartId": element.get("cartId"),
          "productId": element.get("cartId"),
          "cartName": element.get("cartName"),
          "cartImage": element.get("cartImage"),
          "cartPrice": element.get("cartPrice"),
          "cartQuantity": element.get("cartQuantity"),
          "cartUnit": element.get("cartUnit"),
          "isAdd": true,
          "totalPrice": totalPrice,
          "totalProduct": totalProduct,
          // "rate": element.get("rate"),
          "dateTime": DateTime.now(),
        });
        allItem.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("ReviewCart")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection("YourReviewCart")
              .doc(element.get("cartId"))
              .delete();
        });
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
    }
    isLoading = false;
  }

  bool rateLoaded = false; 
  bool get getRateLoaded => rateLoaded; 
  Future<void> setUserRating(String productId, double rate) async {
    rateLoaded = false; 
    print("im called");
    FirebaseFirestore.instance
        .collection('userrating')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('product')
        .doc(productId)
        .set({'rate': rate}).then((value) => print("worked"));
    notifyListeners();

  }
   List<double> rateList = [];
    List<double> get getRateList => rateList;
  Future<void> getUserRating(List<String> productId) async {
     rateList = [];
     double norate = 0; 
    productId.forEach((element) async {
      

     DocumentSnapshot rate =   await FirebaseFirestore.instance
          .collection('userrating')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('product')
          .doc(element)
          .get();
        if(rate.exists){
          rateList.add(rate['rate']); 
        }  else{
          rateList.add(norate);
        }
    });
    print("ratelist in provider: ${rateList.length}");
    // notifyListeners();
    return rateList; 
  }
}
