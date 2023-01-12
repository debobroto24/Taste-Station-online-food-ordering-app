import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    // productModel = ProductModel(
    //   productImage: element.get("productImage"),
    //   productName: element.get("productName"),
    //   productPrice: element.get("productPrice"),
    //   productId: element.get("productId"),
    //   productUnit: element.get("productUnit"),
    // );

    productModel = ProductModel.fromDocument(element);
    // print(element.get("productPrice"));
    search.add(productModel);
  }

  /////////////// herbsProduct ///////////////////////////////
  List<ProductModel> herbsProductList = [];

  fatchHerbsProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();

    value.docs.forEach(
      (element) {
        // print("inside herbsproduct");
        // print("category is ${element.get('category')}");
        productModels(element);

        newList.add(productModel);
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

//////////////// Fresh Product ///////////////////////////////////////

  List<ProductModel> freshProductList = [];

  fatchFreshProductData() async {
    List<ProductModel> newList = [];
    // print("inside fresh product provider9999999999999999999999999999999 ");
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshProduct").get();

    // print(value.docs.length);
    value.docs.forEach(
      (element) {
        productModels(element);
        // print("this is me");
        // print(element.get("productName"));
        newList.add(productModel);
      },
    );
    //  print("inside fresh product provider9999999999999999999999999999999 ");

    freshProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }

//////////////// Root Product ///////////////////////////////////////

  List<ProductModel> rootProductList = [];

  fatchRootProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("RootProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    rootProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return rootProductList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}
