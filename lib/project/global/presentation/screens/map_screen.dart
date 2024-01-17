import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/services/location/location.dart';
import '../../../../models/map/map_point_model.dart';
import '../../logic/global_cubit.dart';
import '../widgets/app_error_msg.dart';
import '../widgets/app_failure_msg.dart';
import '../widgets/app_loading_indicator.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocationServices().checkLocationActivation(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      buildWhen: (previous, current) => previous.mapPoints != current.mapPoints,
      builder: (context, state) {
        switch (state.getMapPointsState) {
          case Status.initial || Status.loading:
            return const AppLoadingIndicator();
          case Status.failure:
            return AppErrorMsg(error: state.error);
          case Status.error:
            return AppFailureMsg(failure: state.msg);
          case Status.success:
            return Map(
              markers: state.mapPoints.isNotEmpty
                  ? List.generate(
                      state.mapPoints.length,
                      (index) {
                        try {
                          return marker(state.mapPoints[index]);
                        } catch (e) {
                          return marker(MapPointModel(
                            point: [randomPoint, randomPoint],
                            ids: state.mapPoints[index].ids,
                          ));
                        }
                      },
                    )
                  : [
                      Marker(
                        point: const LatLng(20.6576576, -1.75768776),
                        builder: (context) => const SizedBox(),
                      ),
                    ],
            );
        }
      },
    );
  }

  double get randomPoint => -90 + Random().nextDouble() * (90 + 90);
  Marker marker(MapPointModel mapPoint) => Marker(
        height: 75,
        width: 75,
        point: LatLng(
          mapPoint.point.first,
          mapPoint.point.last,
        ),
        builder: (context) => InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.mapPointPosts, arguments: mapPoint.ids),
          child: CircleAvatar(
            backgroundColor: mapPoint.ids.length <= 10
                ? const Color.fromARGB(52, 255, 86, 34)
                : (mapPoint.ids.length <= 50
                    ? const Color.fromARGB(83, 255, 86, 34)
                    : const Color.fromARGB(127, 255, 86, 34)),
            radius: 75,
          ),
        ),
      );
}

// ignore: must_be_immutable
class Map extends StatefulWidget {
  const Map({super.key, required this.markers});
  final List<Marker> markers;
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  bool isFirst = true;
  final mapController = MapController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: widget.markers.first.point,
            zoom: 10,
            maxZoom: 15,
            minZoom: 5,
            onTap: (tapPosition, point) => setState(
              () {
                final newMarker = Marker(
                  point: point,
                  builder: (context) => const Icon(
                    Icons.person_pin_circle,
                    color: Colors.blueGrey,
                    size: 40,
                  ),
                );
                if (isFirst) {
                  widget.markers.add(newMarker);
                  isFirst = !isFirst;
                } else {
                  widget.markers.removeLast();
                  widget.markers.add(newMarker);
                }
              },
            ),
          ),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken':
                    'sk.eyJ1IjoiaGt5bSIsImEiOiJjbGpocmdxejMwYjB3M2RueGt6OGYwbDFjIn0.UdifastKcbZ-Dj-Yc0GXvQ',
                'id': 'mapbox/streets-v12',
              },
            ),
            MarkerLayer(markers: widget.markers),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'tag1',
          onPressed: () async {
            if (await LocationServices().checkLocationActivation(context)) {
              await LocationServices().getCurrentPosition.then(
                (location) {
                  mapController.move(
                    LatLng(location.latitude, location.longitude),
                    15,
                  );
                },
              );
            }
          },
          child: const Icon(Icons.local_pizza),
        ),
      );
}
