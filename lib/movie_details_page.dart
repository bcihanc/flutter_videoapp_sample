import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_videoapp_sample/models/MovieModel.dart';
import 'package:flutter_videoapp_sample/services/playlist_sharedpreferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends HookWidget {
  const MovieDetails({Key key, this.movie})
      : assert(movie != null),
        super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final _uiUpdater = useState(false);
    final _playlistSharedPreferences =
        useMemoized(() => PlaylistSharedPreferences());

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Builder(builder: (context) {
                return FutureBuilder<bool>(
                    initialData: false,
                    future: _playlistSharedPreferences.contains(movie.imdbID),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        final contain = snapshot.data;

                        return IconButton(
                            icon: Icon(contain
                                ? MdiIcons.playlistRemove
                                : Icons.playlist_add),
                            onPressed: () async {
                              if (contain) {
                                await _playlistSharedPreferences
                                    .clear(movie.imdbID);

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.check),
                                        const SizedBox(width: 4),
                                        Text('${movie.title} removed'),
                                      ],
                                    )));
                              } else {
                                await _playlistSharedPreferences
                                    .add(movie.imdbID);

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.check),
                                        const SizedBox(width: 4),
                                        Text('${movie.title} added'),
                                      ],
                                    )));
                              }

                              _uiUpdater.value = !_uiUpdater.value;
                            });
                      }
                      return SizedBox.shrink();
                    });
              }),
            )
          ],
          title: Row(
            children: [
              Hero(
                tag: '${movie.poster}',
                child: CachedNetworkImage(
                  imageUrl: movie.poster,
                  width: 32,
                  height: 32,
                ),
              ),
              const SizedBox(width: 4),
              Text('${movie.title}'),
            ],
          ),
        ),
        body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: YoutubePlayerController(
                  initialVideoId: movie.videoID,
                  flags: YoutubePlayerFlags(
                    autoPlay: true,
                  )),
            ),
            builder: (context, player) {
              return Column(
                children: [
                  // some widgets
                  player,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${movie.plot}'),
                  ),
                  if (movie.ratings.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (movie.ratings[0] != null)
                            Row(
                              children: [
                                Image.asset('assets/images/movies_app/imdb.png',
                                    width: 32, height: 32),
                                const SizedBox(width: 5),
                                Badge(
                                    badgeColor: Colors.yellow,
                                    borderRadius: BorderRadius.zero,
                                    badgeContent: Text(
                                        '${movie.ratings[0].value}',
                                        style: TextStyle(color: Colors.black)),
                                    shape: BadgeShape.square),
                              ],
                            ),
                          const SizedBox(width: 10),
                          if (movie.ratings[1] != null)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/movies_app/rotten.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 5),
                                Badge(
                                    badgeColor: Colors.red,
                                    borderRadius: BorderRadius.zero,
                                    badgeContent: Text(
                                        '${movie.ratings[1].value}',
                                        style: TextStyle(color: Colors.black)),
                                    shape: BadgeShape.square),
                              ],
                            ),
                          const SizedBox(width: 10),
                          if (movie.ratings[2] != null)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/movies_app/metacritic.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 5),
                                Badge(
                                    badgeColor: Colors.blue,
                                    borderRadius: BorderRadius.zero,
                                    badgeContent: Text(
                                        '${movie.ratings[2].value}',
                                        style: TextStyle(color: Colors.black)),
                                    shape: BadgeShape.square),
                              ],
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                        leading: Icon(MdiIcons.play),
                        title: Text('${movie.actors}'),
                        subtitle: Text('Directors'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.brain),
                        title: Text('${movie.director}'),
                        subtitle: Text('Directors'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.typewriter),
                        title: Text('${movie.writer}'),
                        subtitle: Text('Writers'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.movieFilter),
                        title: Text('${movie.genre}'),
                        subtitle: Text('Genre'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.globeModel),
                        title: Text('${movie.country} - ${movie.language}'),
                        subtitle: Text('Country, Language'),
                      ),
                    ]).toList(),
                  ))
                  //some other widgets
                ],
              );
            }));
  }
}
