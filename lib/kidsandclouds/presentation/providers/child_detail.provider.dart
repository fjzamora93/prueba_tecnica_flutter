

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/child_usecase.dart';

final childDetailProvider = AsyncNotifierProvider<ChildNotifier, Child>(
  ChildNotifier.new,
);

class ChildNotifier extends AsyncNotifier<Child> {

  late final ChildUsecase _childUsecase;

  @override
  Future<Child> build() async {
    _childUsecase = ref.read(childUseCaseProvider);
    // Initialize with a default child or empty state
    state = const AsyncValue.loading();
    return Child.empty();
  }

  Future<void> getChildById(String id) async {
    state = const AsyncValue.loading();
    try {
      final child = await _childUsecase.getChildById(id);
      state = AsyncValue.data(child);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  

}