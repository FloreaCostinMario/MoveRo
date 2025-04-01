import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ro_transit_app/Blocs/Operators/operators_bloc.dart';
import 'package:ro_transit_app/Utils/GeolocationUtils.dart';
import 'package:ro_transit_app/Widgets/OperatorCard.dart';

Future<Widget> GetCloseOperators() async {
  try {
    Position position = await GetLocation(ShouldAskForPermission: true);

    return OperatorCardsWidget(pos: position);
  } catch (e) {
    return Future.error(e);
  }
}

class OperatorCardsWidget extends StatelessWidget {
  final Position pos;

  const OperatorCardsWidget({Key? key, required this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Operators = context.watch<OperatorsBloc>().state;

    if (Operators is! OperatorsLoaded) {
      return RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.error_outline, color: Colors.red, size: 14),
            ),
            TextSpan(
              text: " Lista de operatori nu a putut fi incarcata",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    List<Widget> CardList = [];
    LatLng Position = LatLng(pos.latitude, pos.longitude);

    //Determine closest operators
    for (var ServiceOperator in Operators.Operators) {
      print(ServiceOperator.Name);

      final Dist = Distance().as(
        LengthUnit.Kilometer,
        Position,
        ServiceOperator.ZoneCenter,
      );

      if ((Dist - (pos.accuracy / 1000)) < ServiceOperator.ZoneRadius + 5) {
        CardList.add(OperatorCard(ServiceOperator: ServiceOperator));
      }
    }

    /*
      final Dist = Distance().as(
        LengthUnit.Kilometer,
        Position,
        ServiceOperator.ZoneCenter,
      );

      print("dist from center ${Dist}");
      print("accuracy ${pos.accuracy}");

      print("determining zone");
      print("zone size ${(Dist - (pos.accuracy / 1000))}");
      print("operator zone ${ServiceOperator.ZoneRadius + 5}");
      if ((Dist - (pos.accuracy / 1000)) < ServiceOperator.ZoneRadius + 5) {
        print("ZONNNAA ZONNNAA");
        CardList.add(OperatorCard(ServiceOperator: ServiceOperator));
      }
    }
    */

    //If no close operators nearby.
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
}
