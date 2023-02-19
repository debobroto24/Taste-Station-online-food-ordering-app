import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/product_overview/product_overview.dart';
import 'package:food_app/screens/home/singal_product.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/screens/search/search.dart';
import 'package:provider/provider.dart';
import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductProvider productProvider;

  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fried Rice', style: TextStyle(fontSize: 20)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getHerbsProductDataList,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // physics: NeverScrollableScrollPhysics(),
          child: Row(
            children: productProvider.getHerbsProductDataList.map(
              (herbsProductData) {
                return SingalProduct(
                  onTap: () {
                    // print(
                    //     "check category in home page: ${herbsProductData.category}");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: herbsProductData.productId,
                          productPrice: herbsProductData.productPrice,
                          productName: herbsProductData.productName,
                          productImage: herbsProductData.productImage,
                          productDescription:
                              herbsProductData.productDescription,
                          rate: herbsProductData.rate,
                          totalRate: herbsProductData.totalRate,
                          category: herbsProductData.category,
                        ),
                      ),
                    );
                  },
                  productId: herbsProductData.productId,
                  productPrice: herbsProductData.productPrice,
                  productImage: herbsProductData.productImage,
                  productName: herbsProductData.productName,
                  productUnit: herbsProductData,
                  rate: herbsProductData.rate,
                  totalRate: herbsProductData.totalRate,
                  category: herbsProductData.category,
                );
              },
            ).toList(),
            // children: [

            // ],
          ),
        ),
      ],
    );
  }

  Widget _buildFreshProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Burger', style: TextStyle(fontSize: 20)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getFreshProductDataList,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getFreshProductDataList.map(
              (freshProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: freshProductData.productId,
                          productImage: freshProductData.productImage,
                          productName: freshProductData.productName,
                          productPrice: freshProductData.productPrice,
                          rate: freshProductData.rate,
                          totalRate: freshProductData.totalRate,
                          category: freshProductData.category,
                        ),
                      ),
                    );
                  },
                  productId: freshProductData.productId,
                  productImage: freshProductData.productImage,
                  productName: freshProductData.productName,
                  productPrice: freshProductData.productPrice,
                  productUnit: freshProductData,
                  rate: freshProductData.rate,
                  totalRate: freshProductData.totalRate,
                  category: freshProductData.category,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRootProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pizza', style: TextStyle(fontSize: 20)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getRootProductDataList,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getRootProductDataList.map(
              (rootProductData) {
                return SingalProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: rootProductData.productId,
                          productImage: rootProductData.productImage,
                          productName: rootProductData.productName,
                          productPrice: rootProductData.productPrice,
                          rate: rootProductData.rate,
                          totalRate: rootProductData.totalRate,
                          category: rootProductData.category,
                        ),
                      ),
                    );
                  },
                  productId: rootProductData.productId,
                  productImage: rootProductData.productImage,
                  productName: rootProductData.productName,
                  productPrice: rootProductData.productPrice,
                  productUnit: rootProductData,
                  rate: rootProductData.rate,
                  totalRate: rootProductData.totalRate,
                  category: rootProductData.category,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context, listen: false);
    initproductProvider.fatchHerbsProductData();
    initproductProvider.fatchFreshProductData();
    initproductProvider.fatchRootProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Home',
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color.fromRGBO(255, 183, 123, 123),
            child: IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         Search(search: productProvider.gerAllProductSearch),
                //   ),
                // );
                Navigator.of(context).pushNamed('/search',
                    arguments: productProvider.gerAllProductSearch);
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => ReviewCart(),
                //   ),
                // );
                Navigator.of(context).pushNamed('/review');
              },
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 183, 123, 123),
                radius: 15,
                child: Icon(
                  Icons.shop,
                  size: 17,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/cover.jpg'),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            _buildHerbsProduct(context),
            _buildFreshProduct(context),
            _buildRootProduct(),
          ],
        ),
      ),
    );
  }
}
