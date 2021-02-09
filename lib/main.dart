import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yts/config/routes/route.dart';
import 'package:yts/constants/app_constants.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
    onGenerateRoute: AppRoute.generateRoute,
      initialRoute: homeRoute,
      debugShowCheckedModeBanner: false,
      home:MainScreen()
    );
  }
}

