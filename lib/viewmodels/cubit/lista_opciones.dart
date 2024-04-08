import 'package:flutter_bloc/flutter_bloc.dart';

const opcionesLIST =  [
  'Visita Presencial', 'Verificación Remota', 'Visita Colectiva',
  'Asistencia Tecnica', 'Campaña de Salud',
  'Ecuentro Mágico', 'Punto de Pago', 'Reporte Consolidado Indiviual',
  'Procesar Padrón', 'Reporte Usuarios', 'Deálogos de Saberes'
  ];

class ListaOpcionesBLOC extends Cubit<List<String>> {

  ListaOpcionesBLOC(super.opcionesLIST);

  //EJEMPLO POR SI QUIERO SE CAMBIE EL ESTADO
  void setLista(List<String> lista) {
    emit(lista);
  }

}