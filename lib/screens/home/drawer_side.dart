import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_profile/my_profile.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/wishList/wish_list.dart';

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
<<<<<<< HEAD
        leading: Icon(
          iconData,
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor),
=======
        leading: Icon(iconData, size: 28, color: Colors.white),
        title: Text(
          title,
          // style: TextStyle(color: textColor),
          style: TextStyle(
              color: textColor2, fontWeight: FontWeight.w500, fontSize: 18),
>>>>>>> d95f242 (drawyr, wishlist, profile pages frontend updated)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
<<<<<<< HEAD
    return Drawer(
      child: Container(
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white54,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
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
                        Text(userData.userName
                            // "user name"

                            ),
                        Text(
                          userData.userEmail,
                          // "user email",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            listTile(
              iconData: Icons.home_outlined,
              title: "Home",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.shop_outlined,
              title: "Review Cart",
              onTap: () {
                Navigator.of(context).pushNamed('/review');
              },
            ),
            listTile(
                iconData: Icons.shop_outlined,
                title: 'Orders',
                onTap: () {
                  Navigator.of(context).pushNamed('/myorder');
                }),
            listTile(
              iconData: Icons.person_outlined,
              title: "My Profile",
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
            // listTile(
            //     iconData: Icons.notifications_outlined, title: "Notificatio"),
            // listTile(iconData: Icons.star_outline, title: "Rating & Review"),
            listTile(
                iconData: Icons.favorite_outline,
                title: "Wishlist",
                onTap: () {
                  Navigator.of(context).pushNamed('/wishlist');
                }),
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
=======
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      child: Drawer(
        // backgroundColor: Colors.transparent,
        // elevation: 0.8,
        child: Container(
          // margin: EdgeInsets.only(right: 80),
          color: primaryColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white54,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            userData.userName,
                            // "user name"
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(height: 5),
                          // Text(
                          //   userData.userEmail,
                          //   // "user email",
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                        ],
                      )
                    ],
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
                iconData: Icons.shop_outlined,
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
              // listTile(
              //     iconData: Icons.notifications_outlined, title: "Notificatio"),
              // listTile(iconData: Icons.star_outline, title: "Rating & Review"),
              listTile(
                  iconData: Icons.favorite_outline,
                  title: "WISHLIST",
                  onTap: () {
                    Navigator.of(context).pushNamed('/wishlist');
                  }),
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
>>>>>>> d95f242 (drawyr, wishlist, profile pages frontend updated)
        ),
      ),
    );
  }
}
