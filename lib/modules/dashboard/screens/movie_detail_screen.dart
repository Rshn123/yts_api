import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/constants/app_color.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';
import 'package:yts/modules/dashboard/providers/movie_provider.dart';
import 'package:yts/modules/dashboard/screens/widgets/detail_movie_card.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieData data;

  MovieDetailScreen({Key key, this.data}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Widget _movieName(String movieName) {
    return Text(
      movieName,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32, color: Color(0xffffffff), shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 5,
          offset: Offset(0, 3),
        )
      ]),
    );
  }

  Widget _movieDetail(String movieName) {
    return Text(
      movieName,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, color: Color(0xffffffff), shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 5,
          offset: Offset(0, 3),
        )
      ]),
    );
  }

  Widget _synopsis(String synopsis) {
    return Text(
      synopsis,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: 14,
          color: Color(0xffffffff).withOpacity(0.6),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
    );
  }

  Widget _link(String synopsis) {
    return Text(
      synopsis,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: 14,
          color: Colors.blue.withOpacity(0.9),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
    );
  }

  Widget _availableIn(String quality) {
    return Text(
      "Available in: $quality",
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 20,
          color: Color(0xffffffff),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
    );
  }


  @override
  void initState() {
    super.initState();
    var movieData = Provider.of<MovieProvider>(context, listen: false);
    movieData.getMovieGenre(context, widget.data.genres.first);
  }

  @override
  Widget build(BuildContext context) {
    var movieData = Provider.of<MovieProvider>(context);
    double imageHeight = MediaQuery.of(context).size.height / 2 - 50;
    double imageWidth = MediaQuery.of(context).size.width - 135;
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
            alignment: Alignment(-0.2, 0.0),
            child: Text("YTS",
                style: TextStyle(color: Colors.green, fontSize: 25)),
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 1,
      ),
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.data.backgroundImage,
                      ),
                      fit: BoxFit.cover))),
          ListView(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: imageHeight,
                  width: imageWidth,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(widget.data.largeCoverImage),
                        fit: BoxFit.fill
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
                        )
                      ]),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  children: [
                    _movieName(widget.data.title,),
                    SizedBox(height: 15),
                    _movieDetail(widget.data.year.toString()),
                    _movieDetail(widget.data.genres.join(" / ")),
                    SizedBox(height: 15),
                    _availableIn(widget.data.torrents[0].quality),
                    SizedBox(height: 15),
                    _movieDetail("Synopsis"),
                    SizedBox(height: 10),
                    _synopsis(widget.data.synopsis),
                    SizedBox(height: 15),
                    _movieDetail("Link"),
                    SizedBox(height: 10),
                    _link(widget.data.url),
                    SizedBox(height: 15),
                    _movieDetail("Similar Movie"),
                    SizedBox(height: 10),
                    movieData.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    DetailMovieCard(context: context, index: 0, movieData: movieData),
                                    DetailMovieCard(context: context, index: 2, movieData: movieData)
                                  ],
                                ), Row(
                                  children: [
                                    DetailMovieCard(context: context, index: 3, movieData: movieData),
                                    DetailMovieCard(context: context, index: 1, movieData: movieData),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
