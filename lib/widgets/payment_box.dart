import 'package:flutter/material.dart';

class PaymentBox extends StatelessWidget {
  final String paymentOption;
  final String image;
  PaymentBox({Key key, this.paymentOption, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin:EdgeInsets.only(top:10px)
      width: MediaQuery.of(context).size.width * 75,
      height: 40,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromARGB(255, 255, 179, 156)..withOpacity(.3),
              spreadRadius: 2,
              blurRadius: 5
              
              )
        ],
        color: Color.fromARGB(255, 228, 228, 228),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // SizedBox(width:10),
          Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
              // color:Colors.red,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    image,
                  )),
            ),
          ),
          SizedBox(width: 20),
          Text(
            paymentOption,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
