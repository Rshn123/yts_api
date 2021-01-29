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
        appBar: AppBar(title: Center(child: Text("YTS", style: TextStyle(
          color: Colors.green
        )),),
        backgroundColor: Colors.white,
        elevation: 0,),
        body: movieData.isLoading
            ? CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.6),
                    crossAxisCount: 2),
                itemCount: movieData.allMovieData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 240,
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(2, 3),
                                        spreadRadius: 2,
                                        color: Colors.black)
                                  ],
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        movieData.allMovieData[index]
                                            .mediumCoverImage,
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(height: 4),
                            Column(children: [
                              Text("${movieData.allMovieData[index].title}")
                            ]),
                          ],
                        ),
                      ),
                    ],
                  );
                }));
  }
}
