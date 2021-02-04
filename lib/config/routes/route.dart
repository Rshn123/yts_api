import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/screens/main/main_screen.dart';
import 'package:yts/modules/dashboard/screens/movie_detail_screen.dart';

class AppRoute{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return _getPageRoute(viewToShow:MainScreen());
      case movieDetailPageRoute:
        return _getPageRoute(viewToShow: MovieDetailScreen(data: settings.arguments));
    }
  }
}

PageRoute _getPageRoute({Widget viewToShow}) {
  return MaterialPageRoute(
      builder: (_) => viewToShow);
}
