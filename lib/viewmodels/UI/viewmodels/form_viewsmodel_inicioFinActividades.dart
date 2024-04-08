import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:tayta/infraestructure/repository/formdatarepository_visita.dart';

import '../../../model/t_visita.dart';

class FormDataModelViewModel with PaginationViewModel<Visitas> {

  final repository = FormDataRepository();

  @override
  Function(Visitas  a, Visitas  b) compare = ((a, b) => a.codigoVisita.toString().compareTo(b.codigoVisita.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(Visitas a, Visitas b) {
    // TODO: implement areItemsTheSame
    return a.codigoVisita == b.codigoVisita;
  }

  @override
  Future<void> fetchData(int page) async {
    // TODO: implement fetchData
    final total = await repository.getPassengersList(page);
    setTotal(total);
  }

  @override
  Stream<PaginationState<List<Visitas>>> streamSubscription() => repository.result;

}