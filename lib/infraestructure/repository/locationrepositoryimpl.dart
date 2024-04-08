import 'package:location/location.dart';
import 'locationrepository.dart';

class LocationRepositoryImpl implements LocationRepository {

  Location location = Location();

  @override
  Future<bool> isEnableServiceLocation() async {

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return Future(() => serviceEnabled);
  }

  @override
  Future<bool> isHasPermission() async {
    // TODO: implement isHasPermission
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    bool isGranted = permissionGranted == PermissionStatus.granted
        ? true
        : false;
    return Future(() => isGranted);
  }

  @override
  Future<LocationData> getCoordinates() async {
    return await location.getLocation();
  }

}