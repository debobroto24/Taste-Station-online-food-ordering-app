import 'package:flutter/material.dart';
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
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_order/my_order.dart';
import 'package:food_app/widgets/payment_box.dart';
import 'package:provider/provider.dart';

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
  Stripe,
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
                if (cardlist.length > 0) {
                  await Navigator.of(context).pushNamed(
                    '/allcards',
                    arguments: cardlist,
                  );
                } else {
                  print("no length");
                }
                //  print("visa");
              } else if (myType == AddressTypes.Stripe) {
                await orderProvider.getAllCard("stripe");
                List<CardModel> cardlist = await orderProvider.getCardList;
                print("lengeth ${cardlist.length}");
                if (cardlist.length > 0) {
                  await Navigator.of(context).pushNamed(
                    '/allcards',
                    arguments: cardlist,
                  );
                } else {
                  Navigator.of(context).pushNamed("/addcard",
                      arguments: AddCardArgument(
                          image: 'assets/stripe.png', accountType: "stripe"));

                  print("no length");
                }
                //  print("visa");
              } else {
                Navigator.of(context).pushNamed("/addcard",
                    arguments: AddCardArgument(
                        image: 'assets/visa.png', accountType: "visa"));
              }
            },
            child: orderProvider.isCardLoaded
                ? CircularProgressIndicator()
                : Text(
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
                  address:
                      "aera, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society ${widget.deliverAddressList.scoirty}, pincode ${widget.deliverAddressList.pinCode}",
                  title:
                      "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
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
                  leading: Text("Payment Options"),
                ),
                RadioListTile(
                  value: AddressTypes.Visa,
                  groupValue: myType,
                  title: PaymentBox(
                      paymentOption: "visa", image: "assets/visa.png"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                ),
                RadioListTile(
                  value: AddressTypes.Stripe,
                  groupValue: myType,
                  title: PaymentBox(
                      paymentOption: "Stripe", image: "assets/stripe.png"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                ),
                RadioListTile(
                  value: AddressTypes.Cashon,
                  groupValue: myType,
                  title: PaymentBox(
                      paymentOption: "CashOn", image: "assets/cashon.png"),
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
