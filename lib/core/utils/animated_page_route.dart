/// Animated Page Route
/// 
/// Custom page transitions with animations

import 'package:flutter/material.dart';

/// Fade transition route
class FadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

/// Slide transition route (from right)
class SlideRightRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 350),
        );
}

/// Scale and fade transition route
class ScaleRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScaleRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeInOutCubic;
            var scaleTween = Tween<double>(begin: 0.8, end: 1.0).chain(
              CurveTween(curve: curve),
            );
            var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

            return ScaleTransition(
              scale: animation.drive(scaleTween),
              child: FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
}

/// Bottom to top slide transition
class SlideUpRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideUpRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
}

/// Rotation transition
class RotationRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  RotationRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeInOut;
            var rotationTween = Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );
            var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

            return FadeTransition(
              opacity: animation.drive(fadeTween),
              child: RotationTransition(
                turns: animation.drive(rotationTween),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}

/// Extension on BuildContext for easy navigation with animations
extension AnimatedNavigation on BuildContext {
  Future<T?> pushWithFade<T>(Widget page) {
    return Navigator.of(this).push<T>(FadeRoute(page: page));
  }

  Future<T?> pushWithSlide<T>(Widget page) {
    return Navigator.of(this).push<T>(SlideRightRoute(page: page));
  }

  Future<T?> pushWithScale<T>(Widget page) {
    return Navigator.of(this).push<T>(ScaleRoute(page: page));
  }

  Future<T?> pushWithSlideUp<T>(Widget page) {
    return Navigator.of(this).push<T>(SlideUpRoute(page: page));
  }

  Future<T?> pushReplacementWithFade<T, TO>(Widget page) {
    return Navigator.of(this).pushReplacement<T, TO>(FadeRoute(page: page));
  }

  Future<T?> pushReplacementWithSlide<T, TO>(Widget page) {
    return Navigator.of(this).pushReplacement<T, TO>(SlideRightRoute(page: page));
  }
}
