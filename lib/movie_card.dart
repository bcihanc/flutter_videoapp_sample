import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_videoapp_sample/models/MovieModel.dart';
import 'package:flutter_videoapp_sample/movie_app.dart';
import 'package:flutter_videoapp_sample/movie_details_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HorizontalMovieList extends StatelessWidget {
  const HorizontalMovieList(
      {Key key, @required this.header, @required this.movies})
      : super(key: key);

  final String header;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$header'),
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children:
                  movies.map((movie) => MovieCard(movieModel: movie)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key key, this.movieModel})
      : assert(movieModel != null),
        super(key: key);

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetails(movie: movieModel)));
          context.read(homePlayerControllerProvider).pause();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Hero(
            tag: '${movieModel.poster}',
            child: CachedNetworkImage(
                fit: BoxFit.fill, imageUrl: movieModel.poster),
          ),
        ),
      ),
    );
  }
}
