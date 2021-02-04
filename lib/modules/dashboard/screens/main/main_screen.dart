import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/constants/app_constants.dart';
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
      backgroundColor: Colors.black.withOpacity(0.7),
        appBar: AppBar(title: Center(child: Text("YTS", style: TextStyle(
          color: Colors.green,
          fontSize: 25
        )),),
        backgroundColor: Color(0xff000000).withOpacity(0.9),
        elevation: 1,),
        body: movieData.isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.65),
                    crossAxisCount: 2),
                itemCount: movieData.allMovieData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0,10.0,0,0),
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
                                  onTap:(){
                                    Navigator.pushNamed(context,movieDetailPageRoute, arguments: movieData.allMovieData[index]);
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 4,
                                              color: Colors.white)
                                        ],

                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              movieData.allMovieData[index]
                                                  .mediumCoverImage,
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Column(children: [
                                  Text("${movieData.allMovieData[index].title}",
                                    overflow: TextOverflow.ellipsis, style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ))
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }));
  }
}
