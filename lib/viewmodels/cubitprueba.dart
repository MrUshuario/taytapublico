import 'package:flutter_bloc/flutter_bloc.dart';

class Cubitprueba extends Cubit<String> {

  Cubitprueba(): super('no-username');

  void setUsername(String username) {
    emit(username);
  }

}