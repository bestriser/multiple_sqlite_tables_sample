import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_sqlite_tables_sample/presentation/folders/folders_controller.dart';

class FoldersPage extends ConsumerWidget {
  const FoldersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(folderProvider);
    final controller = ref.watch(folderProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Multiple SQLite tables sample')),
      body: state.when(
        loading: () => const Text('読み込み中...'),
        error: (error, _) => Text(error.toString()),
        data: (folders) => Text(folders.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.insertRaw(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
