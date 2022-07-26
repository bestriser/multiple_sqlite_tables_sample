import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_sqlite_tables_sample/repository/sqlite_repository.dart';

final _itemsProvider =
    FutureProvider((ref) => ref.read(sqliteRepositoryProvider).getItems());

final itemsProvider = StateNotifierProvider<ItemsController,
    AsyncValue<List<Map<String, dynamic>>>>((ref) {
  final items = ref.watch(_itemsProvider);
  final sqliteRepo = ref.watch(sqliteRepositoryProvider);
  return ItemsController(items, sqliteRepo);
});

class ItemsController
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  ItemsController(this.items, this.sqliteRepo) : super(items);
  final AsyncValue<List<Map<String, dynamic>>> items;
  final SQLiteRepository sqliteRepo;

  Future<void> insertRaw() async {
    final item = await sqliteRepo.insertItemRaw();
    final items = state.value;
    if (items != null) {
      state = AsyncValue.data([...state.value!, item]);
    } else {
      state = AsyncValue.data([item]);
    }
  }
}
