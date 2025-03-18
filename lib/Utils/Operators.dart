import 'package:latlong2/latlong.dart';

class Operator {
  String Name;
  String County;
  LatLng ZoneCenter;
  double ZoneRadius;
  String? ViewMode;
  String? ViewLink;
  String? AndroidPackageName;
  String? IosPackageName;
  Object? OptionalParams;

  Operator(
    this.Name,
    this.County, {
    required this.ZoneCenter,
    required this.ZoneRadius,
    this.ViewMode,
    this.ViewLink,
    this.AndroidPackageName,
    this.IosPackageName,
    this.OptionalParams,
  });

  //No real use at the moment
  Map<String, dynamic> toJson() => {
    "name": Name,
    "county": County,
    "zone": {"center": ZoneCenter, "radius": ZoneRadius},
    "viewmode": ViewMode,
    "viewlink": ViewLink,
    "packages": {"android": AndroidPackageName, "ios": IosPackageName},
    "optional": {},
  };

  //Factory construct for getting operators from external sources
  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      json["name"],
      json["county"],
      ZoneCenter: LatLng(
        json["zone"]["center"]["coordinates"][0],
        json["zone"]["center"]["coordinates"][1],
      ),
      ZoneRadius: json["zone"]["radius"],
      ViewMode: json["viewmode"],
      ViewLink: json["viewlink"],
      AndroidPackageName: json["packages"]["android"],
      IosPackageName: json["packages"]["ios"],
      OptionalParams: json["optional"],
    );
  }
}
