import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/screens/check_out/google_map/google_map.dart';
import 'package:food_app/widgets/costom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

enum AddressTypesZilla {
  None,
  Dhaka,
  Sylhet,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  var myType2 = AddressTypesZilla.Sylhet;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            // CostomTextField(
            //   labText: "First name",
            //   controller: checkoutProvider.firstName,
            // ),
            // CostomTextField(
            //   labText: "Last name",
            //   controller: checkoutProvider.lastName,
            // ),
            CostomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo,
            ),
            // CostomTextField(
            //   labText: "Alternate Mobile No",
            //   controller: checkoutProvider.alternateMobileNo,
            // ),
            // CostomTextField(
            //   labText: "Scoiety",
            //   controller: checkoutProvider.scoiety,
            // ),
            CostomTextField(
              labText: "Street",
              controller: checkoutProvider.street,
            ),
            // CostomTextField(
            //   labText: myType2 == AddressTypesZilla.Sylhet ? "Sylhet" : "Dhaka",
            //   controller: checkoutProvider.landmark,
            // ),
            CostomTextField(
              labText: "City",
              controller: checkoutProvider.city,
            ),
            CostomTextField(
              // area
              labText: "House number",
              controller: checkoutProvider.aera,
            ),
            ListTile(
              title: Text("Select District"),
            ),
            RadioListTile(
              activeColor: primaryColor,
              value: AddressTypesZilla.Dhaka,
              groupValue: myType2,
              title: Text("Dhaka"),
              onChanged: (AddressTypesZilla value) {
                setState(() {
                  myType2 = value;
                });
              },
              // secondary: Icon(
              //   Icons.home,
              //   color: primaryColor,
              // ),
            ),
            RadioListTile(
              activeColor: primaryColor,
              value: AddressTypesZilla.Sylhet,
              groupValue: myType2,
              title: Text("Sylhet"),
              onChanged: (AddressTypesZilla value) {
                setState(() {
                  myType2 = value;
                });
              },
              // secondary: Icon(
              //   Icons.work,
              //   color: primaryColor,
              // ),
            ),
            Divider(
              color: Colors.black,
            ),
            // CostomTextField(
            //   labText: "Pincode",
            //   controller: checkoutProvider.pincode,
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CostomGoogleMap(),
                  ),
                );
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLoaction == null
                        ? Text("Set Loaction")
                        : Text("Done!"),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              activeColor: primaryColor,
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.home,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              activeColor: primaryColor,
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.work,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              activeColor: primaryColor,
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.devices_other,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
