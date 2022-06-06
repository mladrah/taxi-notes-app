import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/domain/entities/ride.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/main_page.dart';
import 'app_theme_data.dart';
import 'core/routing/route_generator.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

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
    return BlocProvider(
      create: (context) => sl<ManageWorkBloc>()..add(LoadAllRides()),
      child: MaterialApp(
        title: 'Taxi Rahmati',
        theme: AppThemeData().lighTheme,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
