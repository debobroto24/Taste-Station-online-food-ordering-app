import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCartModel {
  String cartId;
  String productId; 
  String cartImage;
  String cartName;
  int cartPrice;
  int cartQuantity;
  int totalproduct; 
  double totalPrice; 
  var cartUnit;
  // double rate; 
 Timestamp dateTime;
  OrderCartModel({
    this.cartId,
    this.productId, 
    this.cartUnit,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.cartQuantity,
    this.totalPrice, 
    this.totalproduct,
    this.dateTime, 
    // this.rate,
  });
}