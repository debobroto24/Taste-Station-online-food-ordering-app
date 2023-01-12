import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/widgets/count.dart';
import 'package:food_app/widgets/product_unit.dart';

class SingalProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final Function onTap;
  final String productId;
  final ProductModel productUnit;
  final double rate; 
  final int totalRate; 
  final String category; 
  // final List<dynamic> productUnit;
  SingalProduct(
      {this.productId,
      this.productImage,
      this.productName,
      this.productUnit,
      this.onTap,
      this.productPrice,this.rate,this.totalRate, this.category});

  @override
  _SingalProductState createState() => _SingalProductState();
}

class _SingalProductState extends State<SingalProduct> {
  var unitData;
  var firstValue;
  String firstHalf;
  String secondHalf;
  // @override
  // void initState() {
  //   super.initState();
  //   if(widget.productName.length > 130){
  //     firstHalf = widget.productName.substring(0,130);

  //   }else{
  //     firstHalf = widget.productName;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // widget.productUnit.productUnit.firstWhere((element) {
    //   setState(() {
    //     firstValue = element;
    //   });
    //   return true;
    // });
    bool isbig;
    if (widget.productName.length > 20) {
      firstHalf = widget.productName.substring(0, 20);
      isbig = true;
    } else {
      firstHalf = widget.productName;
      isbig = false;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 245,
            width: 165,
            decoration: BoxDecoration(
              color: Color(0xffd9dad9),
              // color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                      height: 150,
                      // padding: EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          // image: DecorationImage(image: widget.productImage.)
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          widget.productImage,
                          width: 165,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),),
                ),
                Padding( 
                  padding:
                        const EdgeInsets.only(left:10),
                  child: RatingBarIndicator(
                            rating: widget.rate,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // widget.productName.length > 140
                        Text(
                          isbig ? firstHalf + "..." : firstHalf ?? "...",
                          maxLines: 1,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          // '${widget.productPrice}\$/${unitData == null?firstValue:unitData}',
                          '${widget.productPrice}\৳',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Expanded(
                            //   child: ProductUnit(
                            //     onTap: () {
                            //       showModalBottomSheet(
                            //           context: context,
                            //           builder: (context) {
                            //             return Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: widget
                            //                   .productUnit.productUnit
                            //                   .map<Widget>((data) {
                            //                 return Column(
                            //                   children: [
                            //                     Padding(
                            //                       padding: const EdgeInsets
                            //                               .symmetric(
                            //                           vertical: 10,
                            //                           horizontal: 10),
                            //                       child: InkWell(
                            //                         onTap: () async {
                            //                           setState(() {
                            //                             unitData = data;
                            //                           });
                            //                           Navigator.of(context)
                            //                               .pop();
                            //                         },
                            //                         child: Text(
                            //                           data,
                            //                           style: TextStyle(
                            //                               color: primaryColor,
                            //                               fontSize: 18),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 );
                            //               }).toList(),
                            //             );
                            //           });
                            //     },
                            //     title: unitData == null?firstValue:unitData,
                            //   ),
                            // ),

                            // SizedBox(
                            //   width: 5,
                            // ),
                            // Count(
                            //   productId: widget.productId,
                            //   productImage: widget.productImage,
                            //   productName: widget.productName,
                            //   productPrice: widget.productPrice,
                            //   productUnit:
                            //       unitData == null ? firstValue : unitData,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
