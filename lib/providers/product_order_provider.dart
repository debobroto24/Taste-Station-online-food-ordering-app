import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_app/models/card_model.dart';
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
              category: element.get('category'),
              docKey: element.get('docKey'));
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
    isLoading = false;
    OrderMap = orderListMap;
    notifyListeners();
    // isLoading = false;
  } // fetchorderlist end

  Future<void> addOrder(String cashcheck, cardNumber) async {
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
        'cardNumber': cardNumber,
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
          "category": element.get("category"),
          "isAdd": true,
          "totalPrice": totalPrice,
          "totalProduct": totalProduct,
          "docKey": docKey,
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

  Future<void> addCardNumber(String cardNumber, String holderName,
      String expireDate, String accountType) async {
    try {
      await FirebaseFirestore.instance
          .collection('cardNumber')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("accounts")
          .doc(cardNumber)
          .set({
        "holderName": holderName,
        "cardNumber": cardNumber,
        "expireDate": expireDate,
        "accountType": accountType,
      });
    } catch (e) {}
    notifyListeners();
  }

  List<CardModel> cardList = [];
  List<CardModel> get getCardList => cardList;
  bool isCardLoaded = false;

 Future<void> deleteCardData(cardId){
       FirebaseFirestore.instance
        .collection("cardNumber")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("accounts")
        .doc(cardId)
        .delete();
    notifyListeners();
  }

  Future<void> getAllCard(String cardtype) async {
    cardList = [];
    try {
      cardList = [];
      isCardLoaded = true;
      QuerySnapshot data = await FirebaseFirestore.instance
          .collection("cardNumber")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("accounts")
          .where("accountType", isEqualTo: cardtype)
          .get();
      // print(data); 
      // print(cardtype);
      // print(data.docs.length);
      data.docs.forEach((element) {
        CardModel cd = CardModel(
          accountType: element.get('accountType'),
          cardNumber: element.get('cardNumber'),
          expireDate: element.get('expireDate'),
          holderName: element.get('holderName'),
        );
        cardList.add(cd);
      });
      // print(data.docs.length);
      // print("getallcard ${cardList.length}");
      //  print();
       notifyListeners();
    } catch (e) {}
    notifyListeners();
  }

  bool isDone = false;
  bool get getIsDone => isDone;
  Future<void> setUserRating(
      String productId, double rate, String category, String dockey) async {
    print(productId);
    print(rate);
    print(category);
    print(dockey);
    print("productid ${productId}");
    print("rate ${rate}");
    print("category ${category}");
    rateLoaded = true;
    try {
      isDone = true;
      FirebaseFirestore.instance
          .collection('userrating')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('product')
          .doc(dockey)
          .collection(dockey)
          .doc(productId)
          .set({'rate': rate, 'productId': productId}).then((value) {
        rateIs = rate;
        rateExist = true;
        print("user rate is set");
      });
      DocumentSnapshot rateData = await FirebaseFirestore.instance
          .collection(category)
          .doc(productId)
          .get();
      rateExist = true;
      QuerySnapshot collection =
          await FirebaseFirestore.instance.collection(category).get();
      print(collection.docs.length);
      double rateNumber = 0;
      int totalRate = 0;
      double updateRate;

      collection.docs.forEach((e) {
        if (e.get('productId') == productId) {
          print("hello");
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

    print('--------------');
    rateLoaded = false;
    notifyListeners();
  }

  // List<double> rateList = [];
  // List<double> get getRateList => rateList;

  bool rateExist = false;
  double rateIs = 0;
  bool get getRateExist => rateExist;
  double get getRateIs => rateIs;
  String Pid;
  String get getPid => Pid;
  Future<void> getUserRating(String productId, String docKey) async {
    try {
      print("getUserRating called");
      // rateExist = false;

      double singleRate = 0;
      double norate = 0;

      bool rateExist = false;
      DocumentSnapshot rate = await FirebaseFirestore.instance
          .collection('userrating')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('product')
          .doc(docKey)
          .collection(docKey)
          .doc(productId)
          .get();
      print("rate exist is : ${rate.exists}");

      print("single rate is : ${singleRate + 10}");
      if (rate.exists) {
        Pid = productId;
        rateExist = true;
        rateIs = rate['rate'];
        print("rate is true inside if: ${rate['rate']}");
        // return;
        // return rate['rate'];
        // print("id : ${element} rate: ${rate['rate']}");
      } else {
        Pid = "nopid";
        rateExist = false;
        rateIs = 0.0;
        print("rate is false inside if: ${rate['rate']}");
        // return;
        // print("rate is false inside if");
        // rateList.add(norate);
      }
    } catch (e) {}
    notifyListeners();
  }
  // Future<void> getUserRating(List<String> productId) async {
  //   rateList = [];
  //   //  print("product id list in provider ");
  //   // print(productId);
  //   // print("product id list in provider end ");
  //   double singleRate = 0 ;
  //   double norate = 0;
  //   productId.forEach((element) async {
  //         // DocumentSnapshot rate = await FirebaseFirestore.instance
  //         // .collection('userrating')
  //         // .doc(FirebaseAuth.instance.currentUser.uid)
  //         // .collection('product')
  //         // .doc(element)
  //         // .get();
  //     DocumentSnapshot rate = await FirebaseFirestore.instance
  //         .collection('userrating')
  //         .doc(FirebaseAuth.instance.currentUser.uid)
  //         .collection('product')
  //         .doc(element)
  //         .get();
  //         print("rate exist is : ${rate.exists}");

  //         // print("single rate is : ${singleRate+10}");
  //     if (rate.exists) {
  //       rateList.add(singleRate);
  //         singleRate = rate['rate'];
  //         rateList.add(singleRate);
  //       print("rate is true inside if");
  //       // print("id : ${element} rate: ${rate['rate']}");
  //     } else {
  //        print("rate is true inside if");
  //       rateList.add(norate);
  //     }
  //   });
  //   print("rate list is");
  //   print(rateList);
  //   print("ratelist in provider: ${rateList.length}");
  //   // notifyListeners();
  //   //  notifyListeners();
  //   return rateList;
  // }
}
