import 'package:geolocator/geolocator.dart';

Future<Position> GetLocation({bool? ShouldAskForPermission}) async {
  ShouldAskForPermission ??= false;

  try {
    //Location service check
    if (await Geolocator.isLocationServiceEnabled() != true) {
      return Future.error('Locatia este dezactivata');
    }

    //Permision handler
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permisiunea de locatie este respinsa permanent.");
    } else if (permission == LocationPermission.denied) {
      if (!ShouldAskForPermission) {
        return Future.error("Nu avem permisiunea de locatie!");
      }

      //ask for permision
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Permisiunea de locatie este respinsa permanent.");
      } else if (permission == LocationPermission.denied) {
        return Future.error("Permisiunea de locatie este respinsa");
      }
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
    );
  } catch (e) {
    return Future.error("An error has occured: $e");
  }
}
