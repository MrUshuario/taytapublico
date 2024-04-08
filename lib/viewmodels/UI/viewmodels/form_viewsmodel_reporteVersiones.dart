import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:tayta/infraestructure/repository/formdatarepository_version.dart';
import '../../../model/t_version.dart';

class FormDataModelViewModel with PaginationViewModel<Version> {

  final repository = FormDataRepository();

  @override
  Function(Version  a, Version  b) compare = ((a, b) => a.id.toString().compareTo(b.id.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(Version a, Version b) {
    // TODO: implement areItemsTheSame
    return a.id == b.id;
  }

  @override
  Future<void> fetchData(int page) async {
    // TODO: implement fetchData
    final total = await repository.getPassengersList(page);
    setTotal(total);
  }

  @override
  Stream<PaginationState<List<Version>>> streamSubscription() => repository.result;

}