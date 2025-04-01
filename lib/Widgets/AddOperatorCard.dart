import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddOperatorCard extends StatelessWidget {
  const AddOperatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Builder(
        builder:
            (context) => Column(
              children: [
                Text(
                  "Nu am gasit nici un operator :(",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Nu am gasit un operator care sa se potriveasca cautari tale",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed:
                          () => launchUrl(
                            Uri.parse(
                              "https://github.com/FloreaCostinMario/MoveRo/blob/main/ADD_OPERATORS.md",
                            ),
                            mode: LaunchMode.platformDefault,
                          ),
                      label: Text("Adauga un nou operator"),
                      icon: Icon(Icons.add_rounded),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
