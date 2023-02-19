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
enum AddressTypes2 {
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
  var myTypeForType = AddressTypes.Home;
  var myTypeForMap = AddressTypes2.Home;
  var myType2 = AddressTypesZilla.Sylhet;
  int selected = -1;
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
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //   height: 48,
      //   child: checkoutProvider.isloadding == false
      //       ? MaterialButton(
      //           onPressed: () {
      //             checkoutProvider.validator(context, myType);
      //           },
      //           child: Text(
      //             "Add Address",
      //             style: TextStyle(
      //               color: textColor,
      //             ),
      //           ),
      //           color: primaryColor,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(
      //               30,
      //             ),
      //           ),
      //         )
      //       : Center(
      //           child: CircularProgressIndicator(),
      //         ),
      // ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "select one of these",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 30),

            ExpansionPanelList.radio(
              children: [
                // type address
                ExpansionPanelRadio(
                    value: 1,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text("Put your address"),
                      );
                    },
                    body: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            CostomTextField(
                              labText: "Mobile No",
                              controller: checkoutProvider.mobileNo,
                            ),
                            CostomTextField(
                              labText: "Street",
                              controller: checkoutProvider.street,
                            ),
                            CostomTextField(
                              labText: "City",
                              controller: checkoutProvider.city,
                            ),
                            CostomTextField(
                              // area
                              labText: "area",
                              controller: checkoutProvider.area,
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
                                    checkoutProvider.district.text = "Dhaka";
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
                                  checkoutProvider.district.text = "Sylhet";
                                  myType2 = value;
                                });
                              },
                              // secondary: Icon(
                              //   Icons.work,
                              //   color: primaryColor,
                              // ),
                            ),
                            ListTile(
                              title: Text("Address Type*"),
                            ),
                            RadioListTile(
                              activeColor: primaryColor,
                              value: AddressTypes.Home,
                              groupValue: myTypeForType,
                              title: Text("Home"),
                              onChanged: (AddressTypes value) {
                                setState(() {
                                  myTypeForType = value;
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
                              groupValue: myTypeForType,
                              title: Text("Work"),
                              onChanged: (AddressTypes value) {
                                setState(() {
                                  myTypeForType = value;
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
                              groupValue: myTypeForType,
                              title: Text("Other"),
                              onChanged: (AddressTypes value) {
                                setState(() {
                                  myTypeForType = value;
                                });
                              },
                              secondary: Icon(
                                Icons.devices_other,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 48,
                              child: checkoutProvider.isloadding == false
                                  ? MaterialButton(
                                      onPressed: () {
                                        checkoutProvider.validator(
                                            context, myTypeForType);
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
                          ],
                        ))),
               
                // map address
                ExpansionPanelRadio(
                  value: 2,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text("Set Currnent Location"),
                    );
                  },
                  body: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
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
                                    : Text("You Location is set!"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        CostomTextField(
                          labText: "Mobile No",
                          controller: checkoutProvider.mobileNoFromMap,
                        ),
                        ListTile(
                          title: Text("Address Type*"),
                        ),
                        RadioListTile(
                          activeColor: primaryColor,
                          value: AddressTypes2.Home,
                          groupValue: myTypeForMap,
                          title: Text("Home"),
                          onChanged: (AddressTypes2 value) {
                            setState(() {
                              myTypeForMap = value;
                            });
                          },
                          secondary: Icon(
                            Icons.home,
                            color: primaryColor,
                          ),
                        ),
                        RadioListTile(
                          activeColor: primaryColor,
                          value: AddressTypes2.Work,
                          groupValue: myTypeForMap,
                          title: Text("Work"),
                          onChanged: (AddressTypes2 value) {
                            setState(() {
                              myTypeForMap = value;
                            });
                          },
                          secondary: Icon(
                            Icons.work,
                            color: primaryColor,
                          ),
                        ),
                        RadioListTile(
                          activeColor: primaryColor,
                          value: AddressTypes2.Other,
                          groupValue: myTypeForMap,
                          title: Text("Other"),
                          onChanged: (AddressTypes2 value) {
                            setState(() {
                              myTypeForMap = value;
                            });
                          },
                          secondary: Icon(
                            Icons.devices_other,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 48,
                          child: checkoutProvider.isloadding == false
                              ? MaterialButton(
                                  onPressed: () {
                                    checkoutProvider.validatorForMap(context, myTypeForMap);
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
                      ],
                    ),
                  ),
                ),
              ],
            )
            // CostomTextField(
            //   labText: "Pincode",
            //   controller: checkoutProvider.pincode,
            // ),
          ],
        ),
      ),
    );
  }
}
