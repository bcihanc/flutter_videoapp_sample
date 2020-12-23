import 'package:freezed_annotation/freezed_annotation.dart';

part 'MovieModel.freezed.dart';
part 'MovieModel.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  const factory MovieModel(
      {String title,
      String year,
      String rated,
      String released,
      String runtime,
      String genre,
      String director,
      String writer,
      String actors,
      String plot,
      String language,
      String country,
      String awards,
      String poster,
      List<RatingsModel> ratings,
      String metascore,
      String imdbRating,
      String imdbVotes,
      String imdbID,
      String type,
      String totalSeasons,
      String response,
      String videoID}) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(fixFirstLetterIssue(json));
}

@freezed
abstract class RatingsModel with _$RatingsModel {
  const factory RatingsModel({String source, String value}) = _RatingsModel;

  factory RatingsModel.fromJson(Map<String, dynamic> json) =>
      _$RatingsModelFromJson(fixFirstLetterIssue(json));
}

Map<String, dynamic> fixFirstLetterIssue(Map<String, dynamic> json) =>
    json.map((key, value) {
      final lowerCaseFirst = '${key[0].toLowerCase()}${key.substring(1)}';
      return MapEntry(lowerCaseFirst, value);
    });
