// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FormDataModelDaoVISITA? _formDataModelDaoVisitaInstance;

  FormDataModelDaoPADRON? _formDataModelDaoPadronInstance;

  FormDataModelDaoVERSION? _formDataModelDaoVersionInstance;

  FormDataModelDaoUSUARIOS? _formDataModelDaoUsuariosInstance;

  FormDataModelDaoUBIGEO? _formDataModelDaoUbigeoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Visitas` (`codigoVisita` INTEGER PRIMARY KEY AUTOINCREMENT, `apepat` TEXT, `apemat` TEXT, `nombres` TEXT, `flagVictimaUsuario` INTEGER, `codigoViolenciaDetectada` INTEGER, `codigoVictima` INTEGER, `codigoVinculoPersonaAgresora` INTEGER, `codigoInstancia` INTEGER, `flagInstanciaSi` INTEGER, `observacionSaberes` TEXT, `placa` TEXT, `kilometraje` INTEGER, `monto` TEXT, `galones` TEXT, `grifo` TEXT, `telefonoContacto` TEXT, `personaContacto` TEXT, `fechaFallecimiento` TEXT, `tipoCondicion` INTEGER, `direccion` TEXT, `distrito` TEXT, `recibeTratamientoDiabetes` TEXT, `otrosDiabetes` TEXT, `codigoMedicacionDiabetes` INTEGER, `cumpleTratamientoHipertension` INTEGER, `descripcionMedicacionOtraEnfermedad` TEXT, `recibeTratamientoOtraEnfermedad` INTEGER, `codigoSaberesTema` INTEGER, `tieneLentes` INTEGER, `observacion` TEXT, `codigoOperador` TEXT, `codigoRegistro` INTEGER, `dni` TEXT, `fechaRegistro` TEXT, `fechaEncuentro` TEXT, `codigoModular` TEXT, `saberEspecifico` TEXT, `puntoFocal` TEXT, `codigoSaberesGrado` INTEGER, `nroNinos` INTEGER, `nroNinas` INTEGER, `codigoSaberesNivel` INTEGER, `seRealizoFechaProgramada` INTEGER, `fechaTablet` TEXT, `fechaTabletFotoDos` TEXT, `fechaTabletFotoTres` TEXT, `fechaTabletFotoUno` TEXT, `fotoDos` TEXT, `fotoTres` TEXT, `fotoUno` TEXT, `freeEspacioTablet` TEXT, `longitud` TEXT, `latitud` TEXT, `altitud` TEXT, `imei` TEXT, `recorrido` INTEGER, `totalEspacioTablet` TEXT, `versionAplicacion` TEXT, `versionCondicion` INTEGER, `versionOperador` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Agua` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoAgua` TEXT, `nombreAgua` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AsistenciaTecnica` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoAsistenciaTecnica` TEXT, `descripcionAsistenciaTecnica` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CampaniaSalud` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCampania` TEXT, `nombreCampania` TEXT, `ordenCampania` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CharlaDiscapacidad` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCharlaDiscapacidad` TEXT, `charlaDiscapacidad` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CharlaGenero` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCharlaGenero` TEXT, `descripcionCharlaGenero` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CharlaInclusion` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCharlaInclusion` TEXT, `descripcionCharlaInclusion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CharlaSalud` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCharlaSalud` TEXT, `charlaSalud` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cocina` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCocina` TEXT, `nombreCocina` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CronogramaConocimiento` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dia_limite` INTEGER, `mes_limite` INTEGER, `ano_limite` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CronogramaPuntoPago` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `perope` TEXT, `fechaInicio` TEXT, `codigoCronogramaPuntoPago` TEXT, `fechaFin` TEXT, `fechaCierre` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DiagnosticoBucal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoDiagnosticoBucal` TEXT, `diagnostico` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DiagnosticoVisual` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoDiagnosticoVisual` TEXT, `diagnostico` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Instancia` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoInstancia` TEXT, `instancia` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LocalPago` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoLocalPago` TEXT, `descripcion` TEXT, `ordenLocalPago` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Luz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoLuz` TEXT, `nombreLuz` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MedicacionArtritis` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoMedicacionArtritis` TEXT, `medicacion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MedicacionDiabetes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoMedicacionDiabetes` TEXT, `medicacion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MedicacionHipertension` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoMedicacionHipertension` TEXT, `medicacion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Miembros` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fechaNacimiento` TEXT, `ocurrencia` TEXT, `hogarId` TEXT, `fallecido` TEXT, `gestante` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ModalidadPago` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoModalidadPago` TEXT, `nombreModalidadPago` TEXT, `tipoPagoModalidadPago` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OtrasEnfermedad` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoCharlaSalud` TEXT, `descripcionOtrasEnfermedades` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Padron` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `padronDni` TEXT, `padronPaterno` TEXT, `padronMaterno` TEXT, `padronNombres` TEXT, `padronsexo` TEXT, `padronFechaNacimiento` TEXT, `padronUbigeo` TEXT, `padronDepartamento` TEXT, `padronProvincia` TEXT, `padronDistrito` TEXT, `padronSDireccion` TEXT, `padronCentroPoblado` TEXT, `padronLatitud` TEXT, `padronLongitud` TEXT, `padronPerope` TEXT, `padronEdad` TEXT, `flagPlanTrabajo` INTEGER, `padronDDireccion` TEXT, `padronDireccionP65` TEXT, `padronCodigoTipoCondicion` TEXT, `padronDescripcionCondicion` TEXT, `padronFechaVisita` TEXT, `padronUsuario` INTEGER, `padronPrioridad` INTEGER, `padronContactoTelefonico` TEXT, `padronPersonaContacto` TEXT, `indicePadronDni` TEXT, `indicePadronDepartamento` TEXT, `indicePadronProvincia` TEXT, `indicePadronDistrito` TEXT, `indicePadronPlanTrabajo` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Pared` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoPared` TEXT, `nombrePared` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PeriodoDiagnostico` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoPeriodoDiagnostico` TEXT, `descripcion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProximaCitaSalud` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoProximaCita` TEXT, `descripcion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PuntoPago` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoPuntoPago` TEXT, `codigoCronograma` TEXT, `tipoPuntoPago` TEXT, `codigoUbigeo` TEXT, `lugarAgencia` TEXT, `fechaPago` TEXT, `horaPago` TEXT, `totalUsuariosPago` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Recorrido` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_usuario` TEXT, `latitud` TEXT, `longitud` TEXT, `fecha` TEXT, `hora` TEXT, `estado` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesDetalle` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `idVisita` TEXT, `datos` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fecha` TEXT, `codigoModular` TEXT, `codigoRegistroSaberes` TEXT, `nroNinos` TEXT, `nroNinas` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivosDetalle` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dni` TEXT, `apellidoPaterno` TEXT, `apellidoMaterno` TEXT, `nombres` TEXT, `sexo` TEXT, `edad` TEXT, `fechaNacimiento` TEXT, `nroNino` TEXT, `edadNino` TEXT, `tieneAnemia` TEXT, `recibeLactanciaMaterna` TEXT, `recibeLactanciaMaternaySulfatoFerroso` TEXT, `recibeLecheMaterna` TEXT, `recibeSuplemento23` TEXT, `sabePrepararElSuplemento23` TEXT, `recibeSuplemento36` TEXT, `sabePrepararElSuplemento36` TEXT, `alimento123` TEXT, `alimento223` TEXT, `alimento323` TEXT, `alimento136` TEXT, `alimento236` TEXT, `alimento336` TEXT, `establecimientoSalud` TEXT, `estaAfiliadoSis` TEXT, `fechaUltimaHemoglobina` TEXT, `valorHemoglobina` TEXT, `ninoRecibeTratamientoAnemia` TEXT, `recibeGotasSulfatoFerroso` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivoGrado` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoSaberesProductivoGrado` TEXT, `descripcionGrado` TEXT, `orden` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivosNivel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoSaberesProductivosNivel` TEXT, `descripcionNivel` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivosSubTema` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoSaberesProductivosSubTema` TEXT, `descripcionSubTema` TEXT, `codigoSaberesTema` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivosSubTipologia` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `descripcionSubTipologia` TEXT, `codigoSaberesTipologia` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesProductivosTema` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoSaberesTema` TEXT, `descripcionTema` TEXT, `codigoSaberesTema2` TEXT, `descripcionTema2` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaberesTipologia` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `saberesTipologia` TEXT, `codigoSaberesTipologia` TEXT, `descripcionTipologia` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Saneamiento` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoSaneamiento` TEXT, `nombreSaneamiento` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Techo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoTecho` TEXT, `nombreTecho` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TemporalBeneficiario` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dniTemporal` TEXT, `APPATemporal` TEXT, `APMATemporal` TEXT, `nombresTemporal` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TipoCampania` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoTipoCampania` TEXT, `descripcionCampania` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TipoCondicion` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoTipoCondicion` TEXT, `descripcionCondicion` TEXT, `indicaCambioCondicion` TEXT, `flagSolicitudSisfoh` TEXT, `noNecesitaInformacion` TEXT, `orden` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TipoDiscapacidad` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoTipoDiscapacidad` TEXT, `descripcionTipoDiscapacidad` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TipoVictima` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoTipoVictima` TEXT, `descripcionVictima` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TipoViolencia` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoTipoViolencia` TEXT, `descripcionTipoViolencia` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Ubigeo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoImei` TEXT, `nombre_departamento` TEXT, `nombre_provincia` TEXT, `nombre_distrito` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UltimoControlSalud` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigoUltimoControl` TEXT, `descripcion` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `usuarios` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` TEXT, `userName` TEXT, `userClave` TEXT, `userRol` TEXT, `userDepartamento` TEXT, `userMenu` TEXT, `userCodigoRol` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VcolAcciones` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `codigo_acciones` TEXT, `descripcion_acciones` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Version` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `versionCondicion` TEXT, `versionOperadores` TEXT, `versionAplicacionVigente` TEXT, `versionUbigeo` TEXT, `versionAsistenciaTecnica` TEXT, `versionCampaniaSalud` TEXT, `versionCronogramaPago` TEXT, `versionLocalPago` TEXT, `versionModalidadPago` TEXT, `versionPuntoPago` TEXT, `versionTipoDiscapacidad` TEXT, `versionTecho` TEXT, `versionPared` TEXT, `versionCocina` TEXT, `versionAgua` TEXT, `versionSaneamiento` TEXT, `versionLuz` TEXT, `versionSaberes` TEXT, `versionSaberesTema` TEXT, `versionSaberesGrado` TEXT, `versionSaberesNivel` TEXT, `versionTipoDiscapacidadSaberes` TEXT, `versionTipoCampania` TEXT, `versionCharlaInclusion` TEXT, `versionCharlaGenero` TEXT, `versionInstancia` TEXT, `versionTipoVictima` TEXT, `versionTipoViolencia` TEXT, `versionCharlaDiscapacidad` TEXT, `versionCharlaSalud` TEXT, `versionOtrasEnfermedades` TEXT, `versionUltimoControlSalud` TEXT, `versionProximaCitaSalud` TEXT, `versionPeriodoDiagnostico` TEXT, `versionMedicacionDiabetes` TEXT, `versionMedicacionHipertension` TEXT, `versionMedicacionArtritis` TEXT, `versionDiagnosticoVisual` TEXT, `versionDiagnosticoBucal` TEXT, `versionAno` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VisitaColectiva` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `acciones` TEXT, `observaciones` TEXT, `Foto1` TEXT, `Foto2` TEXT, `Foto3` TEXT, `fecha_registro` TEXT, `latitud` TEXT, `longitd` TEXT, `IMEI` TEXT, `user_id` TEXT, `fecha_tablet` TEXT, `fecha_tablet_FOTO01` TEXT, `fecha_tablet_FOTO02` TEXT, `fecha_tablet_FOTO03` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Foto` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `path` TEXT, `codigoVisita` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FormDataModelDaoVISITA get formDataModelDaoVisita {
    return _formDataModelDaoVisitaInstance ??=
        _$FormDataModelDaoVISITA(database, changeListener);
  }

  @override
  FormDataModelDaoPADRON get formDataModelDaoPadron {
    return _formDataModelDaoPadronInstance ??=
        _$FormDataModelDaoPADRON(database, changeListener);
  }

  @override
  FormDataModelDaoVERSION get formDataModelDaoVersion {
    return _formDataModelDaoVersionInstance ??=
        _$FormDataModelDaoVERSION(database, changeListener);
  }

  @override
  FormDataModelDaoUSUARIOS get formDataModelDaoUsuarios {
    return _formDataModelDaoUsuariosInstance ??=
        _$FormDataModelDaoUSUARIOS(database, changeListener);
  }

  @override
  FormDataModelDaoUBIGEO get formDataModelDaoUbigeo {
    return _formDataModelDaoUbigeoInstance ??=
        _$FormDataModelDaoUBIGEO(database, changeListener);
  }
}

class _$FormDataModelDaoVISITA extends FormDataModelDaoVISITA {
  _$FormDataModelDaoVISITA(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _visitasInsertionAdapter = InsertionAdapter(
            database,
            'Visitas',
            (Visitas item) => <String, Object?>{
                  'codigoVisita': item.codigoVisita,
                  'apepat': item.apepat,
                  'apemat': item.apemat,
                  'nombres': item.nombres,
                  'flagVictimaUsuario': item.flagVictimaUsuario,
                  'codigoViolenciaDetectada': item.codigoViolenciaDetectada,
                  'codigoVictima': item.codigoVictima,
                  'codigoVinculoPersonaAgresora':
                      item.codigoVinculoPersonaAgresora,
                  'codigoInstancia': item.codigoInstancia,
                  'flagInstanciaSi': item.flagInstanciaSi,
                  'observacionSaberes': item.observacionSaberes,
                  'placa': item.placa,
                  'kilometraje': item.kilometraje,
                  'monto': item.monto,
                  'galones': item.galones,
                  'grifo': item.grifo,
                  'telefonoContacto': item.telefonoContacto,
                  'personaContacto': item.personaContacto,
                  'fechaFallecimiento': item.fechaFallecimiento,
                  'tipoCondicion': item.tipoCondicion,
                  'direccion': item.direccion,
                  'distrito': item.distrito,
                  'recibeTratamientoDiabetes': item.recibeTratamientoDiabetes,
                  'otrosDiabetes': item.otrosDiabetes,
                  'codigoMedicacionDiabetes': item.codigoMedicacionDiabetes,
                  'cumpleTratamientoHipertension':
                      item.cumpleTratamientoHipertension,
                  'descripcionMedicacionOtraEnfermedad':
                      item.descripcionMedicacionOtraEnfermedad,
                  'recibeTratamientoOtraEnfermedad':
                      item.recibeTratamientoOtraEnfermedad,
                  'codigoSaberesTema': item.codigoSaberesTema,
                  'tieneLentes': item.tieneLentes,
                  'observacion': item.observacion,
                  'codigoOperador': item.codigoOperador,
                  'codigoRegistro': item.codigoRegistro,
                  'dni': item.dni,
                  'fechaRegistro': item.fechaRegistro,
                  'fechaEncuentro': item.fechaEncuentro,
                  'codigoModular': item.codigoModular,
                  'saberEspecifico': item.saberEspecifico,
                  'puntoFocal': item.puntoFocal,
                  'codigoSaberesGrado': item.codigoSaberesGrado,
                  'nroNinos': item.nroNinos,
                  'nroNinas': item.nroNinas,
                  'codigoSaberesNivel': item.codigoSaberesNivel,
                  'seRealizoFechaProgramada': item.seRealizoFechaProgramada,
                  'fechaTablet': item.fechaTablet,
                  'fechaTabletFotoDos': item.fechaTabletFotoDos,
                  'fechaTabletFotoTres': item.fechaTabletFotoTres,
                  'fechaTabletFotoUno': item.fechaTabletFotoUno,
                  'fotoDos': item.fotoDos,
                  'fotoTres': item.fotoTres,
                  'fotoUno': item.fotoUno,
                  'freeEspacioTablet': item.freeEspacioTablet,
                  'longitud': item.longitud,
                  'latitud': item.latitud,
                  'altitud': item.altitud,
                  'imei': item.imei,
                  'recorrido': item.recorrido,
                  'totalEspacioTablet': item.totalEspacioTablet,
                  'versionAplicacion': item.versionAplicacion,
                  'versionCondicion': item.versionCondicion,
                  'versionOperador': item.versionOperador
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Visitas> _visitasInsertionAdapter;

  @override
  Future<List<Visitas>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Visitas LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Visitas(
            altitud: row['altitud'] as String?,
            apepat: row['apepat'] as String?,
            apemat: row['apemat'] as String?,
            codigoViolenciaDetectada: row['codigoViolenciaDetectada'] as int?,
            flagVictimaUsuario: row['flagVictimaUsuario'] as int?,
            codigoVictima: row['codigoVictima'] as int?,
            codigoVinculoPersonaAgresora:
                row['codigoVinculoPersonaAgresora'] as int?,
            codigoInstancia: row['codigoInstancia'] as int?,
            flagInstanciaSi: row['flagInstanciaSi'] as int?,
            observacionSaberes: row['observacionSaberes'] as String?,
            placa: row['placa'] as String?,
            kilometraje: row['kilometraje'] as int?,
            monto: row['monto'] as String?,
            galones: row['galones'] as String?,
            grifo: row['grifo'] as String?,
            telefonoContacto: row['telefonoContacto'] as String?,
            personaContacto: row['personaContacto'] as String?,
            fechaFallecimiento: row['fechaFallecimiento'] as String?,
            tipoCondicion: row['tipoCondicion'] as int?,
            direccion: row['direccion'] as String?,
            distrito: row['distrito'] as String?,
            recibeTratamientoDiabetes:
                row['recibeTratamientoDiabetes'] as String?,
            otrosDiabetes: row['otrosDiabetes'] as String?,
            codigoMedicacionDiabetes: row['codigoMedicacionDiabetes'] as int?,
            cumpleTratamientoHipertension:
                row['cumpleTratamientoHipertension'] as int?,
            descripcionMedicacionOtraEnfermedad:
                row['descripcionMedicacionOtraEnfermedad'] as String?,
            recibeTratamientoOtraEnfermedad:
                row['recibeTratamientoOtraEnfermedad'] as int?,
            codigoSaberesTema: row['codigoSaberesTema'] as int?,
            tieneLentes: row['tieneLentes'] as int?,
            nombres: row['nombres'] as String?,
            codigoOperador: row['codigoOperador'] as String?,
            codigoRegistro: row['codigoRegistro'] as int?,
            codigoVisita: row['codigoVisita'] as int?,
            dni: row['dni'] as String?,
            fechaRegistro: row['fechaRegistro'] as String?,
            fechaEncuentro: row['fechaEncuentro'] as String?,
            codigoModular: row['codigoModular'] as String?,
            saberEspecifico: row['saberEspecifico'] as String?,
            puntoFocal: row['puntoFocal'] as String?,
            codigoSaberesGrado: row['codigoSaberesGrado'] as int?,
            nroNinos: row['nroNinos'] as int?,
            nroNinas: row['nroNinas'] as int?,
            codigoSaberesNivel: row['codigoSaberesNivel'] as int?,
            seRealizoFechaProgramada: row['seRealizoFechaProgramada'] as int?,
            fechaTablet: row['fechaTablet'] as String?,
            fechaTabletFotoDos: row['fechaTabletFotoDos'] as String?,
            fechaTabletFotoTres: row['fechaTabletFotoTres'] as String?,
            fechaTabletFotoUno: row['fechaTabletFotoUno'] as String?,
            fotoDos: row['fotoDos'] as String?,
            fotoTres: row['fotoTres'] as String?,
            fotoUno: row['fotoUno'] as String?,
            freeEspacioTablet: row['freeEspacioTablet'] as String?,
            imei: row['imei'] as String?,
            latitud: row['latitud'] as String?,
            longitud: row['longitud'] as String?,
            observacion: row['observacion'] as String?,
            recorrido: row['recorrido'] as int?,
            totalEspacioTablet: row['totalEspacioTablet'] as String?,
            versionAplicacion: row['versionAplicacion'] as String?,
            versionCondicion: row['versionCondicion'] as int?,
            versionOperador: row['versionOperador'] as int?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Visitas>> findAllVISITAS() async {
    return _queryAdapter.queryList('SELECT * FROM Visitas',
        mapper: (Map<String, Object?> row) => Visitas(
            altitud: row['altitud'] as String?,
            apepat: row['apepat'] as String?,
            apemat: row['apemat'] as String?,
            codigoViolenciaDetectada: row['codigoViolenciaDetectada'] as int?,
            flagVictimaUsuario: row['flagVictimaUsuario'] as int?,
            codigoVictima: row['codigoVictima'] as int?,
            codigoVinculoPersonaAgresora:
                row['codigoVinculoPersonaAgresora'] as int?,
            codigoInstancia: row['codigoInstancia'] as int?,
            flagInstanciaSi: row['flagInstanciaSi'] as int?,
            observacionSaberes: row['observacionSaberes'] as String?,
            placa: row['placa'] as String?,
            kilometraje: row['kilometraje'] as int?,
            monto: row['monto'] as String?,
            galones: row['galones'] as String?,
            grifo: row['grifo'] as String?,
            telefonoContacto: row['telefonoContacto'] as String?,
            personaContacto: row['personaContacto'] as String?,
            fechaFallecimiento: row['fechaFallecimiento'] as String?,
            tipoCondicion: row['tipoCondicion'] as int?,
            direccion: row['direccion'] as String?,
            distrito: row['distrito'] as String?,
            recibeTratamientoDiabetes:
                row['recibeTratamientoDiabetes'] as String?,
            otrosDiabetes: row['otrosDiabetes'] as String?,
            codigoMedicacionDiabetes: row['codigoMedicacionDiabetes'] as int?,
            cumpleTratamientoHipertension:
                row['cumpleTratamientoHipertension'] as int?,
            descripcionMedicacionOtraEnfermedad:
                row['descripcionMedicacionOtraEnfermedad'] as String?,
            recibeTratamientoOtraEnfermedad:
                row['recibeTratamientoOtraEnfermedad'] as int?,
            codigoSaberesTema: row['codigoSaberesTema'] as int?,
            tieneLentes: row['tieneLentes'] as int?,
            nombres: row['nombres'] as String?,
            codigoOperador: row['codigoOperador'] as String?,
            codigoRegistro: row['codigoRegistro'] as int?,
            codigoVisita: row['codigoVisita'] as int?,
            dni: row['dni'] as String?,
            fechaRegistro: row['fechaRegistro'] as String?,
            fechaEncuentro: row['fechaEncuentro'] as String?,
            codigoModular: row['codigoModular'] as String?,
            saberEspecifico: row['saberEspecifico'] as String?,
            puntoFocal: row['puntoFocal'] as String?,
            codigoSaberesGrado: row['codigoSaberesGrado'] as int?,
            nroNinos: row['nroNinos'] as int?,
            nroNinas: row['nroNinas'] as int?,
            codigoSaberesNivel: row['codigoSaberesNivel'] as int?,
            seRealizoFechaProgramada: row['seRealizoFechaProgramada'] as int?,
            fechaTablet: row['fechaTablet'] as String?,
            fechaTabletFotoDos: row['fechaTabletFotoDos'] as String?,
            fechaTabletFotoTres: row['fechaTabletFotoTres'] as String?,
            fechaTabletFotoUno: row['fechaTabletFotoUno'] as String?,
            fotoDos: row['fotoDos'] as String?,
            fotoTres: row['fotoTres'] as String?,
            fotoUno: row['fotoUno'] as String?,
            freeEspacioTablet: row['freeEspacioTablet'] as String?,
            imei: row['imei'] as String?,
            latitud: row['latitud'] as String?,
            longitud: row['longitud'] as String?,
            observacion: row['observacion'] as String?,
            recorrido: row['recorrido'] as int?,
            totalEspacioTablet: row['totalEspacioTablet'] as String?,
            versionAplicacion: row['versionAplicacion'] as String?,
            versionCondicion: row['versionCondicion'] as int?,
            versionOperador: row['versionOperador'] as int?));
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Visitas',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int ID) async {
    return _queryAdapter.query('DELETE FROM Visitas WHERE codigoVisita = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [ID]);
  }

  @override
  Future<void> insertFormDataModel(Visitas formDataModel) async {
    await _visitasInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoPADRON extends FormDataModelDaoPADRON {
  _$FormDataModelDaoPADRON(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _padronInsertionAdapter = InsertionAdapter(
            database,
            'Padron',
            (Padron item) => <String, Object?>{
                  'id': item.id,
                  'padronDni': item.padronDni,
                  'padronPaterno': item.padronPaterno,
                  'padronMaterno': item.padronMaterno,
                  'padronNombres': item.padronNombres,
                  'padronsexo': item.padronsexo,
                  'padronFechaNacimiento': item.padronFechaNacimiento,
                  'padronUbigeo': item.padronUbigeo,
                  'padronDepartamento': item.padronDepartamento,
                  'padronProvincia': item.padronProvincia,
                  'padronDistrito': item.padronDistrito,
                  'padronSDireccion': item.padronSDireccion,
                  'padronCentroPoblado': item.padronCentroPoblado,
                  'padronLatitud': item.padronLatitud,
                  'padronLongitud': item.padronLongitud,
                  'padronPerope': item.padronPerope,
                  'padronEdad': item.padronEdad,
                  'flagPlanTrabajo': item.flagPlanTrabajo,
                  'padronDDireccion': item.padronDDireccion,
                  'padronDireccionP65': item.padronDireccionP65,
                  'padronCodigoTipoCondicion': item.padronCodigoTipoCondicion,
                  'padronDescripcionCondicion': item.padronDescripcionCondicion,
                  'padronFechaVisita': item.padronFechaVisita,
                  'padronUsuario': item.padronUsuario,
                  'padronPrioridad': item.padronPrioridad,
                  'padronContactoTelefonico': item.padronContactoTelefonico,
                  'padronPersonaContacto': item.padronPersonaContacto,
                  'indicePadronDni': item.indicePadronDni,
                  'indicePadronDepartamento': item.indicePadronDepartamento,
                  'indicePadronProvincia': item.indicePadronProvincia,
                  'indicePadronDistrito': item.indicePadronDistrito,
                  'indicePadronPlanTrabajo': item.indicePadronPlanTrabajo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Padron> _padronInsertionAdapter;

  @override
  Future<List<Padron>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Padron LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Padron(
            id: row['id'] as int?,
            padronDni: row['padronDni'] as String?,
            padronPaterno: row['padronPaterno'] as String?,
            padronMaterno: row['padronMaterno'] as String?,
            padronNombres: row['padronNombres'] as String?,
            padronsexo: row['padronsexo'] as String?,
            padronFechaNacimiento: row['padronFechaNacimiento'] as String?,
            padronUbigeo: row['padronUbigeo'] as String?,
            padronDepartamento: row['padronDepartamento'] as String?,
            padronProvincia: row['padronProvincia'] as String?,
            padronDistrito: row['padronDistrito'] as String?,
            padronSDireccion: row['padronSDireccion'] as String?,
            padronCentroPoblado: row['padronCentroPoblado'] as String?,
            padronLatitud: row['padronLatitud'] as String?,
            padronLongitud: row['padronLongitud'] as String?,
            padronPerope: row['padronPerope'] as String?,
            padronEdad: row['padronEdad'] as String?,
            flagPlanTrabajo: row['flagPlanTrabajo'] as int?,
            padronDDireccion: row['padronDDireccion'] as String?,
            padronDireccionP65: row['padronDireccionP65'] as String?,
            padronCodigoTipoCondicion:
                row['padronCodigoTipoCondicion'] as String?,
            padronDescripcionCondicion:
                row['padronDescripcionCondicion'] as String?,
            padronFechaVisita: row['padronFechaVisita'] as String?,
            padronUsuario: row['padronUsuario'] as int?,
            padronPrioridad: row['padronPrioridad'] as int?,
            padronContactoTelefonico:
                row['padronContactoTelefonico'] as String?,
            padronPersonaContacto: row['padronPersonaContacto'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Padron>> findAllPadron() async {
    return _queryAdapter.queryList('SELECT * FROM Padron',
        mapper: (Map<String, Object?> row) => Padron(
            id: row['id'] as int?,
            padronDni: row['padronDni'] as String?,
            padronPaterno: row['padronPaterno'] as String?,
            padronMaterno: row['padronMaterno'] as String?,
            padronNombres: row['padronNombres'] as String?,
            padronsexo: row['padronsexo'] as String?,
            padronFechaNacimiento: row['padronFechaNacimiento'] as String?,
            padronUbigeo: row['padronUbigeo'] as String?,
            padronDepartamento: row['padronDepartamento'] as String?,
            padronProvincia: row['padronProvincia'] as String?,
            padronDistrito: row['padronDistrito'] as String?,
            padronSDireccion: row['padronSDireccion'] as String?,
            padronCentroPoblado: row['padronCentroPoblado'] as String?,
            padronLatitud: row['padronLatitud'] as String?,
            padronLongitud: row['padronLongitud'] as String?,
            padronPerope: row['padronPerope'] as String?,
            padronEdad: row['padronEdad'] as String?,
            flagPlanTrabajo: row['flagPlanTrabajo'] as int?,
            padronDDireccion: row['padronDDireccion'] as String?,
            padronDireccionP65: row['padronDireccionP65'] as String?,
            padronCodigoTipoCondicion:
                row['padronCodigoTipoCondicion'] as String?,
            padronDescripcionCondicion:
                row['padronDescripcionCondicion'] as String?,
            padronFechaVisita: row['padronFechaVisita'] as String?,
            padronUsuario: row['padronUsuario'] as int?,
            padronPrioridad: row['padronPrioridad'] as int?,
            padronContactoTelefonico:
                row['padronContactoTelefonico'] as String?,
            padronPersonaContacto: row['padronPersonaContacto'] as String?));
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Padron',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(Padron formDataModel) async {
    await _padronInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoVERSION extends FormDataModelDaoVERSION {
  _$FormDataModelDaoVERSION(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _versionInsertionAdapter = InsertionAdapter(
            database,
            'Version',
            (Version item) => <String, Object?>{
                  'id': item.id,
                  'versionCondicion': item.versionCondicion,
                  'versionOperadores': item.versionOperadores,
                  'versionAplicacionVigente': item.versionAplicacionVigente,
                  'versionUbigeo': item.versionUbigeo,
                  'versionAsistenciaTecnica': item.versionAsistenciaTecnica,
                  'versionCampaniaSalud': item.versionCampaniaSalud,
                  'versionCronogramaPago': item.versionCronogramaPago,
                  'versionLocalPago': item.versionLocalPago,
                  'versionModalidadPago': item.versionModalidadPago,
                  'versionPuntoPago': item.versionPuntoPago,
                  'versionTipoDiscapacidad': item.versionTipoDiscapacidad,
                  'versionTecho': item.versionTecho,
                  'versionPared': item.versionPared,
                  'versionCocina': item.versionCocina,
                  'versionAgua': item.versionAgua,
                  'versionSaneamiento': item.versionSaneamiento,
                  'versionLuz': item.versionLuz,
                  'versionSaberes': item.versionSaberes,
                  'versionSaberesTema': item.versionSaberesTema,
                  'versionSaberesGrado': item.versionSaberesGrado,
                  'versionSaberesNivel': item.versionSaberesNivel,
                  'versionTipoDiscapacidadSaberes':
                      item.versionTipoDiscapacidadSaberes,
                  'versionTipoCampania': item.versionTipoCampania,
                  'versionCharlaInclusion': item.versionCharlaInclusion,
                  'versionCharlaGenero': item.versionCharlaGenero,
                  'versionInstancia': item.versionInstancia,
                  'versionTipoVictima': item.versionTipoVictima,
                  'versionTipoViolencia': item.versionTipoViolencia,
                  'versionCharlaDiscapacidad': item.versionCharlaDiscapacidad,
                  'versionCharlaSalud': item.versionCharlaSalud,
                  'versionOtrasEnfermedades': item.versionOtrasEnfermedades,
                  'versionUltimoControlSalud': item.versionUltimoControlSalud,
                  'versionProximaCitaSalud': item.versionProximaCitaSalud,
                  'versionPeriodoDiagnostico': item.versionPeriodoDiagnostico,
                  'versionMedicacionDiabetes': item.versionMedicacionDiabetes,
                  'versionMedicacionHipertension':
                      item.versionMedicacionHipertension,
                  'versionMedicacionArtritis': item.versionMedicacionArtritis,
                  'versionDiagnosticoVisual': item.versionDiagnosticoVisual,
                  'versionDiagnosticoBucal': item.versionDiagnosticoBucal,
                  'versionAno': item.versionAno
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Version> _versionInsertionAdapter;

  @override
  Future<List<Version>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Version LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Version(
            id: row['id'] as int?,
            versionCondicion: row['versionCondicion'] as String?,
            versionOperadores: row['versionOperadores'] as String?,
            versionAplicacionVigente:
                row['versionAplicacionVigente'] as String?,
            versionUbigeo: row['versionUbigeo'] as String?,
            versionAsistenciaTecnica:
                row['versionAsistenciaTecnica'] as String?,
            versionCampaniaSalud: row['versionCampaniaSalud'] as String?,
            versionCronogramaPago: row['versionCronogramaPago'] as String?,
            versionLocalPago: row['versionLocalPago'] as String?,
            versionModalidadPago: row['versionModalidadPago'] as String?,
            versionPuntoPago: row['versionPuntoPago'] as String?,
            versionTipoDiscapacidad: row['versionTipoDiscapacidad'] as String?,
            versionTecho: row['versionTecho'] as String?,
            versionPared: row['versionPared'] as String?,
            versionCocina: row['versionCocina'] as String?,
            versionAgua: row['versionAgua'] as String?,
            versionSaneamiento: row['versionSaneamiento'] as String?,
            versionLuz: row['versionLuz'] as String?,
            versionSaberes: row['versionSaberes'] as String?,
            versionSaberesTema: row['versionSaberesTema'] as String?,
            versionSaberesGrado: row['versionSaberesGrado'] as String?,
            versionSaberesNivel: row['versionSaberesNivel'] as String?,
            versionTipoDiscapacidadSaberes:
                row['versionTipoDiscapacidadSaberes'] as String?,
            versionTipoCampania: row['versionTipoCampania'] as String?,
            versionCharlaInclusion: row['versionCharlaInclusion'] as String?,
            versionCharlaGenero: row['versionCharlaGenero'] as String?,
            versionInstancia: row['versionInstancia'] as String?,
            versionTipoVictima: row['versionTipoVictima'] as String?,
            versionTipoViolencia: row['versionTipoViolencia'] as String?,
            versionCharlaDiscapacidad:
                row['versionCharlaDiscapacidad'] as String?,
            versionCharlaSalud: row['versionCharlaSalud'] as String?,
            versionOtrasEnfermedades:
                row['versionOtrasEnfermedades'] as String?,
            versionUltimoControlSalud:
                row['versionUltimoControlSalud'] as String?,
            versionProximaCitaSalud: row['versionProximaCitaSalud'] as String?,
            versionPeriodoDiagnostico:
                row['versionPeriodoDiagnostico'] as String?,
            versionMedicacionDiabetes:
                row['versionMedicacionDiabetes'] as String?,
            versionMedicacionHipertension:
                row['versionMedicacionHipertension'] as String?,
            versionMedicacionArtritis:
                row['versionMedicacionArtritis'] as String?,
            versionDiagnosticoVisual:
                row['versionDiagnosticoVisual'] as String?,
            versionDiagnosticoBucal: row['versionDiagnosticoBucal'] as String?,
            versionAno: row['versionAno'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Version>> findAllVersion() async {
    return _queryAdapter.queryList('SELECT * FROM Version',
        mapper: (Map<String, Object?> row) => Version(
            id: row['id'] as int?,
            versionCondicion: row['versionCondicion'] as String?,
            versionOperadores: row['versionOperadores'] as String?,
            versionAplicacionVigente:
                row['versionAplicacionVigente'] as String?,
            versionUbigeo: row['versionUbigeo'] as String?,
            versionAsistenciaTecnica:
                row['versionAsistenciaTecnica'] as String?,
            versionCampaniaSalud: row['versionCampaniaSalud'] as String?,
            versionCronogramaPago: row['versionCronogramaPago'] as String?,
            versionLocalPago: row['versionLocalPago'] as String?,
            versionModalidadPago: row['versionModalidadPago'] as String?,
            versionPuntoPago: row['versionPuntoPago'] as String?,
            versionTipoDiscapacidad: row['versionTipoDiscapacidad'] as String?,
            versionTecho: row['versionTecho'] as String?,
            versionPared: row['versionPared'] as String?,
            versionCocina: row['versionCocina'] as String?,
            versionAgua: row['versionAgua'] as String?,
            versionSaneamiento: row['versionSaneamiento'] as String?,
            versionLuz: row['versionLuz'] as String?,
            versionSaberes: row['versionSaberes'] as String?,
            versionSaberesTema: row['versionSaberesTema'] as String?,
            versionSaberesGrado: row['versionSaberesGrado'] as String?,
            versionSaberesNivel: row['versionSaberesNivel'] as String?,
            versionTipoDiscapacidadSaberes:
                row['versionTipoDiscapacidadSaberes'] as String?,
            versionTipoCampania: row['versionTipoCampania'] as String?,
            versionCharlaInclusion: row['versionCharlaInclusion'] as String?,
            versionCharlaGenero: row['versionCharlaGenero'] as String?,
            versionInstancia: row['versionInstancia'] as String?,
            versionTipoVictima: row['versionTipoVictima'] as String?,
            versionTipoViolencia: row['versionTipoViolencia'] as String?,
            versionCharlaDiscapacidad:
                row['versionCharlaDiscapacidad'] as String?,
            versionCharlaSalud: row['versionCharlaSalud'] as String?,
            versionOtrasEnfermedades:
                row['versionOtrasEnfermedades'] as String?,
            versionUltimoControlSalud:
                row['versionUltimoControlSalud'] as String?,
            versionProximaCitaSalud: row['versionProximaCitaSalud'] as String?,
            versionPeriodoDiagnostico:
                row['versionPeriodoDiagnostico'] as String?,
            versionMedicacionDiabetes:
                row['versionMedicacionDiabetes'] as String?,
            versionMedicacionHipertension:
                row['versionMedicacionHipertension'] as String?,
            versionMedicacionArtritis:
                row['versionMedicacionArtritis'] as String?,
            versionDiagnosticoVisual:
                row['versionDiagnosticoVisual'] as String?,
            versionDiagnosticoBucal: row['versionDiagnosticoBucal'] as String?,
            versionAno: row['versionAno'] as String?));
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Version',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int ID) async {
    return _queryAdapter.query('DELETE FROM Version WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [ID]);
  }

  @override
  Future<List<Version>> SelectVersioNID(int ID) async {
    return _queryAdapter.queryList('SELECT * FROM Version WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Version(
            id: row['id'] as int?,
            versionCondicion: row['versionCondicion'] as String?,
            versionOperadores: row['versionOperadores'] as String?,
            versionAplicacionVigente:
                row['versionAplicacionVigente'] as String?,
            versionUbigeo: row['versionUbigeo'] as String?,
            versionAsistenciaTecnica:
                row['versionAsistenciaTecnica'] as String?,
            versionCampaniaSalud: row['versionCampaniaSalud'] as String?,
            versionCronogramaPago: row['versionCronogramaPago'] as String?,
            versionLocalPago: row['versionLocalPago'] as String?,
            versionModalidadPago: row['versionModalidadPago'] as String?,
            versionPuntoPago: row['versionPuntoPago'] as String?,
            versionTipoDiscapacidad: row['versionTipoDiscapacidad'] as String?,
            versionTecho: row['versionTecho'] as String?,
            versionPared: row['versionPared'] as String?,
            versionCocina: row['versionCocina'] as String?,
            versionAgua: row['versionAgua'] as String?,
            versionSaneamiento: row['versionSaneamiento'] as String?,
            versionLuz: row['versionLuz'] as String?,
            versionSaberes: row['versionSaberes'] as String?,
            versionSaberesTema: row['versionSaberesTema'] as String?,
            versionSaberesGrado: row['versionSaberesGrado'] as String?,
            versionSaberesNivel: row['versionSaberesNivel'] as String?,
            versionTipoDiscapacidadSaberes:
                row['versionTipoDiscapacidadSaberes'] as String?,
            versionTipoCampania: row['versionTipoCampania'] as String?,
            versionCharlaInclusion: row['versionCharlaInclusion'] as String?,
            versionCharlaGenero: row['versionCharlaGenero'] as String?,
            versionInstancia: row['versionInstancia'] as String?,
            versionTipoVictima: row['versionTipoVictima'] as String?,
            versionTipoViolencia: row['versionTipoViolencia'] as String?,
            versionCharlaDiscapacidad:
                row['versionCharlaDiscapacidad'] as String?,
            versionCharlaSalud: row['versionCharlaSalud'] as String?,
            versionOtrasEnfermedades:
                row['versionOtrasEnfermedades'] as String?,
            versionUltimoControlSalud:
                row['versionUltimoControlSalud'] as String?,
            versionProximaCitaSalud: row['versionProximaCitaSalud'] as String?,
            versionPeriodoDiagnostico:
                row['versionPeriodoDiagnostico'] as String?,
            versionMedicacionDiabetes:
                row['versionMedicacionDiabetes'] as String?,
            versionMedicacionHipertension:
                row['versionMedicacionHipertension'] as String?,
            versionMedicacionArtritis:
                row['versionMedicacionArtritis'] as String?,
            versionDiagnosticoVisual:
                row['versionDiagnosticoVisual'] as String?,
            versionDiagnosticoBucal: row['versionDiagnosticoBucal'] as String?,
            versionAno: row['versionAno'] as String?),
        arguments: [ID]);
  }

  @override
  Future<void> insertFormDataModel(Version formDataModel) async {
    await _versionInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoUSUARIOS extends FormDataModelDaoUSUARIOS {
  _$FormDataModelDaoUSUARIOS(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _usuariosInsertionAdapter = InsertionAdapter(
            database,
            'usuarios',
            (usuarios item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'userName': item.userName,
                  'userClave': item.userClave,
                  'userRol': item.userRol,
                  'userDepartamento': item.userDepartamento,
                  'userMenu': item.userMenu,
                  'userCodigoRol': item.userCodigoRol
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<usuarios> _usuariosInsertionAdapter;

  @override
  Future<List<usuarios>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM usuarios LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => usuarios(
            id: row['id'] as int?,
            userId: row['userId'] as String?,
            userName: row['userName'] as String?,
            userClave: row['userClave'] as String?,
            userRol: row['userRol'] as String?,
            userDepartamento: row['userDepartamento'] as String?,
            userMenu: row['userMenu'] as String?,
            userCodigoRol: row['userCodigoRol'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<usuarios>> findAllUSUARIOS() async {
    return _queryAdapter.queryList('SELECT * FROM usuarios',
        mapper: (Map<String, Object?> row) => usuarios(
            id: row['id'] as int?,
            userId: row['userId'] as String?,
            userName: row['userName'] as String?,
            userClave: row['userClave'] as String?,
            userRol: row['userRol'] as String?,
            userDepartamento: row['userDepartamento'] as String?,
            userMenu: row['userMenu'] as String?,
            userCodigoRol: row['userCodigoRol'] as String?));
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM usuarios',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int ID) async {
    return _queryAdapter.query('DELETE FROM usuarios WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [ID]);
  }

  @override
  Future<void> insertFormDataModel(usuarios formDataModel) async {
    await _usuariosInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoUBIGEO extends FormDataModelDaoUBIGEO {
  _$FormDataModelDaoUBIGEO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _ubigeoInsertionAdapter = InsertionAdapter(
            database,
            'Ubigeo',
            (Ubigeo item) => <String, Object?>{
                  'id': item.id,
                  'codigoImei': item.codigoImei,
                  'nombre_departamento': item.nombre_departamento,
                  'nombre_provincia': item.nombre_provincia,
                  'nombre_distrito': item.nombre_distrito
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Ubigeo> _ubigeoInsertionAdapter;

  @override
  Future<List<Ubigeo>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Ubigeo LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Ubigeo(
            id: row['id'] as int?,
            codigoImei: row['codigoImei'] as String?,
            nombre_departamento: row['nombre_departamento'] as String?,
            nombre_provincia: row['nombre_provincia'] as String?,
            nombre_distrito: row['nombre_distrito'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Ubigeo>> findAllUBIGEO() async {
    return _queryAdapter.queryList('SELECT * FROM Ubigeo',
        mapper: (Map<String, Object?> row) => Ubigeo(
            id: row['id'] as int?,
            codigoImei: row['codigoImei'] as String?,
            nombre_departamento: row['nombre_departamento'] as String?,
            nombre_provincia: row['nombre_provincia'] as String?,
            nombre_distrito: row['nombre_distrito'] as String?));
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Ubigeo',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int ID) async {
    return _queryAdapter.query('DELETE FROM Ubigeo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [ID]);
  }

  @override
  Future<List<String>> TraerDepartamentos() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT nombre_departamento FROM Ubigeo ORDER BY nombre_departamento',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<List<String>> TraerProvincias() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT nombre_provincia FROM Ubigeo ORDER BY nombre_provincia',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<List<String>> TraerDistritos() async {
    return _queryAdapter.queryList(
        'SELECT DISTINCT nombre_distrito FROM Ubigeo ORDER BY nombre_distrito',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE FROM Ubigeo',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(Ubigeo formDataModel) async {
    await _ubigeoInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}
