import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootProvider =
    StateNotifierProvider<RootController, int>((ref) => RootController());

class RootController extends StateNotifier<int> {
  RootController() : super(0);

  void onTapBottomNavi(int index) => state = index;
}
