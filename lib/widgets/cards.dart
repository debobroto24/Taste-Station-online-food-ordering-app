import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String cardnumber;
  final String image;
  Cards({Key key, this.cardnumber, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top:35), 
      width: MediaQuery.of(context).size.width * 75,
      height: 40,
              color: Colors.white10,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width:10),
          Row(
            children: [
              Container(
                width: 60,
                height: 35,
                decoration: BoxDecoration(
                  // color:Colors.red,

                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        image,
                      )),
                ),
              ),
               SizedBox(width: 20),
          Text(
            cardnumber,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black45),
          ),
            ],
          ),
          Icon(Icons.delete_forever_rounded,size:35,color:Colors.black45), 
         
        ],
      ),
    );
  }
}
