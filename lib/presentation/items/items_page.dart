import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_sqlite_tables_sample/presentation/items/items_controller.dart';

class ItemsPage extends ConsumerWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemsProvider);
    final controller = ref.watch(itemsProvider.notifier);

    return Scaffold(
      body: state.when(
        loading: () => const Text('読み込み中...'),
        error: (error, _) => Text(error.toString()),
        data: (items) => Text(items.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.insertRaw(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
