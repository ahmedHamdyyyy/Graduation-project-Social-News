import 'package:flutter/material.dart';
import '../../../core/services/cache/cache_services.dart';
import '../../../models/user/user_model.dart';
import '../../../project/global/presentation/screens/map_screen.dart';
import '../../../project/posts/presentation/screens/global_posts.dart';
import '../../../project/posts/presentation/screens/summary_posts.dart';
import '../../../project/user/presentation/screens/profile_screen.dart';

enum Status { initial, loading, success, error, failure }

enum Filter { non, world, sports, business, science }

enum ErrorType {
  non,
  cache,
  network,
  server400,
  server401,
  server403,
  server404,
  server500,
  unKnown,
  user,
}

const logoImage = 'assets/images/logo.png';
const personImage = 'assets/images/person.png';
const loadingAsset = 'assets/images/95076-loading-dots.json';

UserModel get profileData => UserModel.fromJson(CacheServices.shared.getString('user')!);

final List<Widget> screens = [
  const MapScreen(),
  const GlobalPosts(),
  const SummaryPosts(),
  const ProfileScreen(),
];
