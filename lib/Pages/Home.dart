import 'package:flutter/material.dart';
import 'package:ro_transit_app/Blocs/Operators/operators_bloc.dart';
import 'package:ro_transit_app/Utils/Operators.dart';
import 'package:ro_transit_app/Widgets/CloseOperators.dart';
import 'package:ro_transit_app/Widgets/OperatorCard.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Selecteaza operatorul",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: "Bahnschrift",
            fontFamilyFallback: ["Helvetica", "Arial"],
          ),
        ),
        leading: null,
        actions: [
          IconButton(
            onPressed:
                () => launchUrl(
                  Uri.parse("https://github.com"),
                  mode: LaunchMode.externalApplication,
                ),
            icon: Icon(Icons.code),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocProvider(
            create: (context) => OperatorsBloc(),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Operatori in zona",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: "Bahnschrift",
                        fontFamilyFallback: ["Helvetica", "Arial"],
                      ),
                    ),
                    FutureBuilder<Widget>(
                      future: GetCloseOperators(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator.adaptive();
                        } else if (snapshot.hasError) {
                          return RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${snapshot.error.toString()}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return snapshot.data ?? SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Lista operatori",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Bahnschrift",
                          fontFamilyFallback: ["Helvetica", "Arial"],
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<OperatorsBloc, OperatorsState>(
                          builder: (context, state) {
                            if (state is OperatorsInitial) {
                              context.read<OperatorsBloc>().add(
                                FetchOperators(),
                              );
                            } else if (state is OperatorsLoading) {
                              return Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: CircularProgressIndicator(),
                                    ),
                                    Text("Loading operators"),
                                  ],
                                ),
                              );
                            } else if (state is OperatorsErrored) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.ErrorMessage,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is OperatorsLoaded) {
                              return SearchableList(
                                initialList: state.Operators,
                                searchFieldPadding: EdgeInsets.only(
                                  bottom: 5,
                                  top: 5,
                                ),
                                inputDecoration: InputDecoration(
                                  hintText: "Cautare",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(width: 1.0),
                                  ),
                                  focusColor: Theme.of(context).focusColor,
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                ),
                                itemBuilder:
                                    (item) =>
                                        OperatorCard(ServiceOperator: item),
                                sortPredicate:
                                    (a, b) => a.Name.toLowerCase().compareTo(
                                      b.Name.toLowerCase(),
                                    ),
                                filter: (query) {
                                  query = removeDiacritics(query).toLowerCase();

                                  List<Operator> Results = [];

                                  for (var ServiceOperator in state.Operators) {
                                    //Operator name
                                    if (removeDiacritics(
                                      ServiceOperator.Name,
                                    ).toLowerCase().contains(query)) {
                                      Results.add(ServiceOperator);
                                      //County
                                    } else if (removeDiacritics(
                                      ServiceOperator.County,
                                    ).toLowerCase().contains(query)) {
                                      Results.add(ServiceOperator);
                                    }
                                  }

                                  return Results;
                                },
                              );
                            }

                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
