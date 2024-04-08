import 'package:floor/floor.dart';
import 'package:tayta/model/t_version.dart';

@dao
abstract class FormDataModelDaoVERSION {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Version formDataModel);

  @Query('SELECT * FROM Version LIMIT :perPage OFFSET :offset')
  Future<List<Version>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Version')
  Future<List<Version>> findAllVersion();

  @Query('SELECT COUNT(*) FROM Version')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Version WHERE id = :ID')
  Future<int?> BorrarFormDataModels(int ID);

  @Query('SELECT * FROM Version WHERE id = :ID')
  Future<List<Version>> SelectVersioNID(int ID);

}