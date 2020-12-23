import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_videoapp_sample/models/MovieModel.dart';
import 'package:flutter_videoapp_sample/movie_details_page.dart';
import 'package:flutter_videoapp_sample/services/playlist_sharedpreferences.dart';
import 'package:flutter_videoapp_sample/utils/movies.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MoviePlayListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _uiUpdater = useState(false);
    final _playlistSharedPreferences =
        useMemoized(() => PlaylistSharedPreferences());

    final _movies = useMemoized(() {
      return kALLMOVIES.map((movie) => MovieModel.fromJson(movie)).toList();
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Playlist'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<String>>(
          initialData: <String>[],
          future: _playlistSharedPreferences.gets(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final playlist = snapshot.data;

              if (playlist.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.deleteEmpty),
                      const SizedBox(height: 10),
                      Text('Playlist empty.'),
                    ],
                  ),
                );
              }

              return ListView.separated(
                  itemCount: playlist?.length ?? 0,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (_, index) {
                    final imdbID = playlist[index];
                    final movie =
                        _movies.firstWhere((movie) => movie.imdbID == imdbID);

                    return Builder(
                        builder: (context) => ListTile(
                              leading: Hero(
                                  tag: '${movie.poster}',
                                  child: CachedNetworkImage(
                                      imageUrl: movie.poster)),
                              title: Text(
                                '${movie.title}',
                                style: TextStyle(fontSize: 24),
                              ),
                              subtitle: Text('${movie.genre}'),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
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

                                    _uiUpdater.value = !_uiUpdater.value;
                                  }),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetails(movie: movie)));
                              },
                            ));
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
