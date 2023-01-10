// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:food_app/auth/sign_up.dart';
// import 'package:food_app/config/colors.dart';
// import 'package:food_app/providers/user_provider.dart';
// import 'package:food_app/screens/home/home_screen.dart';
// import 'package:food_app/widgets/auth_text_field.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';

// class SignIn extends StatefulWidget {
//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   UserProvider userProvider;
//   Future<void> _googleSignUp() async {
//     try {
//       final GoogleSignIn _googleSignIn = GoogleSignIn(
//         scopes: ['email'],
//       );
//       final FirebaseAuth _auth = FirebaseAuth.instance;

//       final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final User user = (await _auth.signInWithCredential(credential)).user;
//       // print("signed in " + user.displayName);
//       userProvider.addUserData(
//         currentUser: user,
//         userEmail: user.email,
//         userImage: user.photoURL,
//         userName: user.displayName,
//       );

//       return user;
//     } catch (e) {
//       print(e.message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     userProvider = Provider.of<UserProvider>(context);

//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.cover, image: AssetImage('assets/background.png')),
//             ),
//             child: Center(
//               child: SingleChildScrollView(

//                 child: Container(

//                   // color: Colors.red,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                        Text('Vegi',
//                           style:
//                               TextStyle(fontSize: 50, color: Colors.white, shadows: [
//                             BoxShadow(
//                               blurRadius: 5,
//                               color: Colors.green.shade900,
//                               offset: Offset(3, 3),
//                             )
//                           ]),
//                         ),
//                         SizedBox(height: 20,),

//                         AuthTextField(controller: emailController,hinText: "Email", isObscure: false, icon:Icons.email_outlined),
//                         SizedBox(height: 20),
//                         AuthTextField(controller: emailController,hinText: "password", isObscure: true, icon:Icons.password_outlined),
//                         SizedBox(height:25),
//                         Container(
//                       padding: EdgeInsets.only(left:10,right:10,top:5,bottom:5),
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child:Text("Login", style: TextStyle( color: Colors.white,fontSize:20),),

//                     ),
//                       // SignInButton(
//                           //   Buttons.Apple,
//                           //   text: "Sign in with Apple",
//                           //   onPressed: () {},
//                           // ),
//                           SizedBox(height: 30,),

//                               RichText(
//                        text: TextSpan(
//                         children: [
//                           // TextSpan(text : "Don't have account!" , style:TextStyle(color:Colors.black87,)),
//                           // TextSpan(text: " Sign UP", style:TextStyle(color:Colors.black87, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = (){
//                           //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
//                           // }),
//                         ]
//                        ),
//                     ),

//                     Container(
//                       padding: EdgeInsets.only(top:20,bottom: 20),
//                       alignment: Alignment.center,
//                       child: Text("Or", style:TextStyle(fontSize:22, fontWeight: FontWeight.bold, color:Colors.black),),
//                     ),

//                           SignInButton(
//                             Buttons.Google,
//                             text: "Login with Google",
//                             onPressed: () async {
//                               await _googleSignUp().then(
//                                 (value) => Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(
//                                     builder: (context) => HomeScreen(),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'By signing in you are agreeing to our',
//                                 style: TextStyle(
//                                   color: Colors.grey[800],
//                                 ),
//                               ),
//                               Text(
//                                 'Terms and Pricacy Policy',
//                                 style: TextStyle(
//                                   color: Colors.grey[800],
//                                 ),
//                               ),
//                             ],
//                           ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserProvider userProvider;
  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
        currentUser: user,
        userEmail: user.email,
        userImage: user.photoURL,
        userName: user.displayName,
      );

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/online-food-app.jpg')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Testy Food',
              style: TextStyle(fontSize: 50, color: Colors.white, shadows: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.green.shade900,
                  offset: Offset(3, 3),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 10, right: 10),
            //   width: double.infinity * 0.5,
            //   height: 40,
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //             color: Colors.grey,
            //             blurRadius: 7,
            //             offset: Offset(0, 0)),
            //       ]),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Email",
            //       prefixIcon:
            //           Icon(Icons.email_outlined, size: 20, color: Colors.grey),
            //       border: InputBorder.none,
            //     ),
            //   ),
            // ),
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Sign in to contunue'),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Apple,
                        text: "Sign in with Apple",
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () async {
                          await _googleSignUp().then(
                            (value) => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'By signing in you are agreeing to our',
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'Terms and Pricacy Policy',
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
