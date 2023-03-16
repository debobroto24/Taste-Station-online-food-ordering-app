import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/card_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/route_helper/add_card_argument.dart';
import 'package:food_app/widgets/cards.dart';
import 'package:food_app/widgets/payment_box.dart';
import 'package:provider/provider.dart';

class AllCards extends StatelessWidget {
  ProductOrderProvider orderProvider;
  final List<CardModel> cardlist;
  final String accountType; 
  AllCards({Key key, this.cardlist , this.accountType}) : super(key: key);
    showAlertDialog(BuildContext context, String cardId) {
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
        orderProvider.deleteCardData(cardId);
        cardlist.removeWhere((element) => element.cardNumber == cardId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Visa Card"),
      content: Text("Are you sure?"),
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
    orderProvider = Provider.of<ProductOrderProvider>(context);
    // orderProvider.getAllCard(cardType);
    // List<CardModel> cardlist = orderProvider.getCardList;
    // cardlist.forEach(
    //   (element) => print(element.cardNumber),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Select Card",
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
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // print("im tapped");
                              orderProvider.addOrder(e.accountType, e.cardNumber);
                              EasyLoading.showToast(
                                'Processing...',
                                dismissOnTap: true,
                                duration: Duration(seconds: 4),
                              );
                    
                              await Future.delayed(Duration(seconds: 4), () {});
                              Navigator.of(context).pushNamed("/paymentsuccessful",arguments: false);
                            },
                            child: Cards(
                                cardnumber: e.cardNumber, image: "assets/visa.png"),
                          ),
                           GestureDetector(
                            onTap: () {
                            showAlertDialog(context, e.cardNumber);
                          },
                             child: Container(
                              padding:EdgeInsets.only(top:25)
                              ,child: Icon(Icons.delete_sweep_rounded,size:35,color:primaryColor)),
                           ), 
                        ],
                      ),
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
                      
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color.fromRGBO(217, 217, 217, 100)
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
                              color: Colors.black,
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
                child:   GestureDetector(
                    onTap: () {
                      String image; 
                      // if(accountType == "visa"){
                      //   image = "assets/visa.png";
                      // }else if(accountType == "stripe"){
                      //   image =  "assets/stripe.png";
                      // }
                      image = "assets/visa.png";

                      // print("im tapped");
                      Navigator.of(context).pushNamed("/addcard",
                          arguments: AddCardArgument(
                              image: image,
                              accountType: "visa"));
                    },
                    child: Container(
                      // padding: EdgeInsets.symmetric(vertical: 15),
                      width:200,
                      height: 40,
                      padding: EdgeInsets.only(top:10,bottom:10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                       color: Color.fromRGBO(217, 217, 217, 100)
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
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                
              ),
      ),
              
    );
  }
}
