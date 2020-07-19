import 'dart:ffi';
import 'dart:typed_data';
import 'package:student_coloco_rest_api/models/Location.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:latlong/latlong.dart';

class MarkerManager extends StatefulWidget {
  final String title;
  final Location monument;
  MarkerManager({Key key, this.title , this.monument}) : super(key: key);

  @override
  _MarkerManagerState createState() => _MarkerManagerState();
}

class _MarkerManagerState extends State<MarkerManager> {

  //final AuthService _authService = AuthService();
  final PopupController _popupLayerController = PopupController();
  final PopupController _popupController = PopupController();

  List<Marker> markers;
  int pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.blueGrey[100],
        elevation: 0.0,
        actions: <Widget>[
          //FlatButton.icon( icon:Icon(Icons.person), label: Text('profile'),
      //onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},),
         // FlatButton.icon( icon: Icon(Icons.exit_to_app), label: Text('logout') ,
    //onPressed: ()
          //async { await _authService.logout();},),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          plugins: <MapPlugin>[PopupMarkerPlugin()],
          center: LatLng(double.parse(widget.monument.lat), double.parse(widget.monument.long)),
          zoom: 15.0,
          interactive: true,
          onTap: (_) => _popupLayerController.hidePopup(),
        ),
        layers: <LayerOptions>[
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: <String>['a', 'b', 'c'],
          ),
          PopupMarkerLayerOptions(
            markers: <Marker>[
              LocationMarker(
                monument: Location(
                  titre: widget.monument.titre,
                  lat: widget.monument.lat,
                  long: widget.monument.long,
                ),
              ),
            ],
            popupController: _popupLayerController,
            popupBuilder: (_, Marker marker) {
              if (marker is LocationMarker) {
                return LocationMarkerPopup(monument: marker.monument);
              }
              return Card(child: const Text('Not a monument'));
            },
          ),
        ],
      ),
    );
  }
}




class LocationMarker extends Marker {

  LocationMarker({@required this.monument})
      : super(
    anchorPos: AnchorPos.align(AnchorAlign.top),
    height: Location.size,
    width: Location.size,

    point: LatLng( double.parse(monument.lat), double.parse(monument.long)),
    builder: (BuildContext ctx) => Icon(Icons.pin_drop),
  );

  final Location monument;
}

class LocationMarkerPopup extends StatelessWidget {
  const LocationMarkerPopup({Key key, this.monument}) : super(key: key);
  final Location monument;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(monument.titre),
            Text('${monument.lat}-${monument.long}'),
          ],
        ),
      ),
    );
  }
}

