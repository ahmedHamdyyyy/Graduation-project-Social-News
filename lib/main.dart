import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'project/comments/logic/comments_cubit.dart';
import 'config/constants/app_constants/theme.dart';
import 'project/friends/logic/friends_cubit.dart';
import 'core/services/cache/cache_services.dart';
import 'project/global/logic/global_cubit.dart';
import 'project/posts/logic/posts_cubit.dart';
import 'core/services/api/api_services.dart';
import 'project/user/logic/user_cubit.dart';
import 'project/auth/logic/auth_cubit.dart';
import 'l10n/app_localizations.dart';
import 'config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheServices.initialize;
  await ApiServices.initialize;
  runApp(const Uni());
}

class Uni extends StatelessWidget {
  const Uni({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GlobalCubit()..setApp),
            BlocProvider(create: (context) => UserCubit()),
            BlocProvider(create: (context) => PostsCubit()),
            BlocProvider(create: (context) => FriendsCubit()),
            BlocProvider(create: (context) => CommentsCubit()),
            BlocProvider(create: (context) => AuthCubit()),
          ],
          child: BlocBuilder<GlobalCubit, GlobalState>(
            buildWhen: (previous, current) =>
                previous.currentTheme != current.currentTheme || previous.currentLang != current.currentLang,
            builder: (context, state) {
              systemTheme(state);
              return SafeArea(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: Locale(state.currentLang),
                  theme: appThemes(state.currentTheme),
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  onGenerateRoute: (route) => AppRoutes.getRoute(route),
                  initialRoute:
                      context.read<GlobalCubit>().isLoggedIn ? AppRoutes.globalScreen : AppRoutes.loginScreen,
                ),
              );
            },
          ),
        ),
      );
}
