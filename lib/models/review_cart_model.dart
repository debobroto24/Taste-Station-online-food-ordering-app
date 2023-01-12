import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewCartModel {
  String cartId;
  String cartImage;
  String cartName;
  int cartPrice;
  int cartQuantity;
  var cartUnit;
  String category; 
  Timestamp dateTime;
  ReviewCartModel({
    this.cartId,
    this.cartUnit,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.cartQuantity,
    this.dateTime,
    this.category,
  });
//  ReviewCartModel.toJson(List<ReviewCartModel> data){
//     data.forEach((element) {
//       return 
//     })
//   }
}
