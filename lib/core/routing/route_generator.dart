import 'package:flutter/material.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/work_unit_page.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/main_page.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/ride_details_page.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/ride_form_page.dart';

import '../../features/manage_work/domain/entities/ride.dart';
import '../../features/manage_work/domain/entities/work_unit.dart';
import '../../features/manage_work/presentation/pages/rides_print_preview_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args;

    if (settings.arguments != null) {
      args = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainPage(),
          settings: const RouteSettings(name: '/'),
        );

      case '/workUnit':
        WorkUnit? workUnit = args?['workUnit'] as WorkUnit?;
        return MaterialPageRoute(
          builder: (_) => WorkUnitPage(workUnit: workUnit),
          settings: const RouteSettings(name: '/workUnit'),
        );

      case '/rideForm':
        WorkUnit? workUnit = args?['workUnit'] as WorkUnit?;
        Ride? ride = args?['ride'] as Ride?;

        return MaterialPageRoute(
          builder: (_) => RideFormPage(workUnit: workUnit, ride: ride),
          settings: const RouteSettings(name: '/rideForm'),
        );

      case '/rideDetails':
        WorkUnit workUnit = args?['workUnit'] as WorkUnit;
        final ride = args!['ride'] as Ride;

        return MaterialPageRoute(
            builder: (_) => RideDetailsPage(
                  workUnit: workUnit,
                  ride: ride,
                ),
            settings: const RouteSettings(name: '/rideDetails'));
      case '/ridesPrintPreview':
        final workUnit = args!['workUnit'] as WorkUnit;
        return MaterialPageRoute(
            builder: (_) => RidesPrintPreviewPage(
                  workUnit: workUnit,
                ),
            settings: const RouteSettings(name: '/ridesPrintPreview'));

      default:
        return _errorRoute(settings.name);
    }
  }

  // ignore: unused_element
  static Route _createAnimatedRoute(Widget route, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            'Route ${routeName!} does not exist',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }
}
