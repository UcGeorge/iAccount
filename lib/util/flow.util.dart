import 'package:flutter/material.dart';

class FlowUtil {
  static Route<T> createRoute<T>({required Widget page, String? name}) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: name),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Future<T?> moveToAndReplace<T extends Object, TO extends Object>({
    required BuildContext context,
    required Widget page,
    String? name,
  }) {
    return Navigator.of(context).pushReplacement(
      FlowUtil.createRoute<T>(
        page: page,
        name: name,
      ),
    );
  }

  static Future<T?> moveToAndRemoveAll<T extends Object>({
    required BuildContext context,
    required Widget page,
    String? name,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      FlowUtil.createRoute<T>(page: page, name: name),
      (route) => false,
    );
  }

  static Future<T?> moveTo<T extends Object>({
    required BuildContext context,
    required Widget page,
    String? name,
  }) {
    return Navigator.of(context).push(
      FlowUtil.createRoute<T>(
        page: page,
        name: name,
      ),
    );
  }

  static void back<T extends Object>({
    required BuildContext context,
    T? result,
  }) {
    Navigator.pop<T>(context, result);
  }

  static void backTo(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  static void moveToAndRemoveUtil(
      BuildContext context, Widget newPage, String pageName) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => newPage),
        ModalRoute.withName(pageName));
  }
}
