import 'package:flutter/cupertino.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';
import 'package:yts/utils/api/movie_api.dart';

class MovieProvider extends ChangeNotifier{
  List<MovieData> popularMovieData =  List<MovieData>();
  List<MovieData> latestMovieData =  List<MovieData>();
  List<MovieData> upcomingMovieData =  List<MovieData>();
  List<MovieData> movieDataGenre =  List<MovieData>();
  var isLoading = false;

  getAllPopularMovie(context) async{
    isLoading = true;
    popularMovieData = await getAllPopularMovieData(context);
    isLoading = false;
    notifyListeners();
  }

  getLatestMovie(context) async{
    isLoading = true;
    latestMovieData = await getAllLatestMovieData(context);
    isLoading = false;
    notifyListeners();
  }

  getMovieGenre(context, String genre) async{
    isLoading = true;
    movieDataGenre = await getMovieDataGenre(context, genre);
    isLoading = false;
    notifyListeners();
  }

  getUpcomingMovie(context) async{
    isLoading = true;
    upcomingMovieData = await getUpcomingMovies(context);
    isLoading = false;
    notifyListeners();
  }

}