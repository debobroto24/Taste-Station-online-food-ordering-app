import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/order_cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/check_out/delivery_details/delivery_details.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/my_order/single_order.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  ReviewCartProvider reviewCartProvider;

  ProductOrderProvider productOrderProvider;
  // productOrderProvider.fetchOrderList();

  // showAlertDialog(BuildContext context, ReviewCartModel delete) {
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     child: Text("No"),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );
  //   Widget continueButton = TextButton(
  //     child: Text("Yes"),
  //     onPressed: () {
  //       reviewCartProvider.reviewCartDataDelete(delete.cartId);
  //       Navigator.of(context).pop();
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Cart Product"),
  //     content: Text("Are you devete on cartProduct?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //     ReviewCartProvider reviewCartProvider;
    // ProductOrderProvider productOrderProvider;
    double totalPrice;
    int totalProduct;
    // @override
    // void initState() {
    //   super.initState();
    // }

    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    productOrderProvider = Provider.of<ProductOrderProvider>(context);
    reviewCartProvider.getReviewCartData();
    //  Provider.of<ProductOrderProvider>(context).fetchOrderList();
    productOrderProvider.fetchOrderList();
    Map<String, List<OrderCartModel>> data = productOrderProvider.getOrderMap;
    // print("length is : ${data.length}"); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("My order"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              icon: Icon(Icons.home_outlined),),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        height: double.infinity,
        width: double.infinity,
        child: productOrderProvider.getIsLoading
            ? data.isEmpty
                ? Center(
                    child: Text('you dont have any order'),
                  )
                : Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: data.entries.map((e) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 20),
                            height: 140,
                            child: Column(
                              children: [
                                // date section
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    e.key ?? ' ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                // image section
                                Container(
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: e.value.map((cartValue) {
                                        setState(() {
                                          double totalPrice =
                                              cartValue.totalPrice;
                                          int totalProduct =
                                              cartValue.totalproduct;
                                        });
                                        // print(cartValue.cartId);
                                        return Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.network(
                                              cartValue.cartImage,
                                              width: 75,
                                              height: 70,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("total ৳ ${totalPrice.toString()}"),
                                      SizedBox(width: 10),
                                      Text(
                                          "total item ${totalProduct.toString()}"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              '/orderdetails',
                                              arguments: data[e.key]);
                                            // List<ProductModel> list = e.value.contains(e); 
                                            // print(data.entries.singleWhere((element) => element.key == e.key).value); 
                                            // List<ProductModel> list = data.entries.singleWhere((element) => element.key == e.key).value.;
                                          //  List<ProductModel> ite =  data[e.key].whereType();  
                                          // print(e.value.toList());  
                                          // print(data[e.key].map((e) => e.cartName));
                                          // List<OrderCartModel> or  = data[e.key]; 
                                          // or.map((e) =>print( e.cartName));
                                        },
                                        child: Text("See Details"),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  height: 3,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromARGB(255, 37, 38, 39)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

//  if(data.cartName.length > 15){
//       firstHalf =data.cartName.substring(0,15);
//       isbig = true ;
//     }else{
//       firstHalf =data.cartName;
//         isbig = false ;
//     }
// Text( isbig?firstHalf+ "...":firstHalf ?? "...",maxLines: 1,),
// children: [
//               Container(
//                 margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
//                 height: 120,
//                 child: Column(
//                   children: [
//                     // date section
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "23 june 2022",
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     // image section
//                     Container(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(7),
//                               child: Image.network(
//                                 "https://www.allrecipes.com/thmb/PHF_wbUzp-wIt6OYo2cMnt4xuZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/25473-the-perfect-basic-burger-ddmfs-4x3-1350-1-f65d5518ecc0435f9791d453ee9cd78f.jpg",
//                                 width: 75,
//                                 height: 70,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(7),
//                               child: Image.network(
//                                 "https://www.allrecipes.com/thmb/PHF_wbUzp-wIt6OYo2cMnt4xuZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/25473-the-perfect-basic-burger-ddmfs-4x3-1350-1-f65d5518ecc0435f9791d453ee9cd78f.jpg",
//                                 width: 80,
//                                 height: 80,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(7),
//                               child: Image.network(
//                                 "https://www.allrecipes.com/thmb/PHF_wbUzp-wIt6OYo2cMnt4xuZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/25473-the-perfect-basic-burger-ddmfs-4x3-1350-1-f65d5518ecc0435f9791d453ee9cd78f.jpg",
//                                 width: 80,
//                                 height: 80,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(7),
//                               child: Image.network(
//                                 "https://www.allrecipes.com/thmb/PHF_wbUzp-wIt6OYo2cMnt4xuZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/25473-the-perfect-basic-burger-ddmfs-4x3-1350-1-f65d5518ecc0435f9791d453ee9cd78f.jpg",
//                                 width: 80,
//                                 height: 80,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(7),
//                               child: Image.network(
//                                 "https://www.allrecipes.com/thmb/PHF_wbUzp-wIt6OYo2cMnt4xuZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/25473-the-perfect-basic-burger-ddmfs-4x3-1350-1-f65d5518ecc0435f9791d453ee9cd78f.jpg",
//                                 width: 80,
//                                 height: 80,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(7),
//                               child: Image.network(
//                                 "https://www.allrecipes.com/thmb/PHF_wbUzp-wIt6OYo2cMnt4xuZ4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/25473-the-perfect-basic-burger-ddmfs-4x3-1350-1-f65d5518ecc0435f9791d453ee9cd78f.jpg",
//                                 width: 80,
//                                 height: 80,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 3),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Text("total ৳ 44"),
//                           SizedBox(width: 10),
//                           Text("total itam 5"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
