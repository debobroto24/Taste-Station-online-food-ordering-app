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
    // reviewCartProvider.getReviewCartData();
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
            icon: Icon(Icons.home_outlined),
          ),
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 15),
          height: double.infinity,
          width: double.infinity,
          // child: productOrderProvider.getIsLoading
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )

          // : data.isEmpty
          //   ? Center(
          //       child: Text('you dont have any order'),
          //     )
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: data.entries.map((e) {
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    height: 155,
                    child: Column(
                      children: [
                        // date section
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: primaryColor),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              e.key ?? ' ',
                              // e.value.first.dateTime.toString() ?? ' ', this is real date time from data base
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(height: 2),
                        // image section
                        Container(
                          // padding:EdgeInsets.only(top:8,bottom:8),
                          width: double.infinity,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    // image
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundColor: primaryColor,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            e.value.first.cartImage.toString(),
                                          ),
                                          radius: 43,
                                          backgroundColor:
                                              scaffoldBackgroundColor),
                                    ),
                                  ),
                                  Text(
                                    e.value.length > 1
                                        ? "+${e.value.length - 1}"
                                        : " ",
                                    style: TextStyle(
                                        fontSize: 30, color: primaryColor),
                                  )
                                ],
                              )),
                              //details and button
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                        "Total  ${e.value.first.totalPrice.toString()}৳"),
                                    SizedBox(width: 10),
                                    // Text(
                                    //     "total item ${totalProduct.toString()}"),
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
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: primaryColor,
                                        ),
                                        child: Text(
                                          "View Order",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          )),
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
