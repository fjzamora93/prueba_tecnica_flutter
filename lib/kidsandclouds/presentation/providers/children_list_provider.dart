import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/usecase/child_usecase.dart';

final childrenListProvider = AsyncNotifierProvider<ChildrenNotifier, List<Child>>(
  ChildrenNotifier.new,
);

final searchQueryProvider = StateProvider<String>((ref) => '');


final filteredChildrenProvider = Provider<AsyncValue<List<Child>>>((ref) {
  final childrenAsync = ref.watch(childrenListProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  
  return childrenAsync.when(
    data: (children) {
      if (searchQuery.isEmpty) {
        return AsyncValue.data(children);
      }
      
      final filteredChildren = children.where((child) {
        final fullName = '${child.name['first'] ?? ''} ${child.name['last'] ?? ''}'.toLowerCase();
        return fullName.contains(searchQuery.toLowerCase());
      }).toList();
      
      return AsyncValue.data(filteredChildren);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

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

  //  Método para obtener niños filtrados localmente
  List<Child> getFilteredChildren(String searchQuery) {
    final currentChildren = state.value ?? [];
    
    if (searchQuery.isEmpty) {
      return currentChildren;
    }
    
    return currentChildren.where((child) {
      final fullName = '${child.name['first'] ?? ''} ${child.name['last'] ?? ''}'.toLowerCase();
      final email = child.email.toLowerCase();
      final phone = child.phone.toLowerCase();
      
      final query = searchQuery.toLowerCase();
      
      return fullName.contains(query) || 
             email.contains(query) || 
             phone.contains(query);
    }).toList();
  }
    
}