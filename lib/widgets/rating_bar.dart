import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FoodRatingBar extends StatelessWidget {
  double minRating ; 
  double initialRating ;
  double size;  
  FoodRatingBar({Key key,  this.minRating,  this.initialRating,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return RatingBar.builder(
      
       initialRating: initialRating,
       minRating: minRating,
       itemSize: size,
       direction: Axis.horizontal,
       allowHalfRating: true,
       itemCount: 5,
       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
       itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
    // ),
    );
  }
}
