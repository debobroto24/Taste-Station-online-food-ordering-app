import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productName;
  String productImage;
  int productPrice;
  String productId;
  int productQuantity;
  double rate;
  int totalRate;
  String productDescription;
  String category; 
  List<dynamic>productUnit;
  ProductModel(
      {
      this.productQuantity,
      this.productId,
      this.productUnit,
      this.productImage,
      this.productName,
      this.productPrice,this.rate,this.totalRate,this.category, this.productDescription});

    factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      productName: doc['productName'],
      productImage: doc['productImage'],
      productPrice: doc['productPrice'],
      productId: doc['productId'],
      productUnit: doc['productUnit'],
      rate: doc['rate'],
      totalRate: doc['totalRate'],
      category: doc['category'],
      productDescription: doc['description'],
    );
  }
}
