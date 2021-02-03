import 'dart:convert';
import 'dart:io';

import 'package:yts/modules/dashboard/models/movie_data.dart';
import 'package:http/http.dart' as http;
String url ="https://yts.mx/api/v2/list_movies.json";

Future<List<MovieData>> getAllMovieData(context) async{
  var movieData = List<MovieData>();
  try{
    http.Response response = await http.get("$url?limit=30");
    int statusCode = response.statusCode;

    if(statusCode == 200){
      Map<String, dynamic> movieDatas= Map<String, dynamic>.from(json.decode(response.body));
      movieData = (movieDatas["data"]["movies"] as List).map((val)=>MovieData.fromJson(val)).toList();
    }
  }on SocketException{
    return null;
  }
  return movieData;
}