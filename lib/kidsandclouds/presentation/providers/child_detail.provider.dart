

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/usecase/child_usecase.dart';

final childDetailProvider = AsyncNotifierProvider<ChildNotifier, Child>(
  ChildNotifier.new,
);

class ChildNotifier extends AsyncNotifier<Child> {

  late final ChildUsecase _childUsecase;

  @override
  Future<Child> build() async {
    _childUsecase = ref.read(childUseCaseProvider);
    state = const AsyncValue.loading();
    return Child.empty();
  }

  void setChild(Child child) {
    state = AsyncValue.data(child);
  }


  //! NO USAR ESTE MÉTODO, YA QUE LA API UTILIZADA NO RECOGE ID, FILTRAR DESDE EL OTRO PROVIDER
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