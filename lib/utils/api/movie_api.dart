import 'dart:convert';
import 'dart:io';

import 'package:yts/modules/dashboard/models/movie_data.dart';
import 'package:http/http.dart' as http;
String url ="https://yts.mx/api/v2/list_movies.json";
String upcomingMovieUrl =" https://yts.mx/api/v2/list_upcoming.json";

Future<List<MovieData>> getAllPopularMovieData(context) async{
  var movieData = List<MovieData>();
  try{
    http.Response response = await http.get("$url?limit=6&minimum_rating=8");
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

Future<List<MovieData>> getAllLatestMovieData(context) async{
  var movieData = List<MovieData>();
  try{
    http.Response response = await http.get("$url?limit=6&sort_by=year");
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

Future<List<MovieData>> getMovieDataGenre(context, String genre) async{
  var movieData = List<MovieData>();
  try{
    http.Response response = await http.get("$url?genre=$genre&limit=4");
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

Future<List<MovieData>> getUpcomingMovies(context) async{
  var movieData = List<MovieData>();
  try{
    http.Response response = await http.get("$url?limit=4");
    int statusCode = response.statusCode;

    if(statusCode == 200){
      Map<String, dynamic> movieDatas= Map<String, dynamic>.from(json.decode(response.body));
      movieData = (movieDatas["data"]["movies"] as List).map((val)=>MovieData.fromJson(val)).toList();
      print(movieData);
    }
  }on SocketException{
    return null;
  }
  return movieData;
}