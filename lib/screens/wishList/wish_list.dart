import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class WishLsit extends StatefulWidget {
  @override
  _WishLsitState createState() => _WishLsitState();
}

class _WishLsitState extends State<WishLsit> {
  WishListProvider wishListProvider;
  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider.deleteWishtList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Favourites Food"),
      content: Text("Are you sure to delete your Favourite Food?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishtListData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Favourites",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: wishListProvider.getWishList.length > 0
          ? ListView.builder(
              itemCount: wishListProvider.getWishList.length,
              itemBuilder: (context, index) {
                ProductModel data = wishListProvider.getWishList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleItem(
                      isBool: true,
                      productImage: data.productImage,
                      productName: data.productName,
                      productPrice: data.productPrice,
                      productId: data.productId,
                      productQuantity: data.productQuantity,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            )
          : Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                // width:MediaQuery.of(context).size.width
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Image.asset('assets/empty_favourites.png',
                          fit: BoxFit.cover),
                    ),
                    Text(
                      "Opps! Your favourite list is empty",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
