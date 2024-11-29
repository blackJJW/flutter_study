import 'package:calander_scheuler/screen/home_screen.dart';
import 'package:calander_scheuler/database/drift_database.dart';
import 'package:calander_scheuler/provider/schedule_provider.dart';
import 'package:calander_scheuler/repository/schedule_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_it/get_it.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  final repository = ScheduleRepository();
  final schedulerProvider = ScheduleProvider(repository: repository);

  runApp(
    ChangeNotifierProvider(
        create: (_) => schedulerProvider,
    child: MaterialApp(
        home: HomeScreen(),
      ),
    )
  );
}

