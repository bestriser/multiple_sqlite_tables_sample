import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_sqlite_tables_sample/presentation/folders/folders_page.dart';
import 'package:multiple_sqlite_tables_sample/presentation/items/items_page.dart';
import 'package:multiple_sqlite_tables_sample/presentation/root/root_controller.dart';

class RootPage extends ConsumerWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rootProvider);
    final controller = ref.watch(rootProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Multiple SQLite tables sample')),
      body: const [FoldersPage(), ItemsPage()][state],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state,
        onTap: controller.onTapBottomNavi,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Folders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon_outlined),
            label: 'Items',
          ),
        ],
      ),
    );
  }
}
