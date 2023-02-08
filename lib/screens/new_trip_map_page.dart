import 'dart:async';
import 'dart:ui';

import 'package:control_emission/services/geo_service.dart';
import 'package:control_emission/classes/trip.dart';
import 'package:control_emission/screens/home_page.dart';
import 'package:control_emission/services/firestore_database.dart';
import 'package:control_emission/widgets/custom_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../cards/loading_card.dart';

class NewTripMapPage extends StatefulWidget {
  String vehicleDocId;
  LatLng currentCoordinates;

  NewTripMapPage({Key key, this.currentCoordinates, this.vehicleDocId})
      : super(key: key);

  @override
  State<NewTripMapPage> createState() => _NewTripMapPageState();
}

class _NewTripMapPageState extends State<NewTripMapPage> {
  GoogleMapController myMapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool zoomOut = false;
  DateTime startingTime = DateTime.now();
  double totalDistance = 0.0;
  StreamSubscription<Position> _positionStream;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  List<LatLng> coordinateList = [];
  List<LatLng> coordinateSubList = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};

  final LocationSettings locationSettings =
      LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
  int counter = 0;

  @override
  void initState() {
    super.initState();
    setCustomMarkerIcon();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                  target: widget.currentCoordinates, zoom: 14.8, tilt: 35.5),
              markers: markerSet,
              polylines: {
                Polyline(
                  color: Color(0xff004040),
                  polylineId: PolylineId("PolyLineTrack"),
                  jointType: JointType.round,
                  points: coordinateSubList,
                  width: 6,
                  startCap: Cap.roundCap,
                  endCap: Cap.squareCap,
                  geodesic: true,
                ),
              },
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                controller.setMapStyle('''
              [
  {
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#f5f5f5"
        }
      ]
  },
  {
      "elementType": "labels.icon",
      "stylers": [
        {
            "visibility": "off"
        }
      ]
  },
  {
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#616161"
        }
      ]
  },
  {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
            "color": "#f5f5f5"
        }
      ]
  },
  {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#bdbdbd"
        }
      ]
  },
  {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#eeeeee"
        }
      ]
  },
  {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#757575"
        }
      ]
  },
  {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#e5e5e5"
        }
      ]
  },
  {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#9e9e9e"
        }
      ]
  },
  {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#ffffff"
        }
      ]
  },
  {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#757575"
        }
      ]
  },
  {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#dadada"
        }
      ]
  },
  {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#616161"
        }
      ]
  },
  {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#9e9e9e"
        }
      ]
  },
  {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#e5e5e5"
        }
      ]
  },
  {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#eeeeee"
        }
      ]
  },
  {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
            "color": "#c9c9c9"
        }
      ]
  },
  {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
            "color": "#9e9e9e"
        }
      ]
  }
]''');
                myMapController = await _controller.future;
                if (!mounted) return;

                _positionStream = Geolocator.getPositionStream(
                        locationSettings: locationSettings)
                    .listen((Position position) {
                  markerSet.add(
                    Marker(
                        icon: currentLocationIcon,
                        position: widget.currentCoordinates,
                        markerId: MarkerId("CurrentLocation01"),
                        draggable: true),
                  );
                  updatePosition(LatLng(position.latitude, position.longitude));
                });
              },
            ),
            Positioned(
              top: 80,
              left: 25,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => CustomConfirmationDialog(
                            text: 'Do you want to cancel the trip?',
                          ));
                },
                child: Icon(
                  Icons.cancel,
                  size: 28,
                  color: Colors.black.withOpacity(.2),
                ),
              ),
            ),
            Positioned(
              top: 80,
              right: 25,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff004040).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20)),
                  width: 80,
                  height: 40,
                  child: Text(
                    "${totalDistance.toStringAsFixed(1)} km",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                ),
              ),
            )
          ]),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                zoomOut = !zoomOut;

                setState(() {
                  myMapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: widget.currentCoordinates,
                          zoom: !zoomOut ? 14.8 : 12.8,
                          tilt: 35.5)));
                });
              },
              elevation: 2,
              enableFeedback: true,
              backgroundColor: Color(0xff004040),
              child: !zoomOut
                  ? Icon(
                      Icons.center_focus_strong,
                      color: Colors.white,
                      size: 24,
                    )
                  : Icon(
                      Icons.center_focus_strong_outlined,
                      color: Colors.white,
                      size: 24,
                    )),
          bottomNavigationBar: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text(
                          'End Trip',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        content: Text(
                          'Do you want to end the trip?',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => LoadingCard(
                                        text: "Saving your trip...",
                                      ));

                              ///ALL WORKING of a Trip///

                              DateTime endingTime = DateTime.now();
                              String hours = endingTime
                                  .difference(startingTime)
                                  .inHours
                                  .toString();
                              String minutes = endingTime
                                  .difference(startingTime)
                                  .inMinutes
                                  .toString();
                              String encodedString =
                                  GeoService().encodeCoordinates(coordinateList);
                              String startingAddress = await GeoService()
                                  .addressFromCoordinates(coordinateList.first);
                              String endingAddress = await GeoService()
                                  .addressFromCoordinates(coordinateList.last);
                              if (!mounted) return;
                              await FireStoreDatabase.setNewTrip(
                                  widget.vehicleDocId,
                                  Trip(
                                    distance: totalDistance,
                                    startingAddress: startingAddress,
                                    endingAddress: endingAddress,
                                    startingCoordinates: coordinateList.first,
                                    endingCoordinates: coordinateList.last,
                                    startingTime: startingTime,
                                    endingTime: endingTime,
                                    duration: "${hours}h ${minutes}m",
                                    encodedPoints: encodedString,
                                  ),
                                  context);
                              if (!mounted) return;
                              await FireStoreDatabase.updateVehicleTrips(
                                  widget.vehicleDocId, context);
                              if (!mounted) return;
                              await FireStoreDatabase.updateTotalTrips(context);
                              if (!mounted) return;
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomePage.routeName, (route) => false);

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('Trip has been saved successfully!')));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff004040),
                            ),
                            child: Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff004040),
                            ),
                            child: Text('No'),
                          ),
                        ],
                      ));
            },
            child: Container(
              width: width,
              height: 60,
              margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color(0xff004040),
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: Text(
                'End Trip',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }

  void setCustomMarkerIcon() async {
    await getBytesFromAsset("assets/images/user_icon.png", 150)
        .then((currentLocationIconData) {
      currentLocationIcon = BitmapDescriptor.fromBytes(currentLocationIconData);
    });
    await getBytesFromAsset("assets/images/source_marker.png", 160)
        .then((sourceLocationIconData) {
      sourceIcon = BitmapDescriptor.fromBytes(sourceLocationIconData);
    });
    markerSet.add(
      Marker(
          icon: currentLocationIcon,
          position: widget.currentCoordinates,
          markerId: MarkerId("CurrentLocation01"),
          draggable: true),
    );
    markerSet.add(
      Marker(
          icon: sourceIcon,
          position: widget.currentCoordinates,
          markerId: MarkerId("SourceLocation01"),
          draggable: true),
    );
    setState(() {});
  }

  void updatePosition(LatLng latLng) {
    counter++;

    widget.currentCoordinates = latLng;
    if (counter % 8 == 0) {
      myMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    }

      if(coordinateList.length>2){
        coordinateSubList =
            coordinateList.getRange(0, coordinateList.length ).toList();
      }

    print('${latLng.latitude.toString()}, ${latLng.longitude.toString()}');
    print("total distance: $totalDistance");
    print("Total Time: ${DateTime.now().difference(startingTime)}");
    coordinateList.add(latLng);
    totalDistance = GeoService().calculateTotalDistance(coordinateList);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    myMapController.dispose();
    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }
}
