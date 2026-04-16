import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/home/screens/home_shell.dart';
import '../../features/discover/screens/discover_screen.dart';
import '../../features/discover/screens/dog_detail_screen.dart';
import '../../features/map/screens/map_screen.dart';
import '../../features/services/screens/services_screen.dart';
import '../../features/chat/screens/chat_list_screen.dart';
import '../../features/chat/screens/chat_detail_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/add_dog_screen.dart';
import '../../features/home/screens/landing_screen.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // ── Public / Landing ──
      GoRoute(
        path: '/',
        name: 'landing',
        builder: (context, state) => const LandingScreen(),
      ),

      // ── Auth ──
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ── Main App (with bottom nav shell) ──
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/discover',
            name: 'discover',
            builder: (context, state) => const DiscoverScreen(),
            routes: [
              GoRoute(
                path: ':dogId',
                name: 'dogDetail',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => DogDetailScreen(
                  dogId: state.pathParameters['dogId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/walks',
            name: 'walks',
            builder: (context, state) => const MapScreen(),
          ),
          GoRoute(
            path: '/services',
            name: 'services',
            builder: (context, state) => const ServicesScreen(),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatListScreen(),
            routes: [
              GoRoute(
                path: ':chatId',
                name: 'chatDetail',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => ChatDetailScreen(
                  chatId: state.pathParameters['chatId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'editProfile',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const EditProfileScreen(),
              ),
              GoRoute(
                path: 'add-dog',
                name: 'addDog',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AddDogScreen(),
              ),
            ],
          ),
        ],
      ),
    ],

    // Redirect logic: check auth state
    redirect: (context, state) {
      // TODO: Wire up auth state from Riverpod provider.
      // final isLoggedIn = ref.read(authProvider).isLoggedIn;
      // final isAuthRoute = state.matchedLocation.startsWith('/login') ||
      //     state.matchedLocation.startsWith('/register');
      //
      // if (!isLoggedIn && !isAuthRoute && state.matchedLocation != '/') {
      //   return '/login';
      // }
      return null;
    },
  );
}
