

import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller ; 
  final String hinText;
  final bool isObscure; 
  final IconData icon ; 
  const AuthTextField({Key key ,  this.controller , this.hinText , this.isObscure = false , this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
              margin: EdgeInsets.only(left:10, right:10), 
              width:double.infinity * 0.5,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(10), 
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey, 
                    blurRadius: 7, 
                    offset: Offset(0,0)
                  ),
                ]
              ),
              child: TextField( 
                controller: controller,
                obscureText: isObscure? isObscure : false, 
                decoration: InputDecoration(  
                  hintText:hinText,
                  prefixIcon: Icon(icon,size:20,color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            );
  }
}