
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tayta/infraestructure/dao/apis/apiprovider_menuOpciones.dart';
import 'package:tayta/infraestructure/repository/devicesinfoplusrepository.dart';
import 'package:tayta/infraestructure/repository/devicesinfoplusrepositoryimpl.dart';
import 'package:tayta/infraestructure/repository/locationrepository.dart';
import 'package:tayta/infraestructure/repository/locationrepositoryimpl.dart';
import 'package:tayta/splash.dart';
import 'package:tayta/utils/conexionComprobacion.dart';
import 'package:tayta/viewmodels/cubitprueba.dart';
import 'package:sqflite/sqflite.dart';
import 'infraestructure/dao/database/database.dart';

List<CameraDescription>? cameras = <CameraDescription>[];
GetIt getIt = GetIt.instance;



Future<void> main() async {

  InternetChecker.init();

  //PUSO MIGUEL
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("Error: "+e.description.toString());
  }
  HttpOverrides.global = MyHttpOverrides();
  getIt.registerSingletonAsync<Client>(() async => await Future(() => Client()));
  getIt.registerSingletonAsync<LocationRepository>(() async => await Future(() => LocationRepositoryImpl()));
  getIt.registerSingletonAsync<DevicesInfoPlusRepository>(() async => await Future(() => DevicesInfoPlusRepositoryImpl()));
  getIt.registerSingletonAsync<apiprovider_menuOpciones>(() async => await Future(() => apiprovider_menuOpciones()));
  getIt.registerSingletonAsync<AppDatabase>(() async => await $FloorAppDatabase.databaseBuilder('tayta_app_db.db').build());
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [BlocProvider(create: (context) => Cubitprueba()),], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INICIO SPLASH',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}




///////ME LO PASO MIGUEL: CREA UN CERTIFICADO DE CONFIANZA POR DEFAULT A LA LIBRERIA HTTP
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
