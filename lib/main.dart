import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ro_transit_app/Blocs/Theme/bloc/theme_bloc.dart';
import 'package:ro_transit_app/Utils/Themes.dart';

//Other pages
import 'Pages/Home.dart';
import 'Pages/WebView.dart';

//Classes
import 'Utils/Operators.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeChosen>(
        builder: (context, state) {
          return MaterialApp(
            //theme: GlobalTheme,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: state.theme,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              if (settings.name == "/WebView") {
                final arg = settings.arguments as Operator;
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                          WebView(SelectedOperator: arg),
                );
              }
              return null;
            },
            routes: {
              '/home': (context) => const Home(),
              //'/notifications': (context) => const Notifications(),
              //'/debug': (context) => const DebugPage(),
              //'/stats': (context) => const Statistics(),
              //'/vehicles': (context) => const Vehicles(),
              //'/settings': (context) => const Settings()
            },
            home: const Home(),
          );
        },
      ),
    );
  }
}
