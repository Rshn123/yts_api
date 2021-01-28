import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/modules/dashboard/providers/movie_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    var movieData = Provider.of<MovieProvider>(context, listen: false);
    movieData.getAllMovie(context);
  }

  @override
  Widget build(BuildContext context) {
    var movieData = Provider.of<MovieProvider>(context);
    print("Build");
    return Scaffold(
      appBar: AppBar(
        title: Text("YTS-API"),
      ),
      body: Center(
        child: movieData.isLoading?CircularProgressIndicator():
        ListView.builder(
            itemCount: movieData.allMovieData.length,
            itemBuilder: (BuildContext context, int index){
            return Row(
              children: [
                Container(
                  width: 100,
                    height: 100,
                    child: Image.network(movieData.allMovieData[index].mediumCoverImage, fit: BoxFit.scaleDown),),
                Card(
                  child: Text(
                    "${movieData.allMovieData[index].id}"
                  )
                ),
              ],
            );
        }),
      ),
    );
  }
}
