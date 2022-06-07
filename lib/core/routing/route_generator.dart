import 'package:flutter/material.dart';
import 'package:taxi_rahmati/features/manage_work/domain/usecases/add_ride.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/main_page.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/ride_details_page.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/ride_form_page.dart';

import '../../features/manage_work/domain/entities/ride.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args;

    if (settings.arguments != null) {
      args = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
          settings: const RouteSettings(name: '/'),
        );

      case '/rideForm':
        return MaterialPageRoute(
          builder: (_) => const RideFormPage(),
          settings: const RouteSettings(name: '/rideForm'),
        );

      case '/rideDetails':
        final ride = args!['ride'] as Ride;
        return MaterialPageRoute(
            builder: (_) => RideDetailsPage(
                  ride: ride,
                ),
            settings: const RouteSettings(name: '/rideDetails'));

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
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}
