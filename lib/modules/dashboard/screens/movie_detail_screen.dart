import 'package:flutter/material.dart';
import 'package:yts/modules/dashboard/models/movie_data.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieData data;

  MovieDetailScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height / 2 - 50;
    double imageWidth = MediaQuery.of(context).size.width - 135;
    return Scaffold(
      backgroundColor: Color(0xff000000).withOpacity(0.9),
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
        backgroundColor: Color(0xff000000).withOpacity(0.9),
        elevation: 1,
      ),
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        data.backgroundImage,
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
                      color: Color(0xff000000).withOpacity(0.9),

                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(data.largeCoverImage),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
                        )
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
