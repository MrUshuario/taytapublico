import 'dart:async';
/*
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:tayta/infraestructure/repository/formdatarepository_visita.dart';

import '../../../model/t_ubigeo.dart';

class FormDataModelViewModel with PaginationViewModel<Ubigeo> {

  final repository = FormDataRepository();

  @override
  Function(Ubigeo  a, Ubigeo  b) compare = ((a, b) => a.id.toString().compareTo(b.id.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(Ubigeo a, Ubigeo b) {
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
  Stream<PaginationState<List<Ubigeo>>> streamSubscription() => repository.result;

}

 */