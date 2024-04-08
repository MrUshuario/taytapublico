import 'package:floor/floor.dart';
import 'package:tayta/model/t_usuarios.dart';
import 'package:tayta/model/t_visita.dart';

@dao
abstract class FormDataModelDaoUSUARIOS {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(usuarios formDataModel);

  @Query('SELECT * FROM usuarios LIMIT :perPage OFFSET :offset')
  Future<List<usuarios>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM usuarios')
  Future<List<usuarios>> findAllUSUARIOS();

  @Query('SELECT COUNT(*) FROM usuarios')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM usuarios WHERE id = :ID')
  Future<int?> BorrarFormDataModels(int ID);

}