import 'package:auto_route/auto_route.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: FrameRoute.page,
          initial: true,
        ),
        AutoRoute(page: BookRoute.page),
        AutoRoute(page: DetailRoute.page)
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
