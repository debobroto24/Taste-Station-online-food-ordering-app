import 'package:flutter/material.dart';
import 'package:food_app/models/order_cart_model.dart';
import 'package:food_app/screens/check_out/payment_summary/load_payment.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_order/my_order.dart';
import 'package:food_app/screens/my_order/order_details.dart';
import 'package:food_app/screens/my_profile/my_profile.dart';
import 'package:food_app/screens/search/search.dart';
import 'package:food_app/screens/wishList/wish_list.dart';

import '../screens/review_cart/review_cart.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/myorder':
        // if (args is String) {
        //     return MaterialPageRoute(
        //       builder: (_) => SecondPage(
        //             data: args,
        //           ),
        //     );
        //   }
        return MaterialPageRoute(builder: (_) => MyOrder());
      case '/review':
        return MaterialPageRoute(builder: (_) => ReviewCart());
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => MyProfile(
            userProvider: args,
          ),
        );
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => WishLsit());
      case '/orderdetails':
        return MaterialPageRoute(builder: (_){
          // print(args.toString);
          // print(settings.arguments); 
          return OrderDetails(orderDetails:  settings.arguments);
        });
      case '/loadpayment':
        return MaterialPageRoute(builder: (_) => LoadPayment());
      case '/search':
        return MaterialPageRoute(builder: (_) => Search(search: args));
    }
  }
}
