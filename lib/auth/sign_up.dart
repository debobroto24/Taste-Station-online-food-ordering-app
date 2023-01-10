import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/widgets/auth_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../providers/user_provider.dart';
import '../screens/home/home_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Container(
             height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/background.png')),
              ),
            child: Center(
              child:SingleChildScrollView(  
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text('Vegi',
                            style:
                                TextStyle(fontSize: 50, color: Colors.white, shadows: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.green.shade900,
                                offset: Offset(3, 3),
                              )
                            ],),
                          ),
                    SizedBox(height:40),
                    Text("Sign Up", style: TextStyle( color: Colors.black12, fontWeight: FontWeight.bold,fontSize:20),), 
                    SizedBox(height:30),
                    AuthTextField(controller: emailController, hinText: "Name",icon: Icons.person_outline,),
                    SizedBox(height:20),
                    AuthTextField(controller: emailController, hinText: "Email",icon: Icons.email_outlined,),
                    SizedBox(height:20),
                    AuthTextField(controller: emailController, hinText: "Password",icon: Icons.password_outlined,isObscure: true,),
                    SizedBox(height:30),
                    Container(
                      padding: EdgeInsets.only(left:10,right:10,top:5,bottom:5), 
                      decoration: BoxDecoration(  
                        color: primaryColor, 
                        borderRadius: BorderRadius.circular(5), 
                      ), 
                      child:Text("Sign up", style: TextStyle( color: Colors.white,fontSize:20),), 

                    ),

                    SizedBox(height: 30,), 
                    RichText(
                       text: TextSpan(  
                        children: [
                          TextSpan(text : "Do you already have an account" , style:TextStyle(color:Colors.black87,)), 
                          TextSpan(text: " Sign In", style:TextStyle(color:Colors.black87, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                          }), 
                        ]
                       ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.only(top:20,bottom: 20),
                      alignment: Alignment.center,
                      child: Text("Or", style:TextStyle(fontSize:22, fontWeight: FontWeight.bold, color:Colors.black),),
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
              ),
            )
          )
        ],
      ),
    ); 
  }
}