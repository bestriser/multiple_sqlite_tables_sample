import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_sqlite_tables_sample/presentation/root/root_page.dart';
import 'package:multiple_sqlite_tables_sample/repository/sqlite_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLiteRepository().openOrCreate();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple SQLite tables sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RootPage(),
    );
  }
}
