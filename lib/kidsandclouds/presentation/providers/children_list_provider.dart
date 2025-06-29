

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/usecase/child_usecase.dart';

final childrenListProvider = AsyncNotifierProvider<ChildrenNotifier, List<Child>>(
  ChildrenNotifier.new,
);

class ChildrenNotifier extends AsyncNotifier<List<Child>> {

  late final ChildUsecase _childUsecase;

  @override
  Future<List<Child>> build() async {
    _childUsecase = ref.read(childUseCaseProvider);
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


  // Filtrar por id desde este provider
  Future<Child?> getChildById(String id) async {
    final currentChildren = state.value;
    
    if (currentChildren == null || currentChildren.isEmpty) {
      await fetchChildren();
      final newChildren = state.value;
      if (newChildren == null) return null;
      
      return newChildren.where((child) => 
        child.id['value']?.toString() == id ||
        child.login['uuid']?.toString() == id
      ).firstOrNull;
    }
    
    return currentChildren.where((child) => 
      child.idValue == id 
    ).firstOrNull;
  }
    
}