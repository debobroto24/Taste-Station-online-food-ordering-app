import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/card_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/route_helper/add_card_argument.dart';
import 'package:food_app/route_helper/all_card_argument.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  String addCard;
  String image;
  String accountType;
  AddCard({this.addCard, this.image, this.accountType});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController cardnoCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  ProductOrderProvider orderProvider;

  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String dateInput = "";
    bool dateeroor = false;
    DateTime isValidDateTime;
  }

  @override
  void dispose() {
    super.dispose();
    dateInput.dispose();
    cardnoCon.dispose();
  }

  // Timer _timer;
  bool cardError = false;

  bool dateerror = false;
  bool dateSelected = false;
  showscaffold(Widget txt) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: txt, dismissDirection: DismissDirection.startToEnd));
  }

  DateTime isValidDateTime;

  payment(ProductOrderProvider orderProvider) async {
    if (cardnoCon.text.isEmpty) {
      showscaffold(Text('Please enter your card number.'));
    } else if (cardnoCon.text.length < 10) {
      showscaffold(Text('Enter you valid card number.'));
    } else if (nameCon.text.isEmpty) {
      showscaffold(Text('Enter card holder name.'));
    } else if (cardnoCon.text.length < 10) {
      showscaffold(Text('Enter you valid card number.'));
    } else if (dateInput.text.isEmpty) {
      showscaffold(Text('Please Entire expire date'));
    } else {
      // await productOrderProvider.addOrder('stripe');

      // Future.delayed(Duration(seconds: 3), () {
      //   // EasyLoading.show(status: 'Processing...');
      // });
      // // EasyLoading.dismiss();
      // EasyLoading.addStatusCallback((status) {
      //   print('EasyLoading Status $status');
      //   if (status == EasyLoadingStatus.dismiss) {
      //     _timer?.cancel();
      //   }
      // });
      // EasyLoading.showSuccess('Payment Successful');
      // Navigator.of(context).pushNamed('/home');
      orderProvider.addCardNumber(cardnoCon.text, nameCon.text,
          dateInput.text.toString(), widget.accountType.toString());
          //  orderProvider.addCardNumber(cardnoCon.text, nameCon.text,
          // dateInput.text.toString(), widget.accountType.toString());
      await orderProvider.getAllCard(widget.accountType);
      List<CardModel> cardlist = await orderProvider.getCardList;
      Navigator.of(context).pushReplacementNamed(
        '/allcards',
        arguments: AllCardArgument(cardlist: cardlist, accountType: ''),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<ProductOrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        elevation: .7,
        title: Text(
          "Add Card",
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Fill your card data.',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 15),
            // card number
            SizedBox(
              height: 60,
              child: Align(
                alignment: Alignment.center,
                child: TextField(
                  controller: nameCon,
                  maxLength: 10,
                  maxLines: 1,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Card Holder Name',
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(width: 1, color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.black26),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 100, minHeight: 50),
                    width: MediaQuery.of(context).size.width * .65,
                    child: TextField(
                      controller: cardnoCon,
                      maxLength: 10,
                      maxLines: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: '0000 0000 0000',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  // //  card number
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    height: 40,
                    decoration: BoxDecoration(
                      // color:Colors.red,

                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.image),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // expire date
            SizedBox(height: 5),
            Container(
              height: 50,
              child: TextField(
                controller: dateInput,
                keyboardType: TextInputType.number,
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                ),
                // onTap: () async {
                //   DateTime pickeddate = await showDatePicker(
                //     context: context,
                //     initialDate: DateTime.now(),
                //     firstDate: DateTime(2022, 11),
                //     lastDate: DateTime(2101),
                //   );
                //   if (pickeddate != null) {
                //     setState(() {
                //       dateInput.text =
                //           DateFormat('dd-MM-yyyy').format(pickeddate);
                //       DateTime isValidDateTime = pickeddate;
                //       setState(() {
                //         dateSelected = true;
                //       });
                //     });
                //   }
                // },
              ),
            ),
            GestureDetector(
              onTap: () async {
                DateTime pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022, 11),
                  lastDate: DateTime(2101),
                );
                if (pickeddate != null) {
                  setState(() {
                    dateInput.text =
                        DateFormat('dd-MM-yyyy').format(pickeddate);
                    DateTime isValidDateTime = pickeddate;
                    setState(() {
                      dateSelected = true;
                    });
                  });
                }
              },
              child: Container(
                width: 152,
                height: 42,
                // padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black26),
                ),
                child: Text('Expire Date', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          payment(orderProvider);
        },
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 25, left: 8, right: 8),
          width: MediaQuery.of(context).size.width * .8,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: primaryColor,
              // border: Border.all(),
              borderRadius: BorderRadius.circular(15)),
          child: Text("Add Card",
              style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
