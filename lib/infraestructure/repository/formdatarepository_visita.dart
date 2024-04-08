
import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:tayta/model/t_visita.dart';

import '../dao/database/database.dart';
import '../dao/formdatamodeldao_visita.dart';

class FormDataRepository {

  final _controller = StreamController<PaginationState<List<Visitas>>>();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoVISITA get formDataModelDaoVisita => _appDatabase.formDataModelDaoVisita;

  Stream<PaginationState<List<Visitas>>> get result async* {
    yield* _controller.stream;
  }

  Future<int> getPassengersList(int page) async {
    _controller.add(const PaginationLoading());

    try {
      final offset = (10 * page) - 10;
      List<Visitas> responses = await formDataModelDaoVisita.findFormDataModel(offset, 10);
      int? total = await formDataModelDaoVisita.totalFormDataModels();
      /// emit fetched data
      _controller.add(PaginationSuccess(responses));
      return total ?? 0;
    } catch (_) {
      /// emit error
      _controller.add(const PaginationError());
      return 0;
    }
  }

}