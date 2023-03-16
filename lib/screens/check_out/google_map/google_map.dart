import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoading;

class CostomGoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<CostomGoogleMap> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController controller;
  Location _location = Location();
  LocationData myLocation;

  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude, event.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      print("=======start========");
                      await _location.getLocation().then((value) async {
                        var addresses =
                            await geocoading.placemarkFromCoordinates(
                                value.latitude, value.longitude);
                        print("address is : ${addresses}");
                        //                     var first = addresses.first;
                        // print(' ${first.locality}, ${first.},${first.subLocality}, ${first.subAdminArea},
                        //${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

                        // Street   Country  Administrative area == stylhet Locality= city Sublocality = area

                        var first = addresses.first;
                        print("============******+++++++++");
                        // print("district : ${first.administrativeArea}");
                        // print("city : ${first.locality}");
                        // print("area : ${first.subLocality}");
                        // print("street : ${first.street}");
                        // print("============******+++++++++");
                           checkoutProvider.setLoaction = value;
                          checkoutProvider.districtFromMap.text =
                              first.administrativeArea.toString();
                          // checkoutProvider.cityFromMap.text =
                          //     first.subLocality.toString();
                          checkoutProvider.cityFromMap.text = "botesswar";
                              
                          checkoutProvider.areaFromMap.text =
                              first.name.toString();
                          checkoutProvider.streetFromMap.text =
                              first.street.toString();
                        // setState(() {
                        //   print("============******+++++++++");
                        //   checkoutProvider.setLoaction = value;
                        //   checkoutProvider.districtFromMap.text =
                        //       first.administrativeArea.toString();
                        //   checkoutProvider.cityFromMap.text =
                        //       first.locality.toString();
                        //   checkoutProvider.areaFromMap.text =
                        //       first.subLocality.toString();
                        //   checkoutProvider.streetFromMap.text =
                        //       first.street.toString();

                          print("district : ${checkoutProvider.districtFromMap.text}");
                          print("city : ${checkoutProvider.cityFromMap.text}");
                          print("area : ${checkoutProvider.areaFromMap.text}");
                          print("street : ${checkoutProvider.streetFromMap.text}");
                          print("============******+++++++++");
                        // });
                      });
                      print("=======end========");

                      // final coordinates = new Coordinates(
                      //     myLocation.latitude, myLocation.longitude);

                      Navigator.of(context).pop();
                    },
                    color: primaryColor,
                    child: Text("Set Location"),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
