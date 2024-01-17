import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project/auth/logic/auth_cubit.dart';
import '../../project/auth/presentation/screens/login_screen.dart';
import '../../project/auth/presentation/screens/register_screen.dart';
import '../../project/comments/logic/comments_cubit.dart';
import '../../project/comments/presentation/screens/comments_screen.dart';
import '../../project/friends/presentation/screens/friends_screen.dart';
import '../../project/global/presentation/screens/about_screen.dart';
import '../../project/global/presentation/screens/global_home.dart';
import '../../project/global/presentation/screens/search_screen.dart';
import '../../project/posts/presentation/screens/generated_post_posts.dart';
import '../../project/posts/presentation/screens/map_point_posts.dart';
import '../../project/posts/presentation/screens/post_screen.dart';
import '../../project/user/presentation/screens/setting_screen.dart';
import '../../project/user/presentation/screens/user_screen.dart';

class AppRoutes {
  static const loginScreen = '/login';
  static const registrationScreen = '/registration';
  static const globalScreen = '/globalHome';
  static const searchScreen = '/searchScreen';
  static const friendsScreen = '/friendsScreen';
  static const userScreen = '/userScreen';
  static const postScreen = '/postScreen';
  static const settingScreen = '/settingScreen';
  static const commentsScreen = '/commentsScreen';
  static const generatedPostPosts = '/generatedPostPosts';
  static const mapPointPosts = '/mapPointPosts';
  static const aboutScreen = '/aboutScreen';

  static Route? getRoute(RouteSettings route) {
    switch (route.name) {
      case loginScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => BlocProvider.value(
            value: AuthCubit(),
            child: const LoginScreen(),
          ),
        );
      case registrationScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => BlocProvider.value(
            value: AuthCubit(),
            child: const RegistrationScreen(),
          ),
        );
      case commentsScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => BlocProvider.value(
            value: CommentsCubit(),
            child: CommentsScreen(postId: route.arguments as String),
          ),
        );
      case globalScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => const GlobalHome(),
        );
      case searchScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => SearchScreen(),
        );
      case friendsScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => FriendsScreen(
            isFollowers:
                (route.arguments as Map<String, dynamic>)['isFollowers'],
            isUser: (route.arguments as Map<String, dynamic>)['isUser'],
            id: (route.arguments as Map<String, dynamic>)['id'],
          ),
        );
      case userScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => UserScreen(id: route.arguments as String),
        );
      case aboutScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => const AboutScreen(),
        );
      case generatedPostPosts:
        return MaterialPageRoute(
          settings: route,
          builder: (context) =>
              GeneratedPostPosts(id: route.arguments as String),
        );
      case mapPointPosts:
        return MaterialPageRoute(
          settings: route,
          builder: (context) =>
              MapPointPosts(ids: route.arguments as List<String>),
        );
      case postScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => PostScreen(id: route.arguments as String),
        );
      case settingScreen:
        return MaterialPageRoute(
          settings: route,
          builder: (context) => const SettingScreen(),
        );
      default:
        return null;
    }
  }
}
