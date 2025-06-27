
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/child_repository.dart';

class ChildUsecase {
  final ChildRepository _childRepository;
  ChildUsecase(this._childRepository);


  // GET ALL CHILDREN
  Future<List<Child>> getChildren({int results = 10}) async {
    return await _childRepository.getChildren(results: results);
  }

  Future<Child> getChildById(String id) async {
    return await _childRepository.getChildById(id);
  }

}