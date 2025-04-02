import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ro_transit_app/Utils/Operators.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:appcheck/appcheck.dart';

Future<bool?> HasAppInstalled(String? AndroidPackageName) async {
  if (AndroidPackageName == null || AndroidPackageName.isEmpty) {
    return Future<bool?>.value(null);
  }

  try {
    final appcheck = AppCheck();
    //Is on android
    if (Platform.isAndroid) {
      //App instaled
      if (await appcheck.isAppInstalled(AndroidPackageName) == true) {
        //App enabled
        return await appcheck.isAppEnabled(AndroidPackageName);
      } else {
        return false;
      }
    } else {
      return Future<bool?>.value(false);
    }
  } catch (e) {
    return Future.error(e);
  }
}

class CardNote extends StatelessWidget {
  final optionalParameters;

  const CardNote({super.key, required this.optionalParameters});

  @override
  Widget build(BuildContext context) {
    if (optionalParameters["note"] == null) {
      return SizedBox.shrink();
    } else {
      return Text(
        "Judet: ${optionalParameters["note"]}",
        style: TextStyle(fontStyle: FontStyle.italic),
      );
    }
  }
}

class OperatorCard extends StatelessWidget {
  final Operator ServiceOperator;

  const OperatorCard({super.key, required this.ServiceOperator});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Builder(
        builder:
            (context) => Column(
              children: [
                Text(
                  ServiceOperator.Name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Judet: ${ServiceOperator.County}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed:
                          ServiceOperator.ViewLink != null
                              ? () {
                                Navigator.of(context).pushNamed(
                                  "/${ServiceOperator.ViewMode}",
                                  arguments: ServiceOperator,
                                );
                              }
                              : null,
                      label: Text("Deschide"),
                      icon: Icon(Icons.language),
                    ),
                    FutureBuilder(
                      future: HasAppInstalled(
                        ServiceOperator.AndroidPackageName,
                      ),
                      builder: (context, snapshot) {
                        if ((snapshot.connectionState ==
                                ConnectionState.waiting) ||
                            (snapshot.hasError) ||
                            (snapshot.data == false)) {
                          return TextButton.icon(
                            onPressed: () {
                              launchUrl(
                                Uri.parse(
                                  "https://play.google.com/store/apps/details?id=${ServiceOperator.AndroidPackageName}",
                                ),
                                mode: LaunchMode.platformDefault,
                              );
                            },
                            label: Text("Instaleaza"),
                            icon: Icon(Icons.install_mobile_rounded),
                          );
                        } else if (snapshot.data == null) {
                          return TextButton.icon(
                            onPressed: null,

                            label: Text("Nu are aplicatie"),
                            icon: Icon(Icons.open_in_new_rounded),
                          );
                        } else {
                          return TextButton.icon(
                            onPressed: () {
                              AppCheck().launchApp(
                                ServiceOperator.AndroidPackageName ??
                                    "com.example",
                              );
                            },

                            label: Text("Deschide"),
                            icon: Icon(Icons.open_in_new_rounded),
                          );
                        }
                      },
                    ),
                  ],
                ),
                CardNote(optionalParameters: ServiceOperator.OptionalParams),
              ],
            ),
      ),
    );
  }
}
