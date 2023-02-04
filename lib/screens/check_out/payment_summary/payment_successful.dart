import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';

class PaymentSuccessful extends StatelessWidget {
  final bool isCashOn;
  const PaymentSuccessful({Key key, this.isCashOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Center(
                      child: Icon(
                    Icons.check_circle_rounded,
                    size: MediaQuery.of(context).size.width * .50,
                    color: primaryColor,
                  )),
                  SizedBox(height: 10),
                  Text(
                    !isCashOn ? "Payment Approved" : "Order Confirmed",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    !isCashOn
                        ? "Payment Successful"
                        : "We are preparing your food",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width * .75,
                    //   padding: EdgeInsets.symmetric(vertical: 15),
                    //   decoration: BoxDecoration(
                    //     color: primaryColor,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     "Your order status",
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white),
                    //   ),
                    // ),

                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/home");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .75,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(217,217,217, 205),
                          color: Color.fromRGBO(217, 217, 217, 100),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Go to Home Page",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
