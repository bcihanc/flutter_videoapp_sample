// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieModel _$_$_MovieModelFromJson(Map<String, dynamic> json) {
  return _$_MovieModel(
    title: json['title'] as String,
    year: json['year'] as String,
    rated: json['rated'] as String,
    released: json['released'] as String,
    runtime: json['runtime'] as String,
    genre: json['genre'] as String,
    director: json['director'] as String,
    writer: json['writer'] as String,
    actors: json['actors'] as String,
    plot: json['plot'] as String,
    language: json['language'] as String,
    country: json['country'] as String,
    awards: json['awards'] as String,
    poster: json['poster'] as String,
    ratings: (json['ratings'] as List)
        ?.map((e) =>
            e == null ? null : RatingsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    metascore: json['metascore'] as String,
    imdbRating: json['imdbRating'] as String,
    imdbVotes: json['imdbVotes'] as String,
    imdbID: json['imdbID'] as String,
    type: json['type'] as String,
    totalSeasons: json['totalSeasons'] as String,
    response: json['response'] as String,
    videoID: json['videoID'] as String,
  );
}

Map<String, dynamic> _$_$_MovieModelToJson(_$_MovieModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'rated': instance.rated,
      'released': instance.released,
      'runtime': instance.runtime,
      'genre': instance.genre,
      'director': instance.director,
      'writer': instance.writer,
      'actors': instance.actors,
      'plot': instance.plot,
      'language': instance.language,
      'country': instance.country,
      'awards': instance.awards,
      'poster': instance.poster,
      'ratings': instance.ratings,
      'metascore': instance.metascore,
      'imdbRating': instance.imdbRating,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbID,
      'type': instance.type,
      'totalSeasons': instance.totalSeasons,
      'response': instance.response,
      'videoID': instance.videoID,
    };

_$_RatingsModel _$_$_RatingsModelFromJson(Map<String, dynamic> json) {
  return _$_RatingsModel(
    source: json['source'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$_$_RatingsModelToJson(_$_RatingsModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'value': instance.value,
    };
