import 'package:flutter/material.dart';
import 'package:yts/constants/app_color.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';

class MainScreenGridView extends StatelessWidget {
  const MainScreenGridView(
      {Key key,
      @required this.width,
      @required this.heightRatio,
      @required this.movieData})
      : super(key: key);

  final double width;
  final double heightRatio;
  final List<MovieData> movieData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: width / heightRatio, crossAxisCount: 2),
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
                            Navigator.pushNamed(context, movieDetailPageRoute,
                                arguments: movieData[index]);
                          },
                          child: Container(
                            height: 200,
                            width: 140,
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 4, color: Colors.white)
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      movieData[index].mediumCoverImage,
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(height: 4),
                        Column(children: [
                          Text("${movieData[index].title}",
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
}
