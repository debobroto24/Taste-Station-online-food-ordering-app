import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/card_model.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/route_helper/add_card_argument.dart';
import 'package:food_app/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:food_app/screens/check_out/payment_summary/all_cards.dart';
// import 'package:food_app/screens/check_out/payment_summary/select_card.dart';
import 'package:food_app/screens/check_out/payment_summary/my_google_pay.dart';
import 'package:food_app/screens/check_out/payment_summary/order_item.dart';
import 'package:food_app/screens/check_out/payment_summary/payment_successful.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_order/my_order.dart';
import 'package:food_app/widgets/payment_box.dart';
import 'package:provider/provider.dart';

import '../../../route_helper/all_card_argument.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  PaymentSummary({this.deliverAddressList});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
  Visa,
  // Stripe,
  Cashon,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  // ProductOrderProvider productOrderProvider;

  var myType = AddressTypes.Home;
  ProductOrderProvider orderProvider;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    orderProvider = Provider.of<ProductOrderProvider>(context);

    double discount = 30;
    double discountValue = 22;
    double shippingChanrge = 3.7;
    double total;
    // List<ReviewCartModel> ff =  reviewCartProvider.getReviewCartDataList;
    double totalPrice = reviewCartProvider.getTotalPrice();

    // List<CardModel>  cardList = orderProvider.getCardList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "${total ?? totalPrice} ৳",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () async {
              if (myType == AddressTypes.Visa) {
                
                      await orderProvider.getAllCard("visa");

                List<CardModel> cardlist = await orderProvider.getCardList;
                print("lengeth ${cardlist.length}");
                // if (cardlist.length > 0) {
                // await Navigator.of(context).pushNamed(
                //   '/allcards',
                //   arguments: cardlist,
                // );

                Navigator.of(context).pushNamed("/allcards",
                    arguments: AllCardArgument(
                        cardlist: cardlist, accountType: "visa"));
              } 
              // else if (myType == AddressTypes.Stripe) {
              //   await orderProvider.getAllCard("stripe");
              //   List<CardModel> cardlist = await orderProvider.getCardList;
              //   print("lengeth ${cardlist.length}");
              //   // if (cardlist.length > 0) {
              //   // await Navigator.of(context).pushNamed(
              //   //   '/allcards',
              //   //   arguments: cardlist,
              //   // );

              //   Navigator.of(context).pushNamed("/allcards",
              //       arguments: AllCardArgument(
              //           cardlist: cardlist, accountType: "visa"));
              //   //  print("visa");
              // }
              
               else if (myType == AddressTypes.Cashon) {
                orderProvider.addOrder("cashon", "no number");
                EasyLoading.showToast(
                  'Processing...',
                  dismissOnTap: true,
                  duration: Duration(seconds: 4),
                );

                await Future.delayed(Duration(seconds: 4), () {});
                // Navigator.of(context).pushNamed("/paymentsuccessful");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PaymentSuccessful(isCashOn: true)));
              } else {
                Fluttertoast.showToast(
                  msg: "Please select payment option!",
                );
              }
            },
            // child: orderProvider.isCardLoaded
            //     ? CircularProgressIndicator()
            //     : Text(
            //         "Place Order",
            //         style: TextStyle(
            //           color: textColor,
            //         ),
            //       ),
            child: Text(
              "Place Order",
              style: TextStyle(
                color: textColor,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  // address:
                  //     "aera, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society ${widget.deliverAddressList.scoirty}, pincode ${widget.deliverAddressList.pinCode}",

                  address:
                      "${widget.deliverAddressList.district}, ${widget.deliverAddressList.city}, ${widget.deliverAddressList.area}, ${widget.deliverAddressList.street}}",
                  title: " ",
                  number: widget.deliverAddressList.mobileNo,
                  addressType: widget.deliverAddressList.addressType ==
                          "AddressTypes.Home"
                      ? "Home"
                      : widget.deliverAddressList.addressType ==
                              "AddressTypes.Other"
                          ? "Other"
                          : "Work",
                ),
                Divider(),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                  title: Text(
                      "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "${totalPrice + 5} ৳",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "$discountValue ৳",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ListTile(
                //   minVerticalPadding: 5,
                //   leading: Text(
                //     "Compen Discount",
                //     style: TextStyle(color: Colors.grey[600]),
                //   ),
                //   trailing: Text(
                //     "10 ৳",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Divider(),
                ListTile(
                  leading: Padding(
                      padding: EdgeInsets.only(bottom: 17, top: 15),
                      child: Text(
                        "Payment Options",
                        style: TextStyle(fontSize: 20),
                      )),
                ),

                RadioListTile(
                  activeColor: Colors.deepOrange,
                  value: AddressTypes.Visa,
                  groupValue: myType,
                  title: PaymentBox(
                      paymentOption: "Visa", image: "assets/visa.png"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                // RadioListTile(
                //   activeColor: Colors.deepOrange,
                //   value: AddressTypes.Stripe,
                //   groupValue: myType,
                //   title: PaymentBox(
                //       paymentOption: "Stripe", image: "assets/stripe.png"),
                //   onChanged: (AddressTypes value) {
                //     setState(() {
                //       myType = value;
                //     });
                //   },
                // ),
                SizedBox(height: 15),
                RadioListTile(
                  activeColor: Colors.deepOrange,
                  value: AddressTypes.Cashon,
                  groupValue: myType,
                  title: PaymentBox(
                      paymentOption: "CashOn Delivery",
                      image: "assets/cashon.png"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
