// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:food_app/providers/product_order_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class LoadPayment extends StatefulWidget {
//   const LoadPayment({Key key}) : super(key: key);

//   @override
//   State<LoadPayment> createState() => _LoadPaymentState();
// }

// class _LoadPaymentState extends State<LoadPayment> {
//   TextEditingController dateInput = TextEditingController();
//   TextEditingController cardnoCon = TextEditingController();
//   Timer _timer;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     String dateInput = "";
//     bool dateeroor = false;
//     DateTime isValidDateTime;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     dateInput.dispose();
//     cardnoCon.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ProductOrderProvider productOrderProvider;
//     productOrderProvider = Provider.of<ProductOrderProvider>(context);
//     Timer _timer;
//     bool cardError = false;
//     // String cardNoMsg = "";
//     bool dateerror = false;
//     // String dateMsg = "";
//     bool dateSelected = false;
//     // paymentdata() async {

//     // }
//     // print('card no msg below');
//     // print(cardNoMsg);
//     showscaffold(Widget txt) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: txt));
//     }

//     DateTime isValidDateTime;

//     payment() async {
//       if (cardnoCon.text.isEmpty) {
//         showscaffold(Text('Please enter your card number.'));
//       } else if (cardnoCon.text.length < 10) {
//         showscaffold(Text('Enter you valid card number.'));
//       } else if (cardnoCon.text.length < 10) {
//         showscaffold(Text('Enter you valid card number.'));
//       } else if (dateInput.text.isEmpty) {
//         showscaffold(Text('Please Entire expire date'));
//       } else {
//         await productOrderProvider.addOrder('stripe');

//         Future.delayed(Duration(seconds: 3), () {
//           // EasyLoading.show(status: 'Processing...');
//         });
//         // EasyLoading.dismiss();
//         EasyLoading.addStatusCallback((status) {
//           print('EasyLoading Status $status');
//           if (status == EasyLoadingStatus.dismiss) {
//             _timer?.cancel();
//           }
//         });
//         EasyLoading.showSuccess('Payment Successful');
//         Navigator.of(context).pushNamed('/home');
//         // EasyLoading.instance
//         //   ..displayDuration = const Duration(milliseconds: 2000);
//         // EasyLoading.show(status: 'loading...');
//         // EasyLoading.showSuccess('Use in initState');
//         // productOrderProvider.getIsLoading
//         //     ? AlertDialog(content: CircularProgressIndicator())
//         //     : Navigator.of(context).pushNamed('/home');

//         // productOrderProvider.isLoading?
//         // EasyLoading.addStatusCallback((status) {
//         //   print('EasyLoading Status $status');
//         // });
//         //     EasyLoading.addStatusCallback((status) {
//         //   print('EasyLoading Status $status');
//         //   if (status == EasyLoadingStatus.dismiss) {
//         //     _timer?.cancel();
//         //   }
//         // });
//         // EasyLoading.addStatusCallback((status) {
//         //   print('EasyLoading Status $status');
//         //   EasyLoadingStatus.dismiss;
//         // });

//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.only(left: 10, right: 10, top: 40),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 25),
//               Text(
//                 'Stripe Payment',
//                 style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent),
//               ),
//               SizedBox(height: 5),
//               Text('Get all our services'),
//               SizedBox(
//                 height: 100,
//               ),
//               // card number
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Card Number'),
//                   SizedBox(height: 5),
//                   SizedBox(
//                     height: 60,
//                     child: TextField(
//                       controller: cardnoCon,
//                       maxLength: 10,
//                       maxLines: 1,
//                       // keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                           borderSide:
//                               BorderSide(width: 1, color: Colors.blueAccent),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(width: 1, color: Colors.blueAccent),
//                         ),
//                       ),
//                     ),
//                   ),
//                   cardError
//                       ? Text('Please fill up the this field correctly',
//                           style: TextStyle(color: Colors.red))
//                       : Container(),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),

//               // expire date
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Expire Date'),
//                   SizedBox(height: 5),
//                   SizedBox(
//                     height: 50,
//                     child: TextField(
//                       controller: dateInput,
//                       keyboardType: TextInputType.number,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(3),
//                           borderSide:
//                               BorderSide(width: 1, color: Colors.blueAccent),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(width: 1, color: Colors.blueAccent),
//                         ),
//                       ),
//                       onTap: () async {
//                         DateTime pickeddate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2022, 11),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickeddate != null) {
//                           setState(() {
//                             dateInput.text =
//                                 DateFormat('dd-MM-yyyy').format(pickeddate);
//                             DateTime isValidDateTime = pickeddate;
//                             setState(() {
//                               dateSelected = true;
//                             });
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                   dateerror
//                       ? Text('Please fill up the this field correctly',
//                           style: TextStyle(color: Colors.red))
//                       : Container(),
//                 ],
//               ),
//               SizedBox(height: 20),
//               GestureDetector(
//                 onTap: () async {
//                   payment();
//                   Future.delayed(Duration(seconds: 5), () {
//                     CircularProgressIndicator();
//                     AlertDialog(
//                       content: Text('payment successfull'),
//                     );
//                   });
//                 },
//                 child: Container(
//                   padding:
//                       EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
//                   decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       // border: Border.all(),
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Text("payment", style: TextStyle(color: Colors.white)),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
