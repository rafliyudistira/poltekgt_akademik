import 'package:go_router/go_router.dart';
import 'package:sisfo_pgt/screen/content/Home/content/changePass/changePassword.dart';
import 'package:sisfo_pgt/screen/content/Home/content/dataNilai/datanilai.dart';
import 'package:sisfo_pgt/screen/content/Home/content/dataNilai/nilaiAk.dart';
import 'package:sisfo_pgt/screen/content/Home/content/point/point.dart';
import 'package:sisfo_pgt/screen/content/Home/content/profile/profilemhs.dart';
import 'package:sisfo_pgt/screen/content/Home/mainmenu.dart';
import 'package:sisfo_pgt/screen/content/auth/forgotpass/forgot_pass.dart';
import 'package:sisfo_pgt/screen/content/auth/loginpage.dart';

class AppRoute {
  GoRouter route = GoRouter(routes: <GoRoute>[
    GoRoute(
        path: "/login", name: 'login', builder: (context, state) => LoginMHS()),
    GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => MainMenu(goRouterState: state),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => ProfileMHS(goRouterState: state),
          ),
          GoRoute(
              path: 'akademik',
              name: 'akademik',
              builder: (context, state) => NilaiAkademik(goRouterState: state)),
          GoRoute(
              path: 'point',
              name: 'point',
              builder: (context, state) => Point(goRouterState: state)),
          GoRoute(
              path: "ubahpw",
              name: 'ubahpw',
              builder: (context, state) => ChangePass()),
        ])
  ], initialLocation: "/login", routerNeglect: true);
}
