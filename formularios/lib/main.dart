import 'package:flutter/material.dart';
import 'package:formularios/app_routes.dart';
import 'package:formularios/utils/add_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Esconder el teclado cuando hacemos drag sobre la lista
        final focus = FocusScope.of(context);
        final fChild = focus.focusedChild;
        if (fChild != null && !fChild.hasPrimaryFocus) {
          fChild.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Inputs',
        theme: getThemeData(context),
        routes: appRoutes,
        home: const HomePage(),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = appRoutes.keys.toList();
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (_, index) {
          final routeName = routes[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, routeName);
            },
            title: Text(routeName),
          );
        },
        itemCount: routes.length,
      ),
    );
  }
}
