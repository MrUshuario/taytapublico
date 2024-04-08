import 'package:floor/floor.dart';
import 'package:tayta/model/t_padron.dart';

@dao
abstract class FormDataModelDaoPADRON {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Padron formDataModel);

  @Query('SELECT * FROM Padron LIMIT :perPage OFFSET :offset')
  Future<List<Padron>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Padron')
  Future<List<Padron>> findAllPadron();

  @Query('SELECT COUNT(*) FROM Padron')
  Future<int?> totalFormDataModels();
}

/*

    public List<String> listarProvincia(String departamento) {

        String valorInicial = "Seleccionar Provincia";// Constantes.SELECCIONAR;
        List<String> etiquetas = new ArrayList<String>();
        String buildSQL = "SELECT " + MyDbHelper.PADRON_PROVINCIA +
                " FROM " + MyDbHelper.TABLA_PADRON +
                " WHERE SUBSTR(" + MyDbHelper.PADRON_UBIGEO + ", 1, 2) = '" + departamento + "'" +
                " GROUP BY " + MyDbHelper.PADRON_PROVINCIA +
                " ORDER BY " + MyDbHelper.PADRON_PROVINCIA;

        Cursor cursor = database.rawQuery(buildSQL, null);
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                etiquetas.add(valorInicial);
                do {
                    etiquetas.add(cursor.getString(0));
                } while (cursor.moveToNext());
            }
        }

        return etiquetas;
    }


    public List<String> listarDistritos(String provincia) {

        String valorInicial = "Seleccionar Distrito...";//Constantes.SELECCIONAR;
        List<String> etiquetas = new ArrayList<String>();
        String buildSQL = "SELECT " + MyDbHelper.PADRON_DISTRITO + " FROM " + MyDbHelper.TABLA_PADRON + " WHERE " + MyDbHelper.PADRON_PROVINCIA + " = '" + provincia + "' GROUP BY " + MyDbHelper.PADRON_DISTRITO + " ORDER BY " + MyDbHelper.PADRON_DISTRITO;

        Cursor cursor = database.rawQuery(buildSQL, null);
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                etiquetas.add(valorInicial);
                do {
                    etiquetas.add(cursor.getString(0));
                } while (cursor.moveToNext());
            }
        }

        return etiquetas;
    }


public Cursor listarUsuariosDni(int pagina, String dni) {

        int offset = (pagina - 1) * 20;
        String buildSQL = "SELECT (SELECT COUNT(*) FROM " + MyDbHelper.TABLA_PADRON + " b  WHERE a." + MyDbHelper.PADRON_ID + " <= b." + MyDbHelper.PADRON_ID + ") as secuencia, a.* FROM "
                + MyDbHelper.TABLA_PADRON + " a "
                + " WHERE a." + MyDbHelper.PADRON_DNI + " = '" + dni + "'"
                + " LIMIT 20 " + "OFFSET " + offset;

        Cursor cursor = database.rawQuery(buildSQL, null);
        if (cursor != null) {

            cursor.moveToFirst();
        }

        return cursor;

    }

    public Cursor listarUsuariosDistrito(int pagina, String departamento, String provincia, String distrito) {

        int offset = (pagina - 1) * 20;
        String buildSQL = "SELECT (SELECT COUNT(*) FROM " + MyDbHelper.TABLA_PADRON + " b  WHERE a." + MyDbHelper.PADRON_ID + " <= b." + MyDbHelper.PADRON_ID + ") as secuencia, a.* FROM "
                + MyDbHelper.TABLA_PADRON + " a "
                + " WHERE SUBSTR(a." + MyDbHelper.PADRON_UBIGEO + ", 1, 2) = '" + departamento + "'"
                + " AND a." + MyDbHelper.PADRON_PROVINCIA + " = '" + provincia + "'"
                + " AND a." + MyDbHelper.PADRON_DISTRITO + " = '" + distrito + "'"
                + " LIMIT 20 " + "OFFSET " + offset;

        Cursor cursor = database.rawQuery(buildSQL, null);
        if (cursor != null) {

            cursor.moveToFirst();
        }

        return cursor;

    }
 */