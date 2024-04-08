import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:tayta/infraestructure/repository/formdatarepository_padron.dart';
import '../../../model/t_padron.dart';

class FormDataModelViewModel with PaginationViewModel<Padron> {

  final repository = FormDataRepository();

  @override
  Function(Padron  a, Padron  b) compare = ((a, b) => a.id.toString().compareTo(b.id.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(Padron a, Padron b) {
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
  Stream<PaginationState<List<Padron>>> streamSubscription() => repository.result;

}