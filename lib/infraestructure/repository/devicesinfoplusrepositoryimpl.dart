import 'dart:io';
import 'package:device_imei/device_imei.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tayta/infraestructure/repository/devicesinfoplusrepository.dart';

class DevicesInfoPlusRepositoryImpl implements DevicesInfoPlusRepository {

  final _deviceImeiPlugin = DeviceImei();

  @override
  Future<String?> getImei() async {
    return await _deviceImeiPlugin.getDeviceImei();
  }

  @override
  Future<bool> isHasPermission() async {
    var permission = await Permission.phone.status;
    if (Platform.isAndroid) {
      if (permission.isRestricted) {
        var isGrantedWhenIsRestriced = await Permission.phone.request();
        if(isGrantedWhenIsRestriced == PermissionStatus.granted){
          return Future(() => true);
        } else {
          return Future(() => false);
        }
      }
      if (permission.isGranted) {
        return Future(() => true);
      } else {
        PermissionStatus status = await Permission.phone.request();
        if (status == PermissionStatus.granted) {
          return Future(() => true);
        } else {
          return Future(() => false);
        }
      }
    } else {
      return Future(() => false);
    }
  }

  @override
  Future<List<String>> getSizeSystemTemp() {
    List<String> espacio = List.empty(growable: true);

    var stat = FileStat.statSync(Directory.systemTemp.path);
    var available = stat.size;
    var total = stat.size;

    var totalMB = total / 1024 / 1024;
    var availableMB = available / 1024 / 1024;

    String free;
    if (total > 0) {
      free = '$availableMB';
    } else {
      free = '0.0';
    }
    espacio.add('$totalMB');
    espacio.add(free);
    return Future(() => espacio);
  }

}