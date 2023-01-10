import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewCartModel {
  String cartId;
  String cartImage;
  String cartName;
  int cartPrice;
  int cartQuantity;
  var cartUnit;
  Timestamp dateTime;
  ReviewCartModel({
    this.cartId,
    this.cartUnit,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.cartQuantity,
    this.dateTime,
  });
//  ReviewCartModel.toJson(List<ReviewCartModel> data){
//     data.forEach((element) {
//       return 
//     })
//   }
}
