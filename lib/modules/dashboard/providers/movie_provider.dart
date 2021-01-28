import 'package:flutter/cupertino.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';
import 'package:yts/utils/api/movie_api.dart';

class MovieProvider extends ChangeNotifier{
  List<MovieData> allMovieData =  List<MovieData>();
  var isLoading = false;

  getAllMovie(context) async{
    isLoading = true;
    allMovieData = await getAllMovieData(context);
    print(allMovieData);
    isLoading = false;
    notifyListeners();
  }

}