import 'dart:async';
/*
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:tayta/infraestructure/repository/formdatarepository_visita.dart';

import '../../../model/t_usuarios.dart';

class FormDataModelViewModel with PaginationViewModel<usuarios> {

  final repository = FormDataRepository();

  @override
  Function(usuarios  a, usuarios  b) compare = ((a, b) => a.id.toString().compareTo(b.id.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(usuarios a, usuarios b) {
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
  Stream<PaginationState<List<usuarios>>> streamSubscription() => repository.result;

}

 */