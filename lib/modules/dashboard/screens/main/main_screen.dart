import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/constants/app_color.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';
import 'package:yts/modules/dashboard/providers/movie_provider.dart';
import 'package:yts/modules/dashboard/screens/widgets/main_screen_grid_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScrollController _scrollViewContainer;

  @override
  void initState() {
    super.initState();
    _scrollViewContainer = new ScrollController();
    var movieData = Provider.of<MovieProvider>(context, listen: false);
    movieData.getAllPopularMovie(context);
    movieData.getLatestMovie(context);
    movieData.getUpcomingMovie(context);
  }

  @override
  void dispose() {
    _scrollViewContainer.dispose();
    super.dispose();
  }

  Widget _gridCardView(List<MovieData> movieData) {
    var height = MediaQuery.of(context).size.height;
    var heightRatio;
    if (height >= 760 == true) {
      heightRatio = height / 1.62;
    } else {
      heightRatio = height / 1.28;
    }
    var width = MediaQuery.of(context).size.width;
    return MainScreenGridView(
        width: width, heightRatio: heightRatio, movieData: movieData);
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
    var movieData = Provider.of<MovieProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        body: NestedScrollView(
            controller: _scrollViewContainer,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Center(
                    child: Text("YTS",
                        style: TextStyle(color: Colors.green, fontSize: 25)),
                  ),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: backgroundColor,
                  elevation: 1,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(45),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15,0,15,0),
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              hintText: 'Enter a search term'),
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
            body: movieData.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: _headerText("Latest YIFY Movies Torrents"),
                          ),
                          SizedBox(height: 10),
                          _gridCardView(movieData.latestMovieData),
                          SizedBox(height: 3),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, allLatestMoviePageRoute);
                            },
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 25, 0),
                                  child: Text("Browse All..",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Colors.white.withOpacity(0.5))),
                                )),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: _headerText("Upcoming YIFY Movies"),
                          ),
                          SizedBox(height: 10),
                          _gridCardView(movieData.upcomingMovieData)
                        ],
                      ),
                    ],
                  )));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 15, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("YTS", style: TextStyle(color: Colors.green, fontSize: 30)),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 15, color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: 'Enter a search term'),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
