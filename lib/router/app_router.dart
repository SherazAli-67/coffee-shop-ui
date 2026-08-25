import 'package:coffee_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/main_menu_page.dart';
import '../presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => WelcomeScreen()),
    StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                path: NamedRoutes.home.routeName,
                builder: (_, _) => HomeScreen())
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: NamedRoutes.favorite.routeName,
                builder: (_, _) => Center(child: Text("Favorites"),))
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: NamedRoutes.shoppingCart.routeName,
                builder: (_, _) => Center(child: Text("Cart Screen"),))
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: NamedRoutes.notifications.routeName,
                builder: (_, _) => Center(child: Text("Notifications Screen"),))
          ]),
        ],
        builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell)),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  favorite('/favorite'),
  shoppingCart('/cart'),
  notifications('/notifications')
  ;

  final String routeName;
  const NamedRoutes(this.routeName);
}