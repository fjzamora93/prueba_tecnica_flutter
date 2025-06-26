

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/child_usecase.dart';

// final childrenListProvider = AsyncNotifierProvider<ChildNotifier, List<Child>>(
//   ChildNotifier.new,
// );

// class ChildNotifier extends AsyncNotifier<Child> {

//   late final ChildUsecase _childUsecase;

//   @override
//   Future<List<Child>> build() async {
//     return await ref.read(childUseCaseProvider).getChildren();
//   }


// }