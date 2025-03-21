import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ro_transit_app/Utils/GeolocationUtils.dart';
import 'package:ro_transit_app/Widgets/OperatorCard.dart';

Future<Widget> GetCloseOperators() async {
  try {
    Position position = await GetLocation(ShouldAskForPermission: true);

    return GenerateOperatorCards(position);
  } catch (e) {
    return Future.error(e);
  }
}

Widget GenerateOperatorCards(Position pos) {
  List<Widget> CardList = [];
  LatLng Position = LatLng(pos.latitude, pos.longitude);

  //Replace with operator data from list
  for (var ServiceOperator in []) {
    final Dist = Distance().as(
      LengthUnit.Kilometer,
      Position,
      ServiceOperator.ZoneCenter,
    );

    if ((Dist - (pos.accuracy / 1000)) < ServiceOperator.ZoneRadius + 5) {
      CardList.add(OperatorCard(ServiceOperator: ServiceOperator));
    }
  }

  if (CardList.isEmpty) {
    return RichText(
      text: const TextSpan(
        children: [
          WidgetSpan(child: Icon(Icons.search_off_rounded, size: 14)),
          TextSpan(text: "Niciun operator in zona ta :["),
        ],
      ),
    );
  } else {
    return Column(children: CardList);
  }
}
