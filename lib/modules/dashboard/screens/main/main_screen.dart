import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/constants/app_color.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';
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
    movieData.getAllPopularMovie(context);
    movieData.getLatestMovie(context);
    movieData.getUpcomingMovie(context);
  }

  Widget _gridCardView(List<MovieData> movieData){
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio:
            MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height /
                    1.65),
            crossAxisCount: 2),
        itemCount: movieData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 240,
                    width: 140,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, movieDetailPageRoute,
                                arguments: movieData[index]);
                          },
                          child: Container(
                            height: 200,
                            width: 140,
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 4,
                                      color: Colors.white)
                                ],
                                borderRadius:
                                BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      movieData[index].mediumCoverImage,
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(height: 4),
                        Column(children: [
                          Text(
                              "${movieData[index].title}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _headerText(String text){
    return Text("$text",overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white,shadows: [
          Shadow(
            offset: Offset(
              0,3
            ),
            blurRadius: 6,
            color: Colors.green
          )
        ], fontSize: 20));
  }

  @override
  Widget build(BuildContext context) {
    var movieData = Provider.of<MovieProvider>(context);
    print("Build");
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        appBar: AppBar(
          title: Center(
            child: Text("YTS",
                style: TextStyle(color: Colors.green, fontSize: 25)),
          ),
          backgroundColor: backgroundColor,
          elevation: 1,
        ),
        body: movieData.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.green),
                          _headerText("Popular Downloads")
                        ],
                      ),
                      SizedBox(height: 10),
                      _gridCardView(movieData.popularMovieData)
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,
                            0,0,0),
                        child:_headerText("Latest YIFY Movies Torrents"),
                      ),
                      SizedBox(height: 10),
                      _gridCardView(movieData.latestMovieData),
                      SizedBox(height: 3),
                      Align(alignment:Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,25,0),
                            child: Text("Browse All..", style: TextStyle(fontSize:16,
                                color:Colors.white.withOpacity(0.5))),
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,
                            0,0,0),
                        child:_headerText("Upcoming YIFY Movies"),
                      ),
                      SizedBox(height: 10),
                      _gridCardView(movieData.upcomingMovieData)
                    ],
                  ),
                ],
              ));
  }
}
