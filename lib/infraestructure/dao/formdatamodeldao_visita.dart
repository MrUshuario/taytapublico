import 'package:floor/floor.dart';
import 'package:tayta/model/t_visita.dart';

@dao
abstract class FormDataModelDaoVISITA {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Visitas formDataModel);

  @Query('SELECT * FROM Visitas LIMIT :perPage OFFSET :offset')
  Future<List<Visitas>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Visitas')
  Future<List<Visitas>> findAllVISITAS();

  @Query('SELECT COUNT(*) FROM Visitas')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Visitas WHERE codigoVisita = :ID')
  Future<int?> BorrarFormDataModels(int ID);

}