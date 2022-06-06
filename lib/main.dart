import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/main_page.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/ride_form_page.dart';
import 'app_theme_data.dart';
import 'features/manage_work/presentation/pages/ride_details_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

final tRide = Ride(
    id: '1',
    title: Title.herr,
    name: 'Lorem',
    destination: 'Ipsum',
    start: DateTime.now(),
    end: DateTime.now(),
    price: Decimal.parse('29.30'));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Rahmati',
      theme: AppThemeData().lighTheme,
      home: const RideFormPage(),
    );
  }
}
