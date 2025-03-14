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

  Map<String, dynamic> toJson() => {
    "name": Name,
    "county": County,
    "zone": {"center": ZoneCenter, "radius": ZoneRadius},
    "viewmode": ViewMode,
    "viewlink": ViewLink,
    "packages": {"android": AndroidPackageName, "ios": IosPackageName},
    "optional": {},
  };

  factory Operator.fromJson(Map<String, dynamic> json) => Operator(
    json["name"],
    json["county"],
    ZoneCenter: LatLng(json["zone"]["center"][0], json["zone"]["center"][1]),
    ZoneRadius: json["zone"]["radius"],
    ViewMode: json["viewmode"],
    ViewLink: json["viewlink"],
    AndroidPackageName: json["packages"]["android"],
    IosPackageName: json["packages"]["ios"],
    OptionalParams: json["optional"],
  );
}

/*
List<Operator> ConfigOperatorList = [
  Operator(
    "Societatea de Transport Bucuresti",
    "Bucuresti - Ilfov",
    ZoneCenter: LatLng(44.435408, 26.102778),
    ZoneRadius: 40.62,
    ViewMode: "WebView",
    ViewLink: "https://info.stb.ro/",
    AndroidPackageName: "ro.stbsa",
  ),
  Operator(
    "CT Bus Constanta",
    "Constanta",
    ZoneCenter: LatLng(44.176718, 28.651657),
    ZoneRadius: 16.52,
    ViewMode: "WebView",
    ViewLink: "https://info.ctbus.ro/",
    AndroidPackageName: "ro.ratc",
  ),
  Operator(
    "Transurbis (Zalău)",
    "Salaj",
    ZoneCenter: LatLng(47.1797, 23.0588),
    ZoneRadius: 5,
    ViewMode: "WebView",
    ViewLink: "https://carduri.tuz.ro/",
    AndroidPackageName: "ro.zlu",
  ),
  Operator(
    "Oradea Transport Local",
    "Bihor",
    ZoneCenter: LatLng(44.176718, 28.651657),
    ZoneRadius: 5.5,
    ViewMode: "WebView",
    ViewLink: "https://abonamente.otl.ro/",
    AndroidPackageName: "ro.otl",
  ),
  Operator(
    "Oradea Transport Local \n (Aplicatie Tranzy)",
    "Bihor",
    ZoneCenter: LatLng(44.176718, 28.651657),
    ZoneRadius: 5.5,
    ViewMode: "WebView",
    ViewLink: "https://apps.tranzy.ai/map/otl-ro",
    AndroidPackageName: "ro.otl",
  ),
  Operator(
    "Transport Urban Satu Mare",
    "Satu Mare",
    ZoneCenter: LatLng(47.7886, 22.8735),
    ZoneRadius: 5,
    ViewMode: "WebView",
    ViewLink: "https://info.tusm.ro/",
    AndroidPackageName: "ro.sm",
  ),

  Operator(
    "CTP Iasi",
    "Iasi",
    ZoneCenter: LatLng(47.16222, 27.58889),
    ZoneRadius: 17,
    ViewMode: "WebView",
    ViewLink: "https://info.sctpiasi.ro/",
    AndroidPackageName: "ro.iasi.ctp",
  ),

  Operator(
    "CTP Iasi (Tranzy)",
    "Iasi",
    ZoneCenter: LatLng(47.16222, 27.58889),
    ZoneRadius: 17,
    ViewMode: "WebView",
    ViewLink: "https://apps.tranzy.ai/map/sctp-is-ro?lang=ro",
    AndroidPackageName: "com.winkgo",
  ),

  Operator(
    "CTP Cluj-Napoca",
    "Cluj",
    ZoneCenter: LatLng(46.7820, 23.6268),
    ZoneRadius: 14,
    ViewMode: "WebView",
    ViewLink: "https://apps.tranzy.ai/map/ctp-cj-ro",
    AndroidPackageName: "com.winkgo",
  ),

  Operator(
    "Societatea de Transport Public Timișoara",
    "Timis",
    ZoneCenter: LatLng(45.7590, 21.2194),
    ZoneRadius: 16.3,
    ViewMode: "WebView",
    ViewLink: "https://apps.tranzy.ai/map/stpt-tm-ro",
    AndroidPackageName: "com.winkgo",
  ),

  Operator(
    "Elatrans (Botosani)",
    "Botosani",
    ZoneCenter: LatLng(47.7533, 26.6760),
    ZoneRadius: 16.3,
    ViewMode: "WebView",
    ViewLink: "https://apps.tranzy.ai/map/eltrans-bt-ro",
    AndroidPackageName: "com.winkgo",
  ),

  Operator(
    "Tursib (Sibiu)",
    "Sibiu",
    ZoneCenter: LatLng(47.7533, 26.6760),
    ZoneRadius: 16.3,
    ViewMode: "WebView",
    ViewLink: "https://ro-sibiu-pia-2.thoreb.com/InfoThorebWeb/",
    AndroidPackageName: "snt.eticketing.mobileapp",
  ),

  //TEST ENTRY
  /*
  Operator(
    "Test",
    "Sibiu",
    ZoneCenter: LatLng(47.7533, 26.6760),
    ZoneRadius: 16.3,
    ViewMode: "WebView",
    ViewLink: null,
    AndroidPackageName: null,
  ),
  */
  Operator(
    "RAT Craiova",
    "Dolj",
    ZoneCenter: LatLng(44.3234, 23.8069),
    ZoneRadius: 14.3,
    ViewMode: "WebView",
    //Planner link would be ideal but Telelink code is not web responsive (https://craiova-transport.com/app/planner)
    ViewLink: "https://craiova-transport.com/",
    AndroidPackageName: "com.modeshift.craiova",
  ),

  Operator(
    "Braicar",
    "Braila",
    ZoneCenter: LatLng(45.2723, 27.9657),
    ZoneRadius: 10,
    ViewMode: "WebView",
    ViewLink: "https://braila-transport.com/",
    AndroidPackageName: "com.modeshift.braila",
  ),

  Operator(
    "Trans Bus Buzau",
    "Buzau",
    ZoneCenter: LatLng(45.1377, 26.8203),
    ZoneRadius: 20,
    ViewMode: "WebView",
    ViewLink: "https://buzau-transport.com/",
    AndroidPackageName: "com.modeshift.buzau",
  ),

  Operator(
    "Bocsa",
    "Caraș-Severin",
    ZoneCenter: LatLng(45.37788, 21.73128),
    ZoneRadius: 3,
    ViewMode: "WebView",
    ViewLink: "https://bocsa-transport.telelink.city/",
    AndroidPackageName: "com.modeshift.bocsa",
  ),

  Operator(
    "TPU Drobeta",
    "Mehedinti",
    ZoneCenter: LatLng(44.6256, 22.6515),
    ZoneRadius: 5.72,
    ViewMode: "WebView",
    ViewLink: "https://drobeta-transport.telelink.city/",
    AndroidPackageName: "com.modeshift.drobeta",
  ),

  Operator(
    "Transport Public Focsani",
    "Vrancea",
    ZoneCenter: LatLng(45.6991, 27.1858),
    ZoneRadius: 11.6,
    ViewMode: "WebView",
    ViewLink: "https://focsani-transport.telelink.city/",
    AndroidPackageName: "com.modeshift.focsani",
  ),
  Operator(
    "CTP Arad",
    "Arad",
    ZoneCenter: LatLng(46.17527, 21.31976),
    ZoneRadius: 9.83,
    ViewMode: "WebView",
    ViewLink: "https://arad-transport.telelink.city/",
    AndroidPackageName: "com.modeshift.arad",
  ),
  Operator(
    "Transurb Dej",
    "Cluj",
    ZoneCenter: LatLng(47.14267, 23.87601),
    ZoneRadius: 11,
    ViewMode: "WebView",
    ViewLink: null,
    AndroidPackageName: "com.modeshift.dej",
  ),
  Operator(
    "Meditur",
    "Sibiu",
    ZoneCenter: LatLng(46.1612, 24.3481),
    ZoneRadius: 6.57,
    ViewMode: "WebView",
    ViewLink: "https://medias-transport.telelink.city/",
    AndroidPackageName: "com.modeshift.meditur",
  ),
  Operator(
    "Transport Public Tulcea",
    "Tulcea",
    ZoneCenter: LatLng(45.17832, 28.80093),
    ZoneRadius: 6.33,
    ViewMode: "WebView",
    ViewLink: "https://tulcea-transport.com/",
    AndroidPackageName: "com.modeshift.tulcea",
  ),
  Operator(
    "Transmixt",
    "Bistrita-Nasaud",
    ZoneCenter: LatLng(47.1347, 24.4991),
    ZoneRadius: 61.33,
    ViewMode: "WebView",
    ViewLink: "https://bistrita-transport.com/",
    AndroidPackageName: "com.modeshift.bistrita",
  ),
  Operator(
    "Transport Public Sinaia",
    "Prahova",
    ZoneCenter: LatLng(45.34515, 25.54804),
    ZoneRadius: 3.17,
    ViewMode: "WebView",
    ViewLink: "https://sinaia-transport.com/",
    AndroidPackageName: "com.modeshift.sinaia",
  ),
  Operator(
    "RAT Brasov",
    "Brasov",
    ZoneCenter: LatLng(45.65239, 25.61061),
    ZoneRadius: 48,
    ViewMode: "WebView",
    ViewLink: "https://routing.ratbv.ro/",
    AndroidPackageName: null,
  ),
  Operator(
    "Transurb Galati",
    "Galati",
    ZoneCenter: LatLng(45.4340, 28.0570),
    ZoneRadius: 8.87,
    ViewMode: "WebView",
    ViewLink: "https://info.transportgalati.ro/",
    AndroidPackageName: "ro.transurbgalati.mobile",
  ),
];
*/
