
import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:tayta/infraestructure/dao/formdatamodeldao_usuariosLogin.dart';
import 'package:tayta/model/t_visita.dart';

import '../../model/t_usuarios.dart';
import '../dao/database/database.dart';
import '../dao/formdatamodeldao_visita.dart';

class FormDataRepository {

  final _controller = StreamController<PaginationState<List<usuarios>>>();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoUSUARIOS get formDataModelDaoUsuario => _appDatabase.formDataModelDaoUsuarios;

  Stream<PaginationState<List<usuarios>>> get result async* {
    yield* _controller.stream;
  }

  Future<int> getPassengersList(int page) async {
    _controller.add(const PaginationLoading());

    try {
      final offset = (10 * page) - 10;
      List<usuarios> responses = await formDataModelDaoUsuario.findFormDataModel(offset, 10);
      int? total = await formDataModelDaoUsuario.totalFormDataModels();
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