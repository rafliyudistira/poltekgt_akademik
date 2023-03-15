import 'package:go_router/go_router.dart';
import 'package:sisfo_pgt/screen/content/Home/content/profile/profilemhs.dart';
import 'package:sisfo_pgt/screen/content/Home/mainmenu.dart';
import 'package:sisfo_pgt/screen/content/auth/loginpage.dart';

class AppRoute {
  GoRouter route = GoRouter(routes: <GoRoute>[
    GoRoute(
        path: "/login", name: 'login', builder: (context, state) => LoginMHS()),
    GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => MainMenu(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => ProfileMHS(),
          )
        ])
  ], initialLocation: "/login", routerNeglect: true);
}
