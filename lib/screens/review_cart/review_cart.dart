import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/check_out/delivery_details/delivery_details.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  ReviewCartProvider reviewCartProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
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
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "৳ ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text(
              "Place Order",
              style: TextStyle(color: Colors.white),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () {
              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                return Fluttertoast.showToast(msg: "No Cart Data Found");
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryDetails(),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Review Cart",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getIsLoading
          ? Center(child: CircularProgressIndicator())
          : reviewCartProvider.getReviewCartDataList.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    // width:MediaQuery.of(context).size.width
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Image.asset(
                            'assets/empty_cart.gif',
                            width: 200,
                            height: 200,
                            scale: .2,
                          ),
                        ),
                        Text(
                          "Opps! Your cart is empty",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: reviewCartProvider.getReviewCartDataList.length,
                  itemBuilder: (context, index) {
                    ReviewCartModel data =
                        reviewCartProvider.getReviewCartDataList[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SingleItem(
                          isBool: true,
                          wishList: false,
                          productImage: data.cartImage,
                          productName: data.cartName,
                          productPrice: data.cartPrice,
                          productId: data.cartId,
                          productQuantity: data.cartQuantity,
                          productUnit: data.cartUnit,
                          onDelete: () {
                            showAlertDialog(context, data);
                          },
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}
