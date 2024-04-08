import 'package:floor/floor.dart';
import 'package:tayta/model/t_ubigeo.dart';
import 'package:tayta/model/t_visita.dart';

@dao
abstract class FormDataModelDaoUBIGEO {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Ubigeo formDataModel);

  @Query('SELECT * FROM Ubigeo LIMIT :perPage OFFSET :offset')
  Future<List<Ubigeo>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Ubigeo')
  Future<List<Ubigeo>> findAllUBIGEO();

  @Query('SELECT COUNT(*) FROM Ubigeo')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Ubigeo WHERE id = :ID')
  Future<int?> BorrarFormDataModels(int ID);

  @Query('SELECT DISTINCT nombre_departamento FROM Ubigeo ORDER BY nombre_departamento')
  Future<List<String>> TraerDepartamentos();

  @Query('SELECT DISTINCT nombre_provincia FROM Ubigeo ORDER BY nombre_provincia')
  Future<List<String>> TraerProvincias();

  @Query('SELECT DISTINCT nombre_distrito FROM Ubigeo ORDER BY nombre_distrito')
  Future<List<String>> TraerDistritos();

  @Query('DELETE FROM Ubigeo')
  Future<int?> BorrarTodo();

}