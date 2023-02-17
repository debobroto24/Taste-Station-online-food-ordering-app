import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/auth/sign_up.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/route_helper/route_helper.dart';
import 'package:food_app/screens/check_out/payment_summary/load_payment.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_order/current_order.dart';
import 'package:food_app/screens/my_order/my_order.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<ProductOrderProvider>(
            create: (context) => ProductOrderProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            // primaryColor: primaryColor,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return HomeScreen();
            }
            // return CurrentOrder();
            return SignIn();
            // return SignUp();
            // return LoadPayment();
            // return MyOrder();
          },
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
