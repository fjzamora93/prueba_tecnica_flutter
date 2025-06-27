

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/child_usecase.dart';

final childrenListProvider = AsyncNotifierProvider<ChildrenNotifier, List<Child>>(
  ChildrenNotifier.new,
);

class ChildrenNotifier extends AsyncNotifier<List<Child>> {

  late final ChildUsecase _childUsecase;

  @override
  Future<List<Child>> build() async {
    return await ref.read(childUseCaseProvider).getChildren();
  }

  Future<void> fetchChildren() async {
    state = const AsyncValue.loading();
    try {
      final children = await _childUsecase.getChildren();
      state = AsyncValue.data(children);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}