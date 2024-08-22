import 'package:flutter_clean_architecture/features/profile/presentation/pages/splashscreen_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/profile/presentation/pages/detail_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class RouterPage {
  get router => GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SplashscreenPage(),
            routes: [
              GoRoute(
                path: 'profile-page',
                name: 'profile_page',
                builder: (context, state) => const ProfilePage(),
              ),
              GoRoute(
                path: 'detail-profile-page',
                name: 'detail_profile_page',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: DetailProfilePage(
                    state.extra as int,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
