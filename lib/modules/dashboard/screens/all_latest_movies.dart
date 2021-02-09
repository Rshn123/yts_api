
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as Provider;
import 'package:yts/constants/app_color.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/providers/movie_provider.dart';
import 'package:yts/modules/dashboard/screens/widgets/custom_grid_view.dart';

class AllLatestMovies extends StatefulWidget {
  @override
  _AllLatestMoviesState createState() => _AllLatestMoviesState();
}

class _AllLatestMoviesState extends State<AllLatestMovies> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var latestMovieData = Provider.Provider.of<MovieProvider>(context, listen: false);
    latestMovieData.getAllLatestMovie(context);
  }

  Widget _headerText(String text) {
    return Text("$text",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(offset: Offset(0, 3), blurRadius: 6, color: Colors.green)
            ],
            fontSize: 20));
  }

  @override
  Widget build(BuildContext context) {
    var latestMovieData = Provider.Provider.of<MovieProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var heightRatio;
    if( height >= 760 == true ){
      heightRatio = height/1.62;
    }
    else{
      heightRatio = height/1.28;
    }
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Align(
            alignment: Alignment(-0.3, 0.0),
            child:
                _headerText("Latest Movies")

          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 1,
      ),
      body: CustomGridView(width: width, heightRatio: heightRatio, latestMovieData: latestMovieData),
    );
  }
}


