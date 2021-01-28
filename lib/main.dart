import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/modules/dashboard/providers/movie_provider.dart';

import 'modules/dashboard/screens/main/main_screen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MovieProvider>(
            create: (_) => MovieProvider(),
          )
        ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home:MainScreen(),
    );
  }
}

