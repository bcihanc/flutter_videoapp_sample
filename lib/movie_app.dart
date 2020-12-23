import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_videoapp_sample/models/MovieModel.dart';
import 'package:flutter_videoapp_sample/movie_card.dart';
import 'package:flutter_videoapp_sample/movie_playlist_page.dart';
import 'package:flutter_videoapp_sample/utils/movies.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final homePlayerControllerProvider = Provider<YoutubePlayerController>((_) =>
    YoutubePlayerController(
        initialVideoId: 'n9xhJrPXop4',
        flags: YoutubePlayerFlags(autoPlay: false)));

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        MoviePlayListPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1, 0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class MovieApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.playlist_play,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.push(context, _createRoute());
                  }),
            )
          ],
          expandedHeight: 200.0,
          pinned: true,
          floating: true,
          shadowColor: Colors.red.withOpacity(0.5),
          elevation: 50,
          centerTitle: true,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: Text('Trailerify',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Image.network(
                      'https://longislandexplorium.org/wp-content/uploads/2019/04/spotlight-background.png',
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                      color: Colors.black,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MdiIcons.movieRoll, size: 32),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(''),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            HorizontalMovieList(
              header: 'Sci-Fi',
              movies: kSCIFIMOVIES
                  .map((movie) => MovieModel.fromJson(movie))
                  .toList(),
            ),
            HorizontalMovieList(
              header: 'Romance',
              movies: kROMANCEMOVIES
                  .map((movie) => MovieModel.fromJson(movie))
                  .toList(),
            ),
            HorizontalMovieList(
              header: 'War',
              movies:
                  kWARMOVIE.map((movie) => MovieModel.fromJson(movie)).toList(),
            ),
          ],
        ))
      ]),
    );
  }
}
