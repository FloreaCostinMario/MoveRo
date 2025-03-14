import 'package:flutter/material.dart';

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
    return MaterialApp(
      //theme: GlobalTheme,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.lightBlue,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
      ),
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
  }
}
