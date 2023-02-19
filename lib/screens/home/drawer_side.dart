import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_profile/my_profile.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/wishList/wish_list.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
  DrawerSide({this.userProvider});
  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({String title, IconData iconData, Function onTap}) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: onTap,
        leading: Icon(iconData, size: 28, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    FirebaseAuth fireabase = FirebaseAuth.instance;
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      child: Drawer(
        child: Container(
          color: Color.fromRGBO(255, 135, 37, 0.612),
          child: ListView(
            children: [
              DrawerHeader(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    // padding: EdgeInsets.only(left:10),
                    // alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * .5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 43,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            backgroundImage: NetworkImage(
                              userData.userImage ??
                                  "https://s3.envato.com/files/328957910/vegi_thumb.png",
                            ),
                            radius: 40,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              userData.userName,
                              // "user name"
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              listTile(
                iconData: Icons.home_outlined,
                title: "HOME",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              listTile(
                iconData: Icons.person_outlined,
                title: "PROFILE",
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         MyProfile(userProvider: widget.userProvider),
                  //   ),
                  // );
                  Navigator.of(context)
                      .pushNamed('/profile', arguments: widget.userProvider);
                },
              ),
              listTile(
                iconData: Icons.shopping_cart_outlined,
                title: "REVIEW CART",
                onTap: () {
                  Navigator.of(context).pushNamed('/review');
                },
              ),
              listTile(
                  iconData: Icons.shop_outlined,
                  title: 'ORDERS',
                  onTap: () {
                    Navigator.of(context).pushNamed('/myorder');
                  }),

              // listTile(
              //     iconData: Icons.notifications_outlined, title: "Notificatio"),
              // listTile(iconData: Icons.star_outline, title: "Rating & Review"),
              listTile(
                  iconData: Icons.favorite_outline,
                  title: "FAVOURITES",
                  onTap: () {
                    Navigator.of(context).pushNamed('/wishlist');
                  }),
              listTile(
                  iconData: Icons.exit_to_app_outlined,
                  title: "Log Out",
                  onTap: () async {
                    // print("logout is tapped");
                    await GoogleSignIn().signOut();
                    await fireabase.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignIn();
                    }));
                  }),
              // listTile(
              //     icon: Icons.exit_to_app_outlined,
              //     title: "Log Out",
              //     tap: () async {
              //       print("logout is tapped");
              //       await GoogleSignIn().signOut();
              //       await fireabase.signOut();
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) {
              //         return SignIn();
              //       }));
              //     }),
              // listTile(iconData: Icons.copy_outlined, title: "Raise a Complaint"),
              // listTile(iconData: Icons.format_quote_outlined, title: "FAQs"),
              // Container(
              //   height: 350,
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("Contact Support"),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       Row(
              //         children: [
              //           Text("Call us:"),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Text("+00000000"),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Row(
              //           children: [
              //             Text("Mail us:"),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               "hel@gmail.com",
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
