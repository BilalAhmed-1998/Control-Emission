import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/classes/trip.dart';
import 'package:control_emission/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../cards/circular_progress_card.dart';
import '../services/geo_service.dart';

class TripDetailPage extends StatefulWidget {
  final Trip trip;
  final Vehicle vehicle;

  const TripDetailPage({Key key, this.trip, this.vehicle}) : super(key: key);

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  GoogleMapController myMapController;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  List<LatLng> coordinateList = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  LatLngBounds latLngBounds;


  @override
  void initState() {
    super.initState();
    coordinateList = GeoService().decodeCoordinates(widget.trip.encodedPoints);
    setCustomMarkerIcon();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppBar(''),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Trip Starting Date Time///
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: Color(0xff004040),
                ),
                Text(
                  "  ${DateFormat.yMMMEd().format(widget.trip.startingTime)}, ${DateFormat.jm().format(widget.trip.startingTime)} ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),

            ///Second row///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 23),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_circle_fill,
                            color: Color(0xff004040),
                            size: 20,
                          ),
                          Text(
                            '  ${widget.trip.startingAddress}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff004040),
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Transform.rotate(
                            angle: 90 * pi / 180,
                            child: Icon(
                              Icons.linear_scale,
                              color: Color(0xff004040),
                              size: 20,
                            ),
                          ),
                          Text(
                            '    ',
                            style: TextStyle(
                              color: Color(0xff004040),
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff004040),
                            size: 25,
                          ),
                          Text(
                            '  ${widget.trip.endingAddress}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff004040),
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  CircularProgressCard(
                    width: 45,
                    height: 45,
                    val: widget.vehicle.totalTrips / 5,
                    textColor: Colors.grey.shade600,
                  )
                ],
              ),
            ),

            ///Google Map Routes Container///
            Container(
              height: 4.5*(height/10),
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff004040), width: 1)),
              child: Stack(
                children: [
                  GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: true,
                  compassEnabled: false,
                  scrollGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: widget.trip.startingCoordinates, zoom: 12.8, tilt: 35.5),
                  markers: markerSet,
                  polylines: {
                    Polyline(
                      color: Color(0xff004040),
                      polylineId: PolylineId("PolyLineTrack"),
                      jointType: JointType.round,
                      points: coordinateList,
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

                    latLngBounds = GeoService().getRespectedLatLngBounds(
                        widget.trip.startingCoordinates, coordinateList.last);

                    Future.delayed(const Duration(seconds: 1), () =>
                        myMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 90))
                    );

                    setState(() {});

                  },
                ),
                  FloatingActionButton(
                    mini: true,
                  onPressed: () {


                    setState(() {
                      myMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 120));
                    });
                  },
                  elevation: 2,
                  enableFeedback: true,
                  backgroundColor: Color(0xff004040),
                  child: Icon(
                    Icons.location_searching,
                    color: Colors.white,
                    size: 20,
                  )
                  ),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
              decoration: BoxDecoration(
                  color: Color(0xff004040),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(9.0),
                    bottomRight: Radius.circular(9.0),
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.vehicle.company,
                        style: TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Vehicle',
                        style: TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                      ),
                    ],
                  ),
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Icon(
                      Icons.linear_scale,
                      color: Color(0xffdddddd),
                      size: 25,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.trip.duration,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Color(0xffdddddd),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Time',
                        style: TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                      ),
                    ],
                  ),
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Icon(
                      Icons.linear_scale,
                      color: Color(0xffdddddd),
                      size: 25,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.trip.distance.toStringAsFixed(1)} km',
                        style: TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total Distance',
                        style: TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///Trip Ending Date Time///
            Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 14,
                  color: Color(0xff004040),
                ),
                Text(
                  "  ${DateFormat.yMMMEd().format(widget.trip.endingTime)}, ${DateFormat.jm().format(widget.trip.endingTime)} ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  void setCustomMarkerIcon() async {
    await getBytesFromAsset("assets/images/ending_marker.png", 160)
        .then((currentLocationIconData) {
      destinationIcon = BitmapDescriptor.fromBytes(currentLocationIconData);
    });
    await getBytesFromAsset("assets/images/source_marker.png", 160)
        .then((sourceLocationIconData) {
      sourceIcon = BitmapDescriptor.fromBytes(sourceLocationIconData);
    });
    markerSet.add(
      Marker(
          icon: destinationIcon,
          position: coordinateList.last,
          markerId: MarkerId("CurrentLocation01"),
          draggable: true),
    );
    markerSet.add(
      Marker(
          icon: sourceIcon,
          position: coordinateList.first,
          markerId: MarkerId("SourceLocation01"),
          draggable: true),
    );
    setState(() {});
  }

  @override
  void dispose() {
    myMapController.dispose();
    super.dispose();
  }
}
