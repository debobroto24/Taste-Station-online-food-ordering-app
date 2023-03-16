import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  LocationData setLoaction;

  TextEditingController districtFromMap = TextEditingController();
  TextEditingController cityFromMap = TextEditingController();
  TextEditingController mobileNoFromMap = TextEditingController();
  TextEditingController areaFromMap = TextEditingController();
  TextEditingController streetFromMap = TextEditingController();

  void validator(context, myTypeForType) async {
    if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "House number is empty");
    } else if (district.text.isEmpty) {
      Fluttertoast.showToast(msg: "District is empty");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "mobileNo": mobileNo.text,
        "street": street.text,
        "city": city.text,
        "area": area.text,
        "district": district.text,
        "addressType": myTypeForType.toString(),
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void validatorForMap(context, myTypeForMap) async {
    if (mobileNoFromMap.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter your phone number");
    } else if (streetFromMap.text.isEmpty) {
      Fluttertoast.showToast(msg: "Someting went wrong. Please set your location again");
    } else if (cityFromMap.text.isEmpty) {
      Fluttertoast.showToast(msg: "Someting went wrong. Please set your location again");
    } else if (areaFromMap.text.isEmpty) {
      Fluttertoast.showToast(msg: "Someting went wrong. Please set your location again");
    } else if (districtFromMap.text.isEmpty) {
      Fluttertoast.showToast(msg: "Someting went wrong. Please set your location again");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "mobileNo": mobileNoFromMap.text,
        "street": streetFromMap.text,
        "city": cityFromMap.text,
        "area": areaFromMap.text,
        "district": districtFromMap.text,
        "addressType": myTypeForMap.toString(),
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        district: _db.get("district"),
        addressType: _db.get("addressType"),
        area: _db.get("area"),
        city: _db.get("city"),
        mobileNo: _db.get("mobileNo"),
        street: _db.get("street"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

////// Order /////////

  addPlaceOderData({
    List<ReviewCartModel> oderItemList,
    var subTotal,
    var address,
    var shipping,
  }) async {
    FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("MyOrders")
        .doc()
        .set(
      {
        "subTotal": "1234",
        "Shipping Charge": "",
        "Discount": "10",
        "orderItems": oderItemList
            .map((e) => {
                  "orderTime": DateTime.now(),
                  "orderImage": e.cartImage,
                  "orderName": e.cartName,
                  "orderUnit": e.cartUnit,
                  "orderPrice": e.cartPrice,
                  "orderQuantity": e.cartQuantity
                })
            .toList(),
        // "address": address
        //     .map((e) => {
        //           "orderTime": DateTime.now(),
        //           "orderImage": e.cartImage,
        //           "orderName": e.cartName,
        //           "orderUnit": e.cartUnit,
        //           "orderPrice": e.cartPrice,
        //           "orderQuantity": e.cartQuantity
        //         })
        //     .toList(),
      },
    );
  }
}
