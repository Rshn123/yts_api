import 'package:flutter/material.dart';
import 'package:yts/constants/app_constants.dart';
import 'package:yts/modules/dashboard/providers/movie_provider.dart';

class DetailMovieCard extends StatelessWidget {
  const DetailMovieCard({
    Key key,
    @required this.context,
    @required this.index,
    @required this.movieData,
  }) : super(key: key);

  final BuildContext context;
  final int index;
  final MovieProvider movieData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 240,
        width: 140,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context, movieDetailPageRoute,
                  arguments:
                  movieData.movieDataGenre[index], );
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
                    borderRadius:
                    BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                          movieData
                              .movieDataGenre[index]
                              .mediumCoverImage,
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
            SizedBox(height: 6),
            _buildText(),
          ],
        ),
      ),
    );

  }

  Text _buildText() {
    return Text(
              "${movieData.movieDataGenre[index].titleLong}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white));
  }
}
