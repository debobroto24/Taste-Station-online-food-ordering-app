import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_app/models/card_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/route_helper/add_card_argument.dart';
import 'package:food_app/widgets/cards.dart';
import 'package:food_app/widgets/payment_box.dart';
import 'package:provider/provider.dart';

class AllCards extends StatelessWidget {
  ProductOrderProvider orderProvider;
  final List<CardModel> cardlist;
  AllCards({Key key, this.cardlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // orderProvider = Provider.of<ProductOrderProvider>(context);
    // orderProvider.getAllCard(cardType);
    // List<CardModel> cardlist = orderProvider.getCardList;
    // cardlist.forEach(
    //   (element) => print(element.cardNumber),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Account",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
          // margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: cardlist.length > 0
              ? Column(
                  children: [
                    Column(
                        children: cardlist.map((e) {
                      return GestureDetector(
                        onTap: () async{
                          print("im tapped");
                          
                                                                              EasyLoading.showToast('Processing...',dismissOnTap: true,duration: Duration(seconds: 4),);

                         await Future.delayed(Duration(seconds: 4),(){

                          });
                          Navigator.of(context).pushNamed("/paymentsuccessful"); 
                        },
                        child:Cards(
                            cardnumber: e.cardNumber, image: "assets/visa.png"),
                      );
                    }).toList()),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/addcard",
                            arguments: AddCardArgument(
                                image: 'assets/${cardlist[0].accountType}.png',
                                accountType: cardlist[0].accountType));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 80,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color.fromARGB(136, 113, 112, 112)
                            ..withOpacity(.8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 18),
                            SizedBox(width: 10),
                            Text(
                              "Add a new card",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text("you dont have any account"),
                )),
    );
  }
}
