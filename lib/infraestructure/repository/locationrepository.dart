import 'package:location/location.dart';

abstract class LocationRepository {
  Future<bool> isEnableServiceLocation();
  Future<bool> isHasPermission();
  Future<LocationData> getCoordinates();
}