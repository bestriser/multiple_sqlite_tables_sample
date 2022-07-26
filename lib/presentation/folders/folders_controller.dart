import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_sqlite_tables_sample/repository/sqlite_repository.dart';

final _foldersProvider =
    FutureProvider((ref) => ref.read(sqliteRepositoryProvider).getFolders());

final foldersProvider = StateNotifierProvider<FoldersController,
    AsyncValue<List<Map<String, dynamic>>>>((ref) {
  final folders = ref.watch(_foldersProvider);
  final sqliteRepo = ref.watch(sqliteRepositoryProvider);
  return FoldersController(folders, sqliteRepo);
});

class FoldersController
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  FoldersController(this.folders, this.sqliteRepo) : super(folders);
  final AsyncValue<List<Map<String, dynamic>>> folders;
  final SQLiteRepository sqliteRepo;

  Future<void> insertRaw() async {
    final folder = await sqliteRepo.insertFolderRaw();
    final folders = state.value;
    if (folders != null) {
      state = AsyncValue.data([...state.value!, folder]);
    } else {
      state = AsyncValue.data([folder]);
    }
  }
}
