import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;

  SeasonModel({required this.airDate, required this.episodeCount, required this.id, required this.name, required this.overview, required this.posterPath, required this.seasonNumber, required this.voteAverage});

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      airDate: json['air_date'] as String,
      episodeCount: json['episode_count'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      seasonNumber: json['season_number'] as int,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'air_date': airDate,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }

  @override
  List<Object?> get props => [airDate, episodeCount, id, name, overview, posterPath, seasonNumber, voteAverage];
}
