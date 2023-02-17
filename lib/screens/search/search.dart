import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/screens/product_overview/product_overview.dart';
import 'package:food_app/widgets/single_item.dart';

class Search extends StatefulWidget {
  final List<ProductModel> search;
  Search({this.search});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Search"),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: IconButton(
        //       onPressed: () {},
        //       // icon: Icon(Icons.sort),
        //     ),
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 52,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(217, 217, 217, 100),
                filled: true,
                hintText: "Search for items in the store",
                suffixIcon: Icon(Icons.search, color: primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              title: Text(
                "Items",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem.map((data) {
              // isBool: true,
              //             wishList: false,
              //             productImage: data.cartImage,
              //             productName: data.cartName,
              //             productPrice: data.cartPrice,
              //             productId: data.cartId,
              //             productQuantity: data.cartQuantity,
              //             productUnit: data.cartUnit,
              //             onDelete: () {
              //               showAlertDialog(context, data);
              //             },
              return GestureDetector(
                onTap: () {},
                child: SingleItem(
                  isBool: true,
                  isSearch: true,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productId,
                  productQuantity: data.productQuantity,
                  searchVeiw: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: data.productId,
                          productImage: data.productImage,
                          productName: data.productName,
                          productPrice: data.productPrice,
                          rate: data.rate,
                          totalRate: data.totalRate,
                          category: data.category,
                        ),
                      ),
                    );
                  },
                  //                 onDelete: () {
                  //   showAlertDialog(context, data);
                  // },
                ),
              );
            }).toList(),

            // SingleItem(
            //               isBool: true,
            //               wishList: false,
            //               productImage: data.cartImage,
            //               productName: data.cartName,
            //               productPrice: data.cartPrice,
            //               productId: data.cartId,
            //               productQuantity: data.cartQuantity,
            //               productUnit: data.cartUnit,
            //               onDelete: () {
            //                 showAlertDialog(context, data);
            //               },
            //             ),
          )
        ],
      ),
    );
  }
}
