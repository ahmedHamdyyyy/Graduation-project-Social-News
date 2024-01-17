import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/post/post_model.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_widget.dart';

class GeneratedPostPosts extends StatelessWidget {
  const GeneratedPostPosts({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().getGeneratedPostPosts(id);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostsCubit, PostsState>(
        buildWhen: (previous, current) =>
            previous.getGeneratedPostPostsState !=
            current.getGeneratedPostPostsState,
        builder: (context, state) {
          switch (state.getGeneratedPostPostsState) {
            case Status.initial:
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.success:
              return GPosts(posts: state.getGeneratedPostPosts);
            case Status.error:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppErrorMsg(error: state.error),
                  TextButton(
                    onPressed: () =>
                        context.read<PostsCubit>().getGeneratedPostPosts(id),
                    child: const Text('retry'),
                  ),
                ],
              );
            case Status.failure:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFailureMsg(failure: state.msg),
                  TextButton(
                    onPressed: () =>
                        context.read<PostsCubit>().getGeneratedPostPosts(id),
                    child: const Text('retry'),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class GPosts extends StatelessWidget {
  const GPosts({super.key, required this.posts});
  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: posts.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: posts.length,
                itemBuilder: (context, index) => Post(post: posts[index]),
              )
            : const Center(
                child: Text('no posts until now'),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => Dialog(
              child: SizedBox(
                height: 500,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(posts.first.long, posts.first.lat),
                    zoom: 10,
                    maxZoom: 15,
                    minZoom: 5,
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
                    MarkerLayer(
                      markers: List.generate(
                        posts.length,
                        (index) {
                          try {
                            return Marker(
                              point:
                                  LatLng(posts[index].long, posts[index].lat),
                              builder: (context) =>
                                  const Icon(Icons.location_history),
                            );
                          } catch (e) {
                            return Marker(
                              point: LatLng(randomPoint, randomPoint),
                              builder: (context) =>
                                  const Icon(Icons.location_history),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: const Icon(Icons.location_searching_rounded),
        ),
      );
  double get randomPoint => -90 + Random().nextDouble() * (90 + 90);
}
